import '../models/geo_point.dart';

/// Kodlanmış polyline çözücü.
///
/// Sunucu rota geometrisini Google'ın "encoded polyline" biçiminde,
/// **precision 5** ile veriyor (OSRM varsayılanı). Biçim, ardışık noktalar
/// arasındaki farkı 1e5 ile çarpıp zigzag kodlayarak 5 bitlik parçalar
/// halinde ASCII'ye yazar.
///
/// Ayrı bir paket eklenmedi: algoritma otuz satır ve tek bağımlılığı
/// olmayan bir çözüm, rota çiziminin kalbinde duran bir parça için daha
/// denetlenebilir.
abstract final class Polyline {
  /// [encoded] içindeki noktaları çözer.
  ///
  /// Bozuk girdi istisna fırlatmaz; o ana kadar çözülen noktalar döner.
  /// Rota çizemem kullanıcıyı durdurmamalı.
  static List<GeoPoint> decode(String encoded, {int precision = 5}) {
    final factor = _pow10(precision);
    final points = <GeoPoint>[];

    var index = 0;
    var lat = 0;
    var lng = 0;

    while (index < encoded.length) {
      final latDelta = _readValue(encoded, index);
      if (latDelta == null) break;
      index = latDelta.nextIndex;
      lat += latDelta.value;

      final lngDelta = _readValue(encoded, index);
      if (lngDelta == null) break;
      index = lngDelta.nextIndex;
      lng += lngDelta.value;

      points.add(
        GeoPoint(latitude: lat / factor, longitude: lng / factor),
      );
    }

    return points;
  }

  /// Tek bir sayıyı okur. Girdi yarıda kesilmişse null döner.
  static _Chunk? _readValue(String encoded, int start) {
    var index = start;
    var shift = 0;
    var result = 0;
    int byte;

    do {
      if (index >= encoded.length) return null;
      byte = encoded.codeUnitAt(index++) - 63;
      result |= (byte & 0x1f) << shift;
      shift += 5;
    } while (byte >= 0x20);

    // Zigzag çözümü: en düşük bit işaret taşır.
    final value = (result & 1) != 0 ? ~(result >> 1) : result >> 1;
    return _Chunk(value, index);
  }

  static double _pow10(int exponent) {
    var value = 1.0;
    for (var i = 0; i < exponent; i++) {
      value *= 10;
    }
    return value;
  }
}

class _Chunk {
  const _Chunk(this.value, this.nextIndex);

  final int value;
  final int nextIndex;
}

/// Bir nokta kümesini çevreleyen dikdörtgen.
class GeoBounds {
  const GeoBounds({
    required this.minLatitude,
    required this.maxLatitude,
    required this.minLongitude,
    required this.maxLongitude,
  });

  final double minLatitude;
  final double maxLatitude;
  final double minLongitude;
  final double maxLongitude;

  /// Noktalar boşsa null döner.
  static GeoBounds? of(Iterable<GeoPoint> points) {
    if (points.isEmpty) return null;

    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    return GeoBounds(
      minLatitude: minLat,
      maxLatitude: maxLat,
      minLongitude: minLng,
      maxLongitude: maxLng,
    );
  }

  double get latitudeSpan => maxLatitude - minLatitude;
  double get longitudeSpan => maxLongitude - minLongitude;
}
