import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/core/geo/polyline.dart';
import 'package:yolla/core/models/geo_point.dart';

void main() {
  group('Polyline.decode', () {
    test('bilinen örneği çözer', () {
      // Google'ın belgelerindeki referans dizi.
      final points = Polyline.decode('_p~iF~ps|U_ulLnnqC_mqNvxq`@');

      expect(points, hasLength(3));
      expect(points[0].latitude, closeTo(38.5, 0.00001));
      expect(points[0].longitude, closeTo(-120.2, 0.00001));
      expect(points[1].latitude, closeTo(40.7, 0.00001));
      expect(points[1].longitude, closeTo(-120.95, 0.00001));
      expect(points[2].latitude, closeTo(43.252, 0.00001));
      expect(points[2].longitude, closeTo(-126.453, 0.00001));
    });

    test('tek nokta çözer', () {
      final points = Polyline.decode('_p~iF~ps|U');
      expect(points, hasLength(1));
      expect(points.single.latitude, closeTo(38.5, 0.00001));
    });

    test('boş girdide boş liste döner', () {
      expect(Polyline.decode(''), isEmpty);
    });

    test('yarıda kesilmiş girdide çöker değil, çözülenleri döndürür', () {
      // İlk nokta tam, ikincinin boylamı eksik.
      final points = Polyline.decode('_p~iF~ps|U_ulL');
      expect(points, hasLength(1));
    });

    test('negatif ve pozitif farkları birlikte çözer', () {
      final original = [
        const GeoPoint(latitude: 38.6, longitude: 34.8),
        const GeoPoint(latitude: 38.7, longitude: 34.7),
        const GeoPoint(latitude: 38.5, longitude: 34.9),
      ];
      final decoded = Polyline.decode(_encode(original));

      expect(decoded, hasLength(3));
      for (var i = 0; i < original.length; i++) {
        expect(decoded[i].latitude, closeTo(original[i].latitude, 0.00001));
        expect(decoded[i].longitude, closeTo(original[i].longitude, 0.00001));
      }
    });
  });

  group('GeoBounds', () {
    test('boş kümede null döner', () {
      expect(GeoBounds.of(const []), isNull);
    });

    test('sınırları bulur', () {
      final bounds = GeoBounds.of(const [
        GeoPoint(latitude: 38.6, longitude: 34.8),
        GeoPoint(latitude: 39.1, longitude: 34.2),
        GeoPoint(latitude: 38.2, longitude: 35.4),
      ])!;

      expect(bounds.minLatitude, 38.2);
      expect(bounds.maxLatitude, 39.1);
      expect(bounds.minLongitude, 34.2);
      expect(bounds.maxLongitude, 35.4);
      expect(bounds.latitudeSpan, closeTo(0.9, 0.0001));
      expect(bounds.longitudeSpan, closeTo(1.2, 0.0001));
    });
  });
}

/// Testte gidiş-dönüş doğrulaması için basit kodlayıcı.
String _encode(List<GeoPoint> points) {
  final buffer = StringBuffer();
  var previousLat = 0;
  var previousLng = 0;

  for (final point in points) {
    final lat = (point.latitude * 1e5).round();
    final lng = (point.longitude * 1e5).round();
    _writeValue(buffer, lat - previousLat);
    _writeValue(buffer, lng - previousLng);
    previousLat = lat;
    previousLng = lng;
  }

  return buffer.toString();
}

void _writeValue(StringBuffer buffer, int value) {
  var sgn = value < 0 ? ~(value << 1) : value << 1;
  while (sgn >= 0x20) {
    buffer.writeCharCode((0x20 | (sgn & 0x1f)) + 63);
    sgn >>= 5;
  }
  buffer.writeCharCode(sgn + 63);
}
