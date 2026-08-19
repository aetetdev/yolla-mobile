import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/models/enums.dart';
import '../../core/models/geo_point.dart';
import '../../core/models/trip.dart';

/// Rotayı telefondaki navigasyon uygulamasına devreder.
///
/// Yolla rotayı hesaplıyor ama sesli yönlendirme yapmıyor; kullanıcı yola
/// çıkarken zaten kendi navigasyon uygulamasını açıyor. Bu köprü olmadan
/// hesaplanan sıra kullanıcıya bir işe yaramıyor.
///
/// Her hedefin durak sınırı farklı ve bunlar **sessizce kırpılmıyor** —
/// [NavigationTarget.droppedStops] kaç durağın düştüğünü söylüyor, arayüz de
/// bunu kullanıcıya yazıyor.
enum NavigationApp {
  /// Evrensel `maps.google.com/maps/dir/` adresi. Uygulama kuruluysa o açılır,
  /// değilse tarayıcı. Ara durak desteği en iyi olan hedef.
  googleMaps,

  /// Yandex Haritalar — `rtext` ile çok duraklı rota alıyor.
  yandexMaps,

  /// Yandex Navigasyon — yalnızca tek hedef kabul ediyor.
  yandexNavi,

  /// Apple Haritalar — URL şeması ara durak desteklemiyor.
  appleMaps;

  /// Bu hedefin taşıyabileceği en fazla durak sayısı (başlangıç ve varış dahil).
  ///
  /// Google'ın URL API'si başlangıç ve varış dışında en fazla 9 ara durak
  /// alıyor. Yandex Haritalar'ın `rtext` sınırı pratikte adres uzunluğuna
  /// bağlı; makul bir tavan konuldu.
  int get maxStops => switch (this) {
    NavigationApp.googleMaps => 11,
    NavigationApp.yandexMaps => 10,
    NavigationApp.yandexNavi => 2,
    NavigationApp.appleMaps => 2,
  };
}

/// Bir navigasyon uygulamasına gönderilmeye hazır rota.
@immutable
class NavigationTarget {
  const NavigationTarget({
    required this.app,
    required this.url,
    required this.droppedStops,
  });

  final NavigationApp app;
  final Uri url;

  /// Hedefin sınırı yüzünden aktarılamayan durak sayısı. Sıfırdan büyükse
  /// kullanıcıya söylenmeli.
  final int droppedStops;

  bool get isComplete => droppedStops == 0;
}

/// Plandan navigasyon adresleri üretir.
abstract final class NavigationHandoff {
  /// Planın uğrama sırasına göre koordinatları.
  ///
  /// Rota hesaplanmışsa duraklar zaten en kısa sıraya dizilmiş durumda;
  /// `order` alanına güvenmek yerine listeyi yine de sıralıyoruz, çünkü
  /// sunucu sıralamayı değiştirdiğinde istemcideki liste eski kalabiliyor.
  static List<GeoPoint> stopsOf(Trip trip) {
    final ordered = [...trip.places]..sort((a, b) => a.order.compareTo(b.order));

    return [
      ?trip.startPoint,
      for (final stop in ordered)
        GeoPoint(
          latitude: stop.place.latitude,
          longitude: stop.place.longitude,
        ),
      ?trip.endPoint,
    ];
  }

  /// Cihazda açılabilen hedefleri döndürür.
  ///
  /// Android 11+ paket görünürlüğü kısıtlıyor: `AndroidManifest.xml` içindeki
  /// `<queries>` bloğunda şeması tanımlı olmayan uygulama **kurulu olsa bile**
  /// `canLaunchUrl` false döner.
  static Future<List<NavigationTarget>> available(Trip trip) async {
    final stops = stopsOf(trip);
    if (stops.length < 2) return const [];

    final candidates = <NavigationApp>[
      NavigationApp.googleMaps,
      NavigationApp.yandexMaps,
      NavigationApp.yandexNavi,
      if (defaultTargetPlatform == TargetPlatform.iOS) NavigationApp.appleMaps,
    ];

    final targets = <NavigationTarget>[];

    for (final app in candidates) {
      final target = buildTarget(app, stops, trip.travelMode);

      // Google ve Apple https adresleri her zaman açılabilir (en kötü tarayıcı);
      // özel şemalar yalnızca uygulama kuruluysa.
      final launchable = target.url.scheme == 'https'
          ? true
          : await canLaunchUrl(target.url);

      if (launchable) targets.add(target);
    }

    return targets;
  }

  /// Seçilen hedefi açar. Açılamazsa `false` döner.
  static Future<bool> open(NavigationTarget target) {
    return launchUrl(target.url, mode: LaunchMode.externalApplication);
  }

  @visibleForTesting
  static NavigationTarget buildTarget(
    NavigationApp app,
    List<GeoPoint> stops,
    TravelMode travelMode,
  ) {
    final trimmed = _trim(stops, app.maxStops);
    final dropped = stops.length - trimmed.length;

    return NavigationTarget(
      app: app,
      url: switch (app) {
        NavigationApp.googleMaps => _google(trimmed, travelMode),
        NavigationApp.yandexMaps => _yandexMaps(trimmed, travelMode),
        NavigationApp.yandexNavi => _yandexNavi(trimmed),
        NavigationApp.appleMaps => _apple(trimmed, travelMode),
      },
      droppedStops: dropped,
    );
  }

  /// Sınırı aşan planlarda **baştaki ve sondaki korunur**, ortadan atılır.
  ///
  /// Kullanıcının nereden çıkıp nereye vardığı, aradaki bir durağı görmekten
  /// daha önemli.
  static List<GeoPoint> _trim(List<GeoPoint> stops, int limit) {
    if (stops.length <= limit) return stops;

    final keepMiddle = limit - 2;
    final middle = stops.sublist(1, stops.length - 1);

    // Ortadaki durakları eşit aralıklarla seyreltiyoruz ki rota şeklini korusun.
    final step = middle.length / keepMiddle;
    final picked = [
      for (var i = 0; i < keepMiddle; i++) middle[(i * step).floor()],
    ];

    return [stops.first, ...picked, stops.last];
  }

  static String _pair(GeoPoint p) => '${_coord(p.latitude)},${_coord(p.longitude)}';

  /// Koordinatı altı ondalığa yuvarlar (~11 cm).
  ///
  /// Doğrudan `toString` kullanılırsa kayan nokta artıkları adrese giriyor
  /// (`28.919999999999998`); adres hem gereksiz uzuyor hem de bazı uygulamalar
  /// aşırı hassasiyette takılıyor.
  static String _coord(double value) {
    // Sondaki sıfırları at: "41.020000" yerine "41.02".
    final trimmed = value.toStringAsFixed(6).replaceFirst(RegExp(r'0+$'), '');

    // Ondalık kısmın tamamı sıfırsa bir basamak bırakılıyor: adreslerde çiftler
    // virgülle ayrıldığı için "41,28.9" okunması zor, "41.0,28.9" net.
    return trimmed.endsWith('.') ? '${trimmed}0' : trimmed;
  }

  static Uri _google(List<GeoPoint> stops, TravelMode mode) {
    return Uri.https('www.google.com', '/maps/dir/', {
      'api': '1',
      'origin': _pair(stops.first),
      'destination': _pair(stops.last),
      if (stops.length > 2)
        'waypoints': stops
            .sublist(1, stops.length - 1)
            .map(_pair)
            .join('|'),
      'travelmode': mode == TravelMode.foot ? 'walking' : 'driving',
    });
  }

  static Uri _yandexMaps(List<GeoPoint> stops, TravelMode mode) {
    return Uri.parse(
      'yandexmaps://maps.yandex.com/?'
      'rtext=${stops.map(_pair).join('~')}'
      '&rtt=${mode == TravelMode.foot ? 'pd' : 'auto'}',
    );
  }

  static Uri _yandexNavi(List<GeoPoint> stops) {
    final from = stops.first;
    final to = stops.last;

    return Uri.parse(
      'yandexnavi://build_route_on_map'
      '?lat_from=${from.latitude}&lon_from=${from.longitude}'
      '&lat_to=${to.latitude}&lon_to=${to.longitude}',
    );
  }

  static Uri _apple(List<GeoPoint> stops, TravelMode mode) {
    return Uri.https('maps.apple.com', '/', {
      'saddr': _pair(stops.first),
      'daddr': _pair(stops.last),
      'dirflg': mode == TravelMode.foot ? 'w' : 'd',
    });
  }
}
