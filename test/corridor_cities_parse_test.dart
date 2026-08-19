import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/core/models/feed_page.dart';

/// Koridor şehir listesi sunucudan olduğu gibi çözülüyor. Sıra **sunucudan**
/// geliyor (yol boyunca `progress`), istemci yeniden sıralamıyor; bu yüzden
/// listenin geldiği düzende kaldığı da sabitleniyor.
void main() {
  group('CorridorCities.fromJson', () {
    test('şehirleri ve rota bilgisini çözer', () {
      final result = CorridorCities.fromJson({
        'cities': [
          {
            'cityId': 34,
            'name': 'İstanbul',
            'placeCount': 12,
            'progress': 0.02,
          },
          {
            'cityId': 26,
            'name': 'Eskişehir',
            'placeCount': 5,
            'progress': 0.41,
          },
        ],
        'routeDistanceMeters': 371100.0,
        'routeDurationSeconds': 14400.0,
        'routeGeometry': 'abc',
      });

      expect(result.cities, hasLength(2));
      expect(result.cities.first.name, 'İstanbul');
      expect(result.cities.first.cityId, 34);
      expect(result.cities.first.placeCount, 12);
      expect(result.routeDistanceMeters, 371100.0);
      expect(result.routeGeometry, 'abc');
    });

    test('geldiği sırayı korur', () {
      final result = CorridorCities.fromJson({
        'cities': [
          {'cityId': 3, 'name': 'Üçüncü', 'placeCount': 1, 'progress': 0.9},
          {'cityId': 1, 'name': 'Birinci', 'placeCount': 1, 'progress': 0.1},
        ],
        'routeDistanceMeters': 1.0,
        'routeDurationSeconds': 1.0,
      });

      expect(
        result.cities.map((city) => city.name),
        ['Üçüncü', 'Birinci'],
      );
    });

    test('şehir listesi boş gelebilir', () {
      final result = CorridorCities.fromJson({
        'routeDistanceMeters': 10.0,
        'routeDurationSeconds': 20.0,
      });

      expect(result.cities, isEmpty);
      expect(result.routeGeometry, isNull);
    });

    test('tam sayı gelen mesafeyi ondalığa çevirir', () {
      // Sunucu bu alanları bazen tam sayı olarak döndürüyor; `double`
      // beklerken `int` gelmesi çözümlemeyi patlatıyordu.
      final result = CorridorCities.fromJson({
        'cities': const <Map<String, dynamic>>[],
        'routeDistanceMeters': 371100,
        'routeDurationSeconds': 14400,
      });

      expect(result.routeDistanceMeters, 371100.0);
      expect(result.routeDurationSeconds, 14400.0);
    });
  });
}
