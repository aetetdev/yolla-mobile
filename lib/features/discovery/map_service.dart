import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/place_pin.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Haritanın görünen alanı.
@immutable
class MapBounds {
  const MapBounds({
    required this.south,
    required this.west,
    required this.north,
    required this.east,
  });

  /// Kamera durumundan görünen alanı hesaplar.
  ///
  /// Bu hesap **bilerek** eklentinin `getVisibleRegion()` çağrısının yerine
  /// geçiyor. O çağrı her kaydırmada platform kanalından Android arayüz
  /// iş parçacığına gidip native harita nesnesinden kilitli okuma yapıyordu;
  /// kilit bir kez tutulduğunda arayüz iş parçacığı donuyor, harita kaydırmayı
  /// ve dokunmayı bırakıyor, yükleme de ilk `await`'te asılı kalıyordu.
  /// Kamera konumu zaten `trackCameraPosition` ile elimizde olduğu için
  /// aynı sonucu Dart tarafında, hiçbir platform çağrısı yapmadan üretiyoruz.
  ///
  /// [width] ve [height] mantıksal piksel (dp). MapLibre'nin yakınlaştırma
  /// tanımı da dp üzerinden: `z` seviyesinde dünya 512·2^z dp genişliğinde.
  /// Eğme ve döndürme keşif haritasında kapalı, bu yüzden görünen alan
  /// eksenlere hizalı bir dikdörtgen.
  factory MapBounds.fromCamera({
    required double latitude,
    required double longitude,
    required double zoom,
    required double width,
    required double height,
  }) {
    final worldSize = 512.0 * math.pow(2.0, zoom);

    final lngSpan = 360.0 * (width / worldSize);
    final centerY = _latitudeToY(latitude, worldSize);

    return MapBounds(
      south: _yToLatitude(centerY + height / 2, worldSize),
      west: longitude - lngSpan / 2,
      north: _yToLatitude(centerY - height / 2, worldSize),
      east: longitude + lngSpan / 2,
    );
  }

  /// Web Mercator: enlemi dünya piksel düzlemine taşır (kuzey = küçük y).
  static double _latitudeToY(double latitude, double worldSize) {
    // Kutuplarda formül sonsuza gidiyor; Mercator'ün alışıldık sınırı.
    final clamped = latitude.clamp(-85.05112878, 85.05112878);
    final sin = math.sin(clamped * math.pi / 180.0);
    return worldSize * (0.5 - math.log((1 + sin) / (1 - sin)) / (4 * math.pi));
  }

  static double _yToLatitude(double y, double worldSize) {
    final n = math.pi - 2 * math.pi * y / worldSize;
    return 180.0 / math.pi * math.atan(0.5 * (math.exp(n) - math.exp(-n)));
  }

  final double south;
  final double west;
  final double north;
  final double east;

  /// Aynı alan sayılacak kadar yakın mı?
  ///
  /// Harita her karede kamera olayı üretiyor; parmağın altındaki en ufak
  /// kayma için sunucuya gitmek hem gereksiz hem de hız sınırına takılıyor.
  ///
  /// Eşik **görünen alanın oranı** olarak ölçülüyor, sabit derece olarak değil.
  /// Sabit eşik (0.002 derece) yakınlaştırıldıkça ekranın tamamını aşıyordu:
  /// z17 civarında görünen alan zaten 0.002 dereceden dar olduğu için hiçbir
  /// kaydırma "yeterince değişti" sayılmıyor ve işaretler bir daha
  /// güncellenmiyordu.
  bool isCloseTo(MapBounds other) {
    const fraction = 0.1;
    final latEpsilon = (north - south).abs() * fraction;
    final lngEpsilon = (east - west).abs() * fraction;

    return (south - other.south).abs() < latEpsilon &&
        (north - other.north).abs() < latEpsilon &&
        (west - other.west).abs() < lngEpsilon &&
        (east - other.east).abs() < lngEpsilon;
  }

  /// Görünen alanı biraz büyütür.
  ///
  /// Kullanıcı haritayı azıcık kaydırdığında kenardaki işaretlerin bir anlığına
  /// yok olup geri gelmesini engelliyor.
  MapBounds padded([double factor = 0.15]) {
    final latPad = (north - south) * factor;
    final lngPad = (east - west) * factor;

    return MapBounds(
      south: (south - latPad).clamp(-90.0, 90.0),
      west: (west - lngPad).clamp(-180.0, 180.0),
      north: (north + latPad).clamp(-90.0, 90.0),
      east: (east + lngPad).clamp(-180.0, 180.0),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MapBounds &&
      other.south == south &&
      other.west == west &&
      other.north == north &&
      other.east == east;

  @override
  int get hashCode => Object.hash(south, west, north, east);

  @override
  String toString() =>
      'MapBounds(G ${south.toStringAsFixed(4)}, B ${west.toStringAsFixed(4)}, '
      'K ${north.toStringAsFixed(4)}, D ${east.toStringAsFixed(4)})';
}

/// Harita işaretlerini çeken uç.
class MapService {
  const MapService(this._api);

  final ApiClient _api;

  Future<List<PlacePin>> pinsInBounds(MapBounds bounds, {int take = 200}) async {
    final envelope = await _api.get(
      '/places/in-bounds',
      query: {
        'south': bounds.south,
        'west': bounds.west,
        'north': bounds.north,
        'east': bounds.east,
        'take': take,
      },
      decode: (json) => (json! as List)
          .map((e) => PlacePin.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }
}

final mapServiceProvider = Provider<MapService>(
  (ref) => MapService(ref.watch(apiClientProvider)),
);
