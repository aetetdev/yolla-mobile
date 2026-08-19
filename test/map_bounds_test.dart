import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/features/discovery/map_service.dart';

/// Görünen alan artık eklentinin `getVisibleRegion()` çağrısıyla değil,
/// kamera durumundan Dart tarafında hesaplanıyor — o çağrı her kaydırmada
/// Android arayüz iş parçacığını kilitleyip haritayı donduruyordu. Hesap
/// doğru olmazsa işaretler yanlış kutudan çekilir ve ekranda hiç görünmez;
/// bu yüzden Mercator dönüşümü burada sabitleniyor.
void main() {
  group('MapBounds.fromCamera', () {
    test('merkez, hesaplanan kutunun ortasında kalır', () {
      final bounds = MapBounds.fromCamera(
        latitude: 41.0082,
        longitude: 28.9784,
        zoom: 13,
        width: 400,
        height: 800,
      );

      expect((bounds.west + bounds.east) / 2, closeTo(28.9784, 1e-9));
      // Mercator'de enlem doğrusal değil; ortalama merkeze çok yakın çıkar
      // ama birebir eşit olmaz.
      expect((bounds.south + bounds.north) / 2, closeTo(41.0082, 1e-3));
    });

    test('boylam genişliği yakınlaştırmadan doğru çıkar', () {
      const width = 512.0;

      // z13'te dünya 512·2^13 dp geniş. 512 dp'lik bir ekran dünyanın
      // 1/8192'sini, yani 360/8192 dereceyi görür.
      final bounds = MapBounds.fromCamera(
        latitude: 0,
        longitude: 30,
        zoom: 13,
        width: width,
        height: width,
      );

      expect(bounds.east - bounds.west, closeTo(360 / 8192, 1e-9));
      // Ekvatorda Mercator ölçeği 1; kare ekran kare kutu verir.
      expect(bounds.north - bounds.south, closeTo(360 / 8192, 1e-6));
    });

    test('yakınlaştırdıkça kutu daralır', () {
      MapBounds at(double zoom) => MapBounds.fromCamera(
        latitude: 38.6431,
        longitude: 34.8286,
        zoom: zoom,
        width: 400,
        height: 800,
      );

      final wide = at(10);
      final tight = at(14);

      expect(tight.east - tight.west, lessThan(wide.east - wide.west));
      expect(tight.north - tight.south, lessThan(wide.north - wide.south));
      // Her seviye kutuyu yarıya indiriyor: 4 seviye = 16 kat.
      expect(
        (wide.east - wide.west) / (tight.east - tight.west),
        closeTo(16, 1e-6),
      );
    });

    test('kutup yakınında sonsuza gitmez', () {
      final bounds = MapBounds.fromCamera(
        latitude: 89.9,
        longitude: 0,
        zoom: 3,
        width: 400,
        height: 800,
      );

      expect(bounds.north.isFinite, isTrue);
      expect(bounds.south.isFinite, isTrue);
      expect(bounds.north, greaterThan(bounds.south));
    });
  });

  group('MapBounds.isCloseTo', () {
    // Eşik sabit derece olduğunda (0.002) yakınlaştırıldıkça ekranın
    // tamamını aşıyordu: z17 civarında hiçbir kaydırma "değişti" sayılmıyor,
    // işaretler bir daha güncellenmiyordu.
    MapBounds at(double longitude, double zoom) => MapBounds.fromCamera(
      latitude: 41.0,
      longitude: longitude,
      zoom: zoom,
      width: 400,
      height: 800,
    );

    test('yerinde duran harita yeniden yüklenmez', () {
      expect(at(28.9784, 17).isCloseTo(at(28.9784, 17)), isTrue);
    });

    test('yakınlaştırılmış haritada ekran boyu kaydırma yenilemeyi tetikler', () {
      final before = at(28.9784, 17);
      final after = at(28.9784 + (before.east - before.west), 17);

      expect(after.isCloseTo(before), isFalse);
    });

    test('uzaklaştırılmış haritada aynı mesafe önemsiz kalır', () {
      final tightSpan = at(28.9784, 17);
      final shift = tightSpan.east - tightSpan.west;

      final before = at(28.9784, 8);
      final after = at(28.9784 + shift, 8);

      expect(after.isCloseTo(before), isTrue);
    });
  });
}
