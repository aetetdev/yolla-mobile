import 'dart:async';
import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show Factory, debugPrint, debugPrintStack, visibleForTesting;
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../app/routes.dart';
import '../../core/map/yolla_map_style.dart';
import '../../core/models/enums.dart';
import '../../core/models/place_pin.dart';
import '../../core/models/swipe.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../trips/trips_service.dart';
import 'discovery_service.dart';
import 'map_service.dart';

/// Keşif sekmesinin ana ekranı: harita.
///
/// Kullanıcının konumu ve çevresindeki turistik yerler işaret olarak
/// gösteriliyor. Harita kaydırıldıkça ya da uzaklaştırıldıkça görünen alan
/// için yeni işaretler çekiliyor.
///
/// Altlık karolar **kendi sunucumuzdan** geliyor (Protomaps, tek .pmtiles
/// dosyası): API anahtarı yok, istek başına ücret yok. OpenStreetMap atfı
/// haritanın üstünde sabit duruyor — lisans gereği görünmek zorunda.
class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();

  /// Dokunulan harita nesnesinin kimliğinden yer kimliğini çıkarır.
  ///
  /// İşaretler GeoJSON'a `id` alanıyla yazılıyor ve eklenti dokunmada bu
  /// kimliği geri veriyor. Platform kimliği bazen metin, bazen sayı olarak
  /// taşıyor; ikisi de karşılanıyor.
  @visibleForTesting
  static int? placeIdOf(Object? featureId) => switch (featureId) {
    final int id => id,
    final num id => id.toInt(),
    final String id => int.tryParse(id),
    _ => null,
  };
}

class _MapPageState extends ConsumerState<MapPage> {
  MapLibreMapController? _controller;

  /// Görünen işaretler, kimliğe göre. Haritaya dokunulduğunda altındaki
  /// nesnenin hangi yere ait olduğu buradan bulunuyor.
  final _pinsById = <int, PlacePin>{};

  /// İşaret katmanının kimlikleri.
  ///
  /// İşaretler tek bir GeoJSON kaynağı ve tek bir daire katmanı olarak
  /// çiziliyor. Önce annotation API'si (`addCircles`) kullanılıyordu: her
  /// işaret için ayrı bir nesne ve ayrı jest kaydı tutuyor, iki yüz tanesi
  /// haritanın dokunma işleyişini kilitliyordu — ilk kaydırmadan sonra harita
  /// tamamen ölüyordu. Tek katman, işaret sayısından bağımsız çalışıyor.
  static const _pinSourceId = 'yolla-pins';
  static const _pinLayerId = 'yolla-pins-layer';

  bool _pinLayerReady = false;

  String? _style;
  MapBounds? _loadedBounds;
  bool _isLoadingPins = false;
  bool _hasLocationPermission = false;
  PlacePin? _selected;

  /// Bu oturumda haritadan beğenilenler — kart "beğenildi" olarak görünsün.
  final _likedPinIds = <int>{};

  /// Beğeni isteği süren yer.
  int? _likingPinId;

  /// Kamera durduktan sonra sorguyu geciktiren zamanlayıcı.
  Timer? _debounce;

  /// Haritanın kapladığı alan (mantıksal piksel).
  ///
  /// Yerleşim sırasında yazılıyor; görünen coğrafi alan bundan ve kamera
  /// konumundan hesaplanıyor. Zamanlayıcıdan `MediaQuery`'ye bakmak yerine
  /// burada saklamak, `build` dışında bağlam bağımlılığı kaydetmeyi önlüyor.
  Size? _viewport;

  /// Türkiye'nin ortası. Konum izni yoksa ya da konum gelmeden önce burası
  /// gösteriliyor; boş okyanusa bakmaktan iyi.
  static const _fallback = LatLng(39.0, 35.0);

  /// Jest tanıyıcıları **tek nesne** olarak tutuluyor.
  ///
  /// Her `build` içinde yeni bir küme kurulursa platform görünümü tanıyıcıları
  /// yeniden kaydediyor ve o sırada dokunmaları bırakıyor: harita ilk
  /// kaydırmadan sonra ölüyordu (işaretler yüklenince `setState` çalışıyor,
  /// widget yeniden kuruluyor, küme değişiyor).
  static final _gestures = <Factory<OneSequenceGestureRecognizer>>{
    Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
  };

  @override
  void initState() {
    super.initState();
    unawaited(_loadStyle());
    unawaited(_askLocation());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadStyle() async {
    final style = await YollaMapStyle.load();
    if (mounted) setState(() => _style = style);
  }

  Future<void> _askLocation() async {
    // İzin reddedilirse harita çalışmaya devam ediyor; yalnızca kendi konumun
    // görünmüyor. Akışı izne bağlamak, izni ilk açılışta reddeden kullanıcıyı
    // uygulamadan tamamen dışarıda bırakırdı.
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final granted =
        permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;

    if (!mounted) return;
    setState(() => _hasLocationPermission = granted);

    if (granted) unawaited(_goToMyLocation());
  }

  Future<void> _goToMyLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );

      await _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          13,
        ),
      );
    } on Object {
      // Konum alınamadı (kapalı alan, servis kapalı). Harita olduğu yerde
      // kalıyor, kullanıcı elle gezinebiliyor.
    }
  }

  void _onMapCreated(MapLibreMapController controller) {
    _controller = controller;
    controller.onFeatureTapped.add(_onFeatureTapped);
  }

  /// Bir işarete dokunulduğunda çalışır.
  ///
  /// Eklenti, dokunma etkileşimli bir katmandaki nesneye denk gelirse
  /// `onMapClick` **göndermiyor**, bunun yerine bu geri çağrıyı tetikliyor.
  /// Önce `onMapClick` dinleniyordu; boş yere dokunmak ulaşıyor, işarete
  /// dokunmak hiç ulaşmıyordu.
  void _onFeatureTapped(
    Point<double> point,
    LatLng coordinates,
    String featureId,
    String layerId,
    Annotation? annotation,
  ) {
    if (layerId != _pinLayerId) return;

    final pin = _pinsById[MapPage.placeIdOf(featureId) ?? -1];
    debugPrint('[harita] nesneye dokunuldu: $featureId → ${pin?.name}');
    if (pin == null) return;

    setState(() => _selected = pin);
  }

  /// Haritaya dokunulduğunda çalışır.
  ///
  /// Eklenti, dokunma etkileşimli bir katmandaki nesneye denk gelirse
  /// [_onFeatureTapped]'i tetikleyip buraya hiç düşmüyor — **çalıştığında**.
  /// O yol platform tarafında sessizce kaybolabildiği için burada aynı işi
  /// yapan bir yedek var: dokunulan noktanın yakınında bir işaret varsa
  /// kart yine açılıyor. İki yol da aynı sonucu ürettiği için hangisinin
  /// tetiklendiği kullanıcı açısından fark etmiyor.
  void _onMapClick(Point<double> point, LatLng latLng) {
    debugPrint('[harita] boşluğa dokunuldu (seçili: ${_selected?.name})');
    final pin = _pinNear(latLng);
    if (pin != null) {
      debugPrint('[harita] yakın işaret seçildi: ${pin.name}');
      setState(() => _selected = pin);
      return;
    }

    if (_selected != null) setState(() => _selected = null);
  }

  /// Dokunulan noktanın parmak payı içindeki işaret.
  ///
  /// Karşılaştırma derece değil **ekran pikseli** üzerinden yapılıyor: bir
  /// derecelik boylam farkı enleme ve yakınlaştırmaya göre çok değişik
  /// mesafelere denk geliyor, sabit bir derece eşiği kuzeyde ve yakın
  /// yakınlaştırmada tutarsız davranırdı.
  PlacePin? _pinNear(LatLng latLng) {
    final controller = _controller;
    final size = _viewport;
    if (controller == null || size == null || size.isEmpty) return null;
    if (_pinsById.isEmpty) return null;

    final bounds = _visibleBounds(controller);
    if (bounds == null) return null;

    final lngPerPixel = (bounds.east - bounds.west) / size.width;
    final latPerPixel = (bounds.north - bounds.south) / size.height;
    if (lngPerPixel == 0 || latPerPixel == 0) return null;

    // İşaretin yarıçapı 7; kalanı parmak payı.
    const touchRadius = 28.0;

    PlacePin? nearest;
    var nearestDistance = double.infinity;

    for (final pin in _pinsById.values) {
      final dx = (pin.longitude - latLng.longitude) / lngPerPixel;
      final dy = (pin.latitude - latLng.latitude) / latPerPixel;
      final distance = dx * dx + dy * dy;

      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearest = pin;
      }
    }

    return nearestDistance <= touchRadius * touchRadius ? nearest : null;
  }


  /// Haritadan beğenme.
  ///
  /// Kart destesindeki sağa kaydırmayla **aynı** kaydı üretiyor: yer
  /// beğenilenlere düşüyor ve oradan plan kurulabiliyor. Ayrı bir "harita
  /// beğenisi" kavramı üretmemek, iki listeyi ayrı tutma derdinden kurtarıyor.
  Future<void> _like(PlacePin pin) async {
    final l10n = L10n.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _likingPinId = pin.id);

    try {
      await ref.read(discoveryServiceProvider).recordSwipes([
        SwipeRecord(
          placeId: pin.id,
          direction: SwipeDirection.like,
          // Harita şehir içi keşif sayılıyor; koridor modunun kendi akışı var.
          context: SwipeContext.city,
        ),
      ]);

      // Beğenilenler listesi açıksa eski halini göstermesin.
      ref.invalidate(likedPlacesProvider);

      if (!mounted) return;
      setState(() => _likedPinIds.add(pin.id));
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.mapPinLiked(pin.name)),
          action: SnackBarAction(
            label: l10n.mapPinGoToLiked,
            onPressed: _openPlanning,
          ),
        ),
      );
    } on ApiException catch (error) {
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _likingPinId = null);
    }
  }

  /// Haritada beğenilenlerle plan kurmaya götürür.
  ///
  /// Beğenilenler ekranı plan kurmanın olduğu yer; burada ikinci bir plan
  /// akışı açmak yerine oraya hangi yerlerin işaretli geleceği söyleniyor.
  void _openPlanning() =>
      context.push(Routes.likedFor(null, preselect: _likedPinIds));

  /// Alt şeridin götürdüğü yer.
  ///
  /// Haritada bir şey beğenildiyse doğrudan plan kurmaya gidiyor; hiçbir şey
  /// beğenilmediyse plana koyacak bir şey yok, eski davranış olan mod seçimi
  /// kalıyor.
  void _enter() {
    if (_likedPinIds.isEmpty) {
      context.push(Routes.modePicker);
      return;
    }

    _openPlanning();
  }

  /// Kamera durunca çalışır. Her küçük kaymada sunucuya gitmemek için
  /// hem gecikme hem de "alan yeterince değişti mi" kontrolü var.
  void _onCameraIdle() {
    debugPrint('[harita] kamera durdu');
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), _reloadPins);
  }

  /// Bir harita çağrısının en fazla bekleneceği süre.
  ///
  /// Platform kanalındaki bir çağrı yanıt vermezse `await` sonsuza kadar
  /// bekliyor: yükleme bayrağı açık kalıyor, sonraki bütün yenilemeler baştan
  /// dönüyor ve harita cevap veremez hale geliyor. Süre sınırı bu kilidi
  /// kırıyor — yenileme başarısız sayılıp bir sonraki kamera durmasında
  /// yeniden deneniyor.
  static const _mapCallTimeout = Duration(seconds: 8);

  /// Görünen alanı kamera durumundan hesaplar.
  ///
  /// Eskiden burada `controller.getVisibleRegion()` vardı: her kaydırmada
  /// platform kanalından Android arayüz iş parçacığına gidip native harita
  /// nesnesinden kilitli okuma yapan bir çağrı. Kilit bir kez tutulduğunda
  /// arayüz iş parçacığı donuyordu — harita kaydırmayı ve dokunmayı bırakıyor,
  /// yenileme de ilk `await`'te asılı kalıyordu. `/places/in-bounds`'un tam
  /// olarak bir kez çağrılmasının sebebi buydu; sonraki her yenileme aynı
  /// çağrıda kilitleniyordu.
  ///
  /// Kamera konumu `trackCameraPosition: true` sayesinde zaten elimizde,
  /// ekran boyutu da öyle. Aynı sonuç tek bir platform çağrısı yapmadan
  /// üretilebiliyor.
  MapBounds? _visibleBounds(MapLibreMapController controller) {
    final camera = controller.cameraPosition;
    final size = _viewport;
    if (camera == null || size == null || size.isEmpty) return null;

    return MapBounds.fromCamera(
      latitude: camera.target.latitude,
      longitude: camera.target.longitude,
      zoom: camera.zoom,
      width: size.width,
      height: size.height,
    );
  }

  Future<void> _reloadPins() async {
    final controller = _controller;
    if (controller == null) {
      debugPrint('[harita] yenileme atlandı: denetleyici yok');
      return;
    }
    if (_isLoadingPins) {
      debugPrint('[harita] yenileme atlandı: önceki yükleme sürüyor');
      return;
    }

    // Bayrak en baştan kalkıyor: erken dönüşlerde bile açık kalmasın diye
    // bütün gövde try/finally içinde.
    _isLoadingPins = true;

    try {
      await _loadPinsInto(controller);
    } on TimeoutException {
      debugPrint('[harita] yenileme zaman aşımına uğradı; bir sonraki '
          'kamera durmasında tekrar denenecek.');
    } on Object catch (error, stack) {
      // Sessizce yutmak bu hatayı günlerce gizledi.
      debugPrint('[harita] işaretler yüklenemedi: $error');
      debugPrintStack(stackTrace: stack);
    } finally {
      // Bayrak `mounted` kontrolünün **dışında** sıfırlanıyor. İçeride
      // olduğunda, widget ağaçtan çıkmış bir anda biten tek bir yükleme
      // kilidi kalıcı olarak açık bırakıyordu: sonraki bütün yenilemeler
      // "önceki yükleme sürüyor" diyip geri dönüyordu.
      _isLoadingPins = false;
      if (mounted) setState(() {});
    }
  }

  Future<void> _loadPinsInto(MapLibreMapController controller) async {
    final bounds = _visibleBounds(controller);
    if (bounds == null) {
      debugPrint('[harita] yenileme atlandı: kamera konumu henüz yok');
      return;
    }

    final previous = _loadedBounds;
    if (previous != null && bounds.isCloseTo(previous)) {
      debugPrint('[harita] yenileme atlandı: alan yeterince değişmedi');
      return;
    }

    // Yükleme göstergesi bu yeniden kurulumla görünüyor.
    if (mounted) setState(() {});

    debugPrint('[harita] işaretler isteniyor: $bounds');
    final pins = await ref.read(mapServiceProvider).pinsInBounds(
      bounds.padded(),
    );
    debugPrint('[harita] ${pins.length} işaret geldi');

    if (!mounted) return;

    _pinsById
      ..clear()
      ..addEntries(pins.map((p) => MapEntry(p.id, p)));

    await _writePins(controller, pins);
    _loadedBounds = bounds;
    debugPrint('[harita] işaretler haritaya yazıldı');
  }

  /// Haritayı kurar.
  ///
  /// Burada bir ara **widget önbelleği** vardı: kimlik değişmediyse her
  /// `build`'de aynı `MapLibreMap` **nesnesi** döndürülüyordu. Amaç haritayı
  /// gereksiz yere yeniden kurmamaktı ama sonucu çok daha ağırdı: Flutter,
  /// bir çocuk widget'ı öncekiyle aynı nesne olduğunda o dalı güncellemeden
  /// atlıyor ve alt ağaç yeniden yerleşmiyor. Bu yüzden `setState` sonrası
  /// hiçbir düzen değişikliği ekrana yansımıyordu — dokunulan işaretin kartı
  /// widget ağacına giriyor, `build` metodu çalışıyor, ama ne kart çiziliyor
  /// ne de haritanın ona yer açması gerekiyordu.
  ///
  /// Önbelleksiz de harita yeniden kurulmuyor: widget yeniden yaratılsa da
  /// aynı tipte ve aynı konumda olduğu için platform görünümü korunuyor,
  /// eklenti yalnızca `didUpdateWidget` ile seçenekleri karşılaştırıyor ve
  /// değişiklik yoksa hiçbir şey yapmıyor.
  Widget _buildMap(String style) {
    return MapLibreMap(
      styleString: style,
      initialCameraPosition: const CameraPosition(
        target: _fallback,
        zoom: 5.5,
      ),
      myLocationEnabled: _hasLocationPermission,
      trackCameraPosition: true,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: () {
        // Stil yeniden yüklenince katman da gider; baştan kurulmalı.
        _pinLayerReady = false;
        _loadedBounds = null;
        unawaited(_reloadPins());
      },
      onCameraIdle: _onCameraIdle,
      onMapClick: _onMapClick,
      // Pusula ve ölçek yeterli; eğme/döndürme keşif haritasında kullanıcıyı
      // kaybettiriyor.
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      // Bu tanım olmadan dokunma olayları Flutter'ın jest arenasında kalıyor
      // ve haritaya hiç ulaşmıyor.
      gestureRecognizers: _gestures,
    );
  }

  /// İşaretleri GeoJSON kaynağına yazar; katman yoksa kurar.
  Future<void> _writePins(
    MapLibreMapController controller,
    List<PlacePin> pins,
  ) async {
    final data = <String, dynamic>{
      'type': 'FeatureCollection',
      'features': [
        for (final pin in pins)
          {
            'type': 'Feature',
            // Dokunmada eklenti bu kimliği geri veriyor.
            'id': pin.id,
            'geometry': {
              'type': 'Point',
              'coordinates': [pin.longitude, pin.latitude],
            },
            'properties': {
              'placeId': pin.id,
              'hasPhoto': pin.hasPhoto,
            },
          },
      ],
    };

    if (_pinLayerReady) {
      await controller
          .setGeoJsonSource(_pinSourceId, data)
          .timeout(_mapCallTimeout);
      return;
    }

    // Kaynak zaten duruyorsa (stil yeniden yüklenmeden bayrak sıfırlandıysa)
    // ikinci kez eklemek platform tarafında hata veriyor ve katman bir daha
    // hiç kurulamıyordu: her yenileme aynı hataya çarpıyor, bayrak hep kapalı
    // kalıyordu. Var olan kaynağı güncellemek yeterli.
    try {
      await controller
          .addGeoJsonSource(_pinSourceId, data)
          .timeout(_mapCallTimeout);
    } on PlatformException catch (error) {
      debugPrint('[harita] kaynak eklenemedi, güncelleniyor: ${error.message}');
      await controller
          .setGeoJsonSource(_pinSourceId, data)
          .timeout(_mapCallTimeout);
    }

    // Katman da kaynak gibi: bayrağımız ile stilin gerçek durumu ayrışabiliyor
    // (stil yeniden yüklendiğinde bayrak sıfırlanıyor ama katman yerinde
    // kalabiliyor). İkinci ekleme denemesi `CannotAddLayerException` atıyor ve
    // yakalanmazsa her yenileme aynı hataya çarpıp işaretleri hiç
    // güncelleyemiyordu.
    try {
      await controller
          .addCircleLayer(
            _pinSourceId,
            _pinLayerId,
            CircleLayerProperties(
              circleRadius: 7,
              // Fotoğrafsız yerler farklı renkte: kullanıcı bunlara dokununca
              // "fotoğraf ekle" çağrısıyla karşılaşacak. Renk veriden
              // seçiliyor, her işaret için ayrı nesne kurulmuyor.
              circleColor: [
                'case',
                ['get', 'hasPhoto'],
                _hex(YollaColors.brand),
                _hex(YollaColors.accent),
              ],
              circleStrokeColor: '#FFFFFF',
              circleStrokeWidth: 2,
            ),
          )
          .timeout(_mapCallTimeout);
    } on PlatformException catch (error) {
      debugPrint('[harita] katman zaten duruyor: ${error.message}');
    }

    _pinLayerReady = true;
  }

  static String _hex(Color color) =>
      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final style = _style;

    // Görünen coğrafi alan bu ölçüden hesaplanıyor. Harita ekranı kapladığı
    // için `MediaQuery` yeterince doğru; istek zaten `padded()` ile
    // genişletiliyor.
    //
    // Burada bir ara `LayoutBuilder` kullanılıyordu. Ölçüyü daha kesin
    // veriyordu ama yığının tamamını **yerleşim aşamasında** kuruyordu ve o
    // hâlde kare tamamlanmıyordu: `setState` sonrası `build` çalışmasına
    // rağmen kare sonu geri çağrıları hiç tetiklenmiyor, sonradan eklenen
    // hiçbir şey (işaret kartı, modal yaprağın içeriği) ekrana çıkmıyordu.
    _viewport = MediaQuery.sizeOf(context);

    return Scaffold(
      body: style == null
          ? Center(child: YollaLoader(label: l10n.mapPreparing))
          : _buildStack(style, l10n),
    );
  }

  Widget _buildStack(String style, L10n l10n) {
    return Stack(
      children: [
        _buildMap(style),

        if (_isLoadingPins)
          const Positioned(
            top: Space.sm,
            right: Space.sm,
            child: YollaLoader(size: 44),
          ),

        if (_hasLocationPermission)
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Space.lg),
                child: FloatingActionButton.small(
                  heroTag: 'konumum',
                  onPressed: _goToMyLocation,
                  child: const Icon(Icons.my_location),
                ),
              ),
            ),
          ),

        // Alt bölge tek parça ve ekranın altına sabitli. `mainAxisSize.min`
        // olduğu için kart eklendiğinde yalnızca üstüne doğru büyüyor.
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Space.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_selected case final pin?) ...[
                    _PinCard(
                      pin: pin,
                      isLiked: _likedPinIds.contains(pin.id),
                      isLiking: _likingPinId == pin.id,
                      onClose: () => setState(() => _selected = null),
                      onDetail: () => context.push(Routes.placeFor(pin.id)),
                      onLike: () => _like(pin),
                    ),
                    const SizedBox(height: Space.md),
                  ],

                  // Lisans gereği görünmek zorunda. "Gir" şeridinin üstünde
                  // duruyor; altına konduğunda düğmenin arkasında kalıyordu.
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _Badge(text: l10n.mapAttribution),
                  ),
                  const SizedBox(height: Space.sm),
                  _EnterBar(
                    likedCount: _likedPinIds.length,
                    onPressed: _enter,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Harita üstündeki küçük bilgi şeridi.
class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Space.sm,
        vertical: Space.xxs + 1,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(Radii.sm),
      ),
      child: Text(text, style: YollaText.micro.copyWith(color: Colors.white)),
    );
  }
}

/// Dokunulan işaretin özeti.
class _PinCard extends StatelessWidget {
  const _PinCard({
    required this.pin,
    required this.isLiked,
    required this.isLiking,
    required this.onClose,
    required this.onDetail,
    required this.onLike,
  });

  final PlacePin pin;
  final bool isLiked;
  final bool isLiking;
  final VoidCallback onClose;
  final VoidCallback onDetail;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Space.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Radii.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        // Kart yüksekliğini **içeriği** belirliyor.
        //
        // Varsayılan `MainAxisSize.max` ile kart, içinde bulunduğu sütunda
        // esnek olmayan bir çocuk olarak kalan yüksekliğin tamamını istiyor;
        // haritanın `Expanded`'ına yer kalmıyor ve yerleşim çözülemediği için
        // kart ekranda hiç belirmiyordu. Kartın widget ağacına girip `build`
        // metodunun çalışmasına rağmen görünmemesinin sebebi buydu.
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  pin.name,
                  style: YollaText.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close_rounded),
                tooltip: l10n.commonClose,
              ),
            ],
          ),
          if (!pin.hasPhoto)
            Text(
              l10n.mapPinNoPhoto,
              style: YollaText.micro.copyWith(color: YollaColors.accent),
            ),
          const SizedBox(height: Space.md),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: isLiked || isLiking ? null : onLike,
                  icon: isLiking
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 18,
                        ),
                  label: Text(
                    isLiked ? l10n.mapPinLikedShort : l10n.mapPinLike,
                  ),
                ),
              ),
              const SizedBox(width: Space.sm),
              // Genişlik sınırı **yerel olarak** gevşetiliyor.
              //
              // Uygulama teması bütün dolu düğmelere
              // `minimumSize: Size.fromHeight(52)` veriyor; bu, genişliği
              // `double.infinity` demek. Tam ekran genişliğinde duran
              // düğmelerde istenen şey bu, ama satır içinde **esnek olmayan**
              // bir çocuk olarak sonsuz genişlik istendiğinde satır çözülemiyor
              // ve kartın tamamı sessizce çizilmiyordu — hata da vermiyordu.
              // Yandaki "beğen" düğmesi `Expanded` içinde olduğu için parent
              // genişliği sınırlıyor ve o etkilenmiyordu.
              FilledButton.tonal(
                onPressed: onDetail,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 52),
                ),
                child: Text(l10n.mapPinDetail),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Alttaki "Gir" şeridi — rota kurma akışına giriş.
/// Haritanın altındaki ana düğme.
///
/// İki hali var: haritada hiçbir şey beğenilmemişken keşfe giriş ("Gir"),
/// beğenildiğinde doğrudan plan kurma. İkinci hal aynı zamanda geri bildirim —
/// kullanıcı kaç yer topladığını düğmenin üstünde görüyor.
class _EnterBar extends StatelessWidget {
  const _EnterBar({required this.likedCount, required this.onPressed});

  final int likedCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final hasLiked = likedCount > 0;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(
          hasLiked ? Icons.playlist_add_check_rounded : Icons.route_rounded,
        ),
        label: Text(
          hasLiked ? l10n.mapPlanWithLiked(likedCount) : l10n.mapEnter,
        ),
      ),
    );
  }
}
