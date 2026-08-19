import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/core/models/enums.dart';
import 'package:yolla/core/models/geo_point.dart';
import 'package:yolla/features/trips/navigation_handoff.dart';

List<GeoPoint> _stops(int count) => [
  for (var i = 0; i < count; i++)
    GeoPoint(latitude: 41.0 + i / 100, longitude: 28.9 + i / 100),
];

void main() {
  group('Google Haritalar', () {
    test('ara durakları waypoints ile taşır', () {
      final target = NavigationHandoff.buildTarget(
        NavigationApp.googleMaps,
        _stops(4),
        TravelMode.car,
      );

      final query = target.url.queryParameters;

      expect(query['origin'], '41.0,28.9');
      expect(query['destination'], '41.03,28.93');
      expect(query['waypoints'], '41.01,28.91|41.02,28.92');
      expect(query['travelmode'], 'driving');
      expect(target.droppedStops, 0);
    });

    test('yürüme planında travelmode walking olur', () {
      final target = NavigationHandoff.buildTarget(
        NavigationApp.googleMaps,
        _stops(2),
        TravelMode.foot,
      );

      expect(target.url.queryParameters['travelmode'], 'walking');
    });

    test('iki duraklı planda waypoints hiç eklenmez', () {
      final target = NavigationHandoff.buildTarget(
        NavigationApp.googleMaps,
        _stops(2),
        TravelMode.car,
      );

      expect(target.url.queryParameters.containsKey('waypoints'), isFalse);
    });

    test('sınırı aşan planda ilk ve son durak korunur', () {
      const total = 20;
      final target = NavigationHandoff.buildTarget(
        NavigationApp.googleMaps,
        _stops(total),
        TravelMode.car,
      );

      final query = target.url.queryParameters;
      final waypoints = query['waypoints']!.split('|');

      // Google'ın sınırı 11 durak: başlangıç + 9 ara + varış.
      expect(waypoints, hasLength(9));
      expect(query['origin'], '41.0,28.9');
      expect(query['destination'], '41.19,29.09');
      expect(target.droppedStops, total - NavigationApp.googleMaps.maxStops);
      expect(target.isComplete, isFalse);
    });
  });

  group('Yandex', () {
    test('Haritalar rtext ile bütün durakları alır', () {
      final target = NavigationHandoff.buildTarget(
        NavigationApp.yandexMaps,
        _stops(3),
        TravelMode.foot,
      );

      expect(target.url.scheme, 'yandexmaps');
      expect(
        target.url.toString(),
        contains('rtext=41.0,28.9~41.01,28.91~41.02,28.92'),
      );
      // Yürüyüş profili.
      expect(target.url.toString(), contains('rtt=pd'));
    });

    test('Navigasyon tek hedef aldığı için aradakiler düşer', () {
      final target = NavigationHandoff.buildTarget(
        NavigationApp.yandexNavi,
        _stops(5),
        TravelMode.car,
      );

      expect(target.url.scheme, 'yandexnavi');
      expect(target.url.toString(), contains('lat_from=41.0'));
      expect(target.url.toString(), contains('lat_to=41.04'));
      expect(target.droppedStops, 3);
    });
  });

  group('Apple Haritalar', () {
    test('yalnızca başlangıç ve varışı taşır', () {
      final target = NavigationHandoff.buildTarget(
        NavigationApp.appleMaps,
        _stops(4),
        TravelMode.foot,
      );

      final query = target.url.queryParameters;

      expect(target.url.host, 'maps.apple.com');
      expect(query['saddr'], '41.0,28.9');
      expect(query['daddr'], '41.03,28.93');
      expect(query['dirflg'], 'w');
      expect(target.droppedStops, 2);
    });
  });
}
