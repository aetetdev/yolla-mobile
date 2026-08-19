import 'dart:async';

import 'package:flutter/foundation.dart' show Factory, debugPrint;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../core/geo/polyline.dart';
import '../../../core/map/yolla_map_style.dart';
import '../../../core/models/geo_point.dart';
import '../../../core/models/trip.dart';
import '../../../core/theme/yolla_colors.dart';
import '../../../core/theme/yolla_tokens.dart';
import '../../../core/theme/yolla_typography.dart';
import '../../../l10n/app_localizations.dart';

/// Planın rota görünümü.
///
/// Altlık karolar keşif haritasıyla aynı yerden geliyor (Protomaps self-host,
/// tek `.pmtiles` dosyası). Rota tek bir çizgi katmanı, duraklar tek bir daire
/// katmanı olarak çiziliyor; her durak için ayrı nesne kurmak iki yüz durakta
/// haritanın dokunma işleyişini kilitliyordu (bkz. keşif haritası).
///
/// Atıf lisans gereği haritanın üstünde duruyor.
class TripMap extends StatefulWidget {
  const TripMap({required this.trip, super.key});

  final Trip trip;

  @override
  State<TripMap> createState() => _TripMapState();
}

class _TripMapState extends State<TripMap> {
  static const _routeSourceId = 'yolla-route';
  static const _routeLayerId = 'yolla-route-layer';
  static const _stopSourceId = 'yolla-stops';
  static const _stopLayerId = 'yolla-stops-layer';
  static const _stopLabelLayerId = 'yolla-stops-labels';

  /// Bir harita çağrısının en fazla bekleneceği süre. Platform kanalındaki
  /// bir çağrı yanıt vermezse `await` sonsuza kadar bekler.
  static const _timeout = Duration(seconds: 8);

  /// Jest tanıyıcıları **tek nesne** olarak tutuluyor; her `build`'de yeni bir
  /// küme kurulursa platform görünümü tanıyıcıları yeniden kaydedip o sırada
  /// dokunmaları bırakıyor.
  static final _gestures = <Factory<OneSequenceGestureRecognizer>>{
    Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
  };

  MapLibreMapController? _controller;
  String? _style;

  List<GeoPoint> _route = const [];
  List<GeoPoint> _stops = const [];
  GeoBounds? _bounds;

  @override
  void initState() {
    super.initState();
    _readTrip();
    unawaited(_loadStyle());
  }

  @override
  void didUpdateWidget(TripMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trip == widget.trip) return;

    _readTrip();
    unawaited(_draw());
  }

  void _readTrip() {
    _route = widget.trip.routeGeometry == null
        ? const <GeoPoint>[]
        : Polyline.decode(widget.trip.routeGeometry!);

    _stops = [
      for (final stop in widget.trip.places)
        GeoPoint(
          latitude: stop.place.latitude,
          longitude: stop.place.longitude,
        ),
    ];

    _bounds = GeoBounds.of([..._route, ..._stops]);

    debugPrint(
      '[rota haritası] geometri '
      '${widget.trip.routeGeometry?.length ?? 0} karakter → '
      '${_route.length} nokta, ${_stops.length} durak',
    );
  }

  Future<void> _loadStyle() async {
    final style = await YollaMapStyle.load();
    if (mounted) setState(() => _style = style);
  }

  void _onMapCreated(MapLibreMapController controller) {
    _controller = controller;
  }

  /// Rota ve durakları haritaya yazar, sonra kamerayı hepsini kapsayacak
  /// şekilde konumlandırır.
  Future<void> _draw() async {
    final controller = _controller;
    if (controller == null) return;

    try {
      await _write(controller, _routeSourceId, _routeLineJson());
      await _write(controller, _stopSourceId, _stopPointsJson());
      // Katmanlar da burada tazeleniyor. Eskiden yalnızca stil yüklenirken
      // ekleniyordu: ilk eklemede bir katman düşerse (ya da rota sonradan
      // hesaplanıp geldiğinde katman henüz yoksa) kaynak doluyor ama ekranda
      // hiçbir şey çıkmıyordu. Var olan katmanı yeniden eklemek zararsız.
      await _addLayers(controller);
      await _fitCamera(controller);
    } on TimeoutException {
      debugPrint('[rota haritası] çizim zaman aşımına uğradı');
    } on Object catch (error) {
      debugPrint('[rota haritası] çizilemedi: $error');
    }
  }

  /// Kaynağı günceller; henüz yoksa ekler.
  ///
  /// Bayrak tutmak yerine hatayı yakalamak daha dayanıklı: stil yeniden
  /// yüklendiğinde kaynaklar gidiyor ama bayrak bunu bilmiyor.
  ///
  /// Önce **güncelleme** deneniyor. Ters sırada, var olan bir kaynağa
  /// `addGeoJsonSource` çağrıldığında yerli taraf kaynağı değiştirmiyor;
  /// hata da vermezse veri sessizce eski halinde kalıyor ve rota sonradan
  /// hesaplandığında haritaya hiç düşmüyor.
  Future<void> _write(
    MapLibreMapController controller,
    String sourceId,
    Map<String, dynamic> data,
  ) async {
    try {
      await controller.setGeoJsonSource(sourceId, data).timeout(_timeout);
    } on PlatformException {
      await controller.addGeoJsonSource(sourceId, data).timeout(_timeout);
    }
  }

  Future<void> _addLayers(MapLibreMapController controller) async {
    // Rota çizgisi duraklardan **önce** ekleniyor: sonra eklenen katman üstte
    // çiziliyor, duraklar çizginin altında kalmamalı.
    try {
      await controller
          .addLineLayer(
            _routeSourceId,
            _routeLayerId,
            LineLayerProperties(
              lineColor: _hex(YollaColors.accent),
              lineWidth: 4,
              lineCap: 'round',
              lineJoin: 'round',
            ),
          )
          .timeout(_timeout);
    } on PlatformException catch (error) {
      debugPrint('[rota haritası] çizgi katmanı: ${error.message}');
    }

    try {
      await controller
          .addCircleLayer(
            _stopSourceId,
            _stopLayerId,
            CircleLayerProperties(
              circleRadius: 9,
              circleColor: _hex(YollaColors.brand),
              circleStrokeColor: '#FFFFFF',
              circleStrokeWidth: 2,
            ),
          )
          .timeout(_timeout);
    } on PlatformException catch (error) {
      debugPrint('[rota haritası] durak katmanı: ${error.message}');
    }

    // Durak sırası dairenin içine yazılıyor. Yazı tipi stildeki glif
    // kaynağından geliyor (yer adları da aynısını kullanıyor); `allow-overlap`
    // olmadan yan yana düşen duraklarda numaralar eleniyor.
    try {
      await controller
          .addSymbolLayer(
            _stopSourceId,
            _stopLabelLayerId,
            const SymbolLayerProperties(
              textField: ['get', 'order'],
              textFont: ['Noto Sans Regular'],
              textSize: 10,
              textColor: '#FFFFFF',
              textAllowOverlap: true,
              textIgnorePlacement: true,
            ),
          )
          .timeout(_timeout);
    } on PlatformException catch (error) {
      debugPrint('[rota haritası] numara katmanı: ${error.message}');
    }
  }

  Map<String, dynamic> _routeLineJson() => {
    'type': 'FeatureCollection',
    'features': [
      if (_route.length > 1)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'LineString',
            'coordinates': [
              for (final point in _route) [point.longitude, point.latitude],
            ],
          },
          'properties': <String, dynamic>{},
        },
    ],
  };

  Map<String, dynamic> _stopPointsJson() => {
    'type': 'FeatureCollection',
    'features': [
      for (var i = 0; i < _stops.length; i++)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [_stops[i].longitude, _stops[i].latitude],
          },
          // Rota hesaplanmamışken sıra anlamsız; numara yazılmıyor.
          'properties': {'order': _route.isEmpty ? '' : '${i + 1}'},
        },
    ],
  };

  Future<void> _fitCamera(MapLibreMapController controller) async {
    final bounds = _bounds;
    if (bounds == null) return;

    // Tek duraklı planda sınır kutusu bir noktaya iniyor; `newLatLngBounds`
    // böyle bir kutuyu çözemiyor, o yüzden doğrudan o noktaya gidiliyor.
    if (bounds.latitudeSpan < 1e-6 && bounds.longitudeSpan < 1e-6) {
      await controller
          .animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(bounds.minLatitude, bounds.minLongitude),
              13,
            ),
          )
          .timeout(_timeout);
      return;
    }

    await controller
        .animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(bounds.minLatitude, bounds.minLongitude),
              northeast: LatLng(bounds.maxLatitude, bounds.maxLongitude),
            ),
            left: Space.xl,
            right: Space.xl,
            top: Space.xl,
            bottom: Space.xl,
          ),
        )
        .timeout(_timeout);
  }

  static String _hex(Color color) =>
      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final bounds = _bounds;
    final style = _style;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.md),
      child: SizedBox(
        height: 220,
        child: ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: switch ((bounds, style)) {
            (null, _) => Center(
              child: Text(
                l10n.tripMapNoLocation,
                style: YollaText.caption.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            (_, null) => const Center(child: CircularProgressIndicator()),
            (_, final ready?) => Stack(
              children: [
                MapLibreMap(
                  styleString: ready,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      (bounds!.minLatitude + bounds.maxLatitude) / 2,
                      (bounds.minLongitude + bounds.maxLongitude) / 2,
                    ),
                    zoom: 9,
                  ),
                  onMapCreated: _onMapCreated,
                  onStyleLoadedCallback: () async {
                    final controller = _controller;
                    if (controller == null) return;
                    await _write(
                      controller,
                      _routeSourceId,
                      _routeLineJson(),
                    );
                    await _write(
                      controller,
                      _stopSourceId,
                      _stopPointsJson(),
                    );
                    await _addLayers(controller);
                    await _fitCamera(controller);
                  },
                  // Özet görünümü; kullanıcı planı buradan sürmüyor.
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  compassEnabled: false,
                  gestureRecognizers: _gestures,
                ),

                if (_route.isEmpty)
                  Positioned(
                    left: Space.sm,
                    top: Space.sm,
                    child: _MapNote(text: l10n.tripMapStopsOnly),
                  ),

                // Lisans gereği görünmek zorunda.
                Positioned(
                  left: Space.sm,
                  bottom: Space.sm,
                  child: _MapNote(text: l10n.mapAttribution),
                ),
              ],
            ),
          },
        ),
      ),
    );
  }
}

class _MapNote extends StatelessWidget {
  const _MapNote({required this.text});

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
      child: Text(
        text,
        style: YollaText.micro.copyWith(color: Colors.white),
      ),
    );
  }
}
