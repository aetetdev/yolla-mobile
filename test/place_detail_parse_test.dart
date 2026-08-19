import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/core/media/place_image.dart';
import 'package:yolla/core/models/place_detail.dart';

/// Fotoğrafsız bir yerin `GET /places/{id}` yanıtı.
///
/// Harita fotoğrafsız yerleri de gösterdiği için bu gövde artık gerçekten
/// geliyor. Model `photoUrl` ve `photoAttribution` alanlarını zorunlu tuttuğu
/// sürece haritadan böyle bir yere dokunmak
/// "type 'Null' is not a subtype of type 'String'" ile çöküyordu.
const _fotografsiz = {
  'id': 4472,
  'name': 'Güray Yeraltı Seramik Müzesi',
  'nameEn': null,
  'slug': 'guray-yeralti-seramik-muzesi',
  'categoryKey': 'museum',
  'categoryName': 'Müze',
  'categoryIcon': 'museum',
  'description': 'Kayaların oyulmasıyla yer altına inşa edilmiş seramik müzesi.',
  'photoUrl': null,
  'photoThumbUrl': null,
  'photoLargeUrl': null,
  'photoAttribution': null,
  'photoSource': null,
  'latitude': 38.7156,
  'longitude': 34.8461,
  'cityName': 'Nevşehir',
  'citySlug': 'nevsehir',
  'districtName': 'Avanos',
  'address': null,
  'website': null,
  'openingHours': null,
  'wikipediaUrl': null,
  'averageVisitMinutes': null,
  'qualityScore': 62,
  'directionsUrl': null,
  'nearby': <Map<String, dynamic>>[],
};

void main() {
  group('PlaceDetail', () {
    test('fotoğrafsız yer çözümlenebiliyor', () {
      final place = PlaceDetail.fromJson(Map<String, dynamic>.from(_fotografsiz));

      expect(place.id, 4472);
      expect(place.photoUrl, isNull);
      expect(place.photoAttribution, isNull);
    });

    test('fotoğrafsız yerin görseli gösterilmiyor', () {
      final place = PlaceDetail.fromJson(Map<String, dynamic>.from(_fotografsiz));

      expect(PlaceImage.fromDetail(place).canDisplay, isFalse);
    });

    test('atıfı olmayan fotoğraf gösterilmiyor', () {
      // Wikimedia görsellerinin çoğu CC BY-SA: fotoğrafçı adı ve lisans
      // olmadan görsel yayınlanamaz. Adres dolu olsa bile.
      final place = PlaceDetail.fromJson({
        ...Map<String, dynamic>.from(_fotografsiz),
        'photoUrl': 'https://example.org/a.jpg',
        'photoAttribution': null,
      });

      expect(PlaceImage.fromDetail(place).canDisplay, isFalse);
    });

    test('fotoğraf ve atıf birlikteyse gösteriliyor', () {
      final place = PlaceDetail.fromJson({
        ...Map<String, dynamic>.from(_fotografsiz),
        'photoUrl': 'https://example.org/a.jpg',
        'photoAttribution': 'Fotoğraf: Biri (CC BY-SA 3.0)',
      });

      expect(PlaceImage.fromDetail(place).canDisplay, isTrue);
    });

    test('karta dönüştürmek fotoğrafsız yerde de çalışıyor', () {
      final place = PlaceDetail.fromJson(Map<String, dynamic>.from(_fotografsiz));

      expect(place.asCard.photoUrl, isNull);
      expect(place.asCard.name, 'Güray Yeraltı Seramik Müzesi');
    });
  });
}
