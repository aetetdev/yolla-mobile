import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/features/discovery/map_page.dart';

/// Bir işarete dokunulduğunda eklenti, GeoJSON'a yazdığımız `id` alanını geri
/// veriyor. Bu kimliğin biçimi platforma göre değişiyor ve bu fark bir kere
/// dokunmayı tamamen çalışmaz hale getirdi: kimlik metin olarak gelirken
/// sayı bekleniyordu.
void main() {
  group('MapPage.placeIdOf', () {
    test('metin kimliği çözer', () {
      expect(MapPage.placeIdOf('4472'), 4472);
    });

    test('tam sayı kimliği çözer', () {
      expect(MapPage.placeIdOf(4472), 4472);
    });

    test('ondalık kimliği tam sayıya çevirir', () {
      expect(MapPage.placeIdOf(4472.0), 4472);
    });

    test('çözülemeyen kimlikte null döner', () {
      expect(MapPage.placeIdOf(null), isNull);
      expect(MapPage.placeIdOf('yolla-pins.4472'), isNull);
      expect(MapPage.placeIdOf(<String, dynamic>{}), isNull);
    });
  });
}
