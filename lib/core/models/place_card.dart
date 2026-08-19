import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_card.freezed.dart';
part 'place_card.g.dart';

/// Deste kartı.
///
/// Hem şehir içi destede (`/discovery/city/{id}/feed`) hem yol koridorunda
/// (`/routes/corridor`) aynı biçim döner. Koridorda ek olarak [routeProgress]
/// ve [detourMeters] dolu gelir; şehir içinde null'dır.
@freezed
abstract class PlaceCard with _$PlaceCard {
  const factory PlaceCard({
    required int id,
    required String name,
    required String slug,
    required String categoryKey,
    required String categoryName,
    String? categoryIcon,

    /// Commons **orijinali** — ortalama ~1 MB, doğrudan gösterilmez.
    ///
    /// Deste yalnızca fotoğraflı yerleri döndürüyor ama bu sunucu tarafında
    /// bir kural; istemci buna bağlanmıyor. Ayrıca yer detayı bu tipe
    /// dönüştürülüyor ([PlaceDetail.asCard]) ve orada fotoğraf olmayabiliyor.
    String? photoUrl,

    /// Sunucunun hazırladığı küçük görsel (500px). Liste ve küçük alanlar için.
    String? photoThumbUrl,

    /// Sunucunun hazırladığı büyük görsel (960px). Kart destesi için.
    String? photoLargeUrl,

    /// "Fotoğraf: Brocken Inaglory (CC BY-SA 3.0)" — fotoğrafın yanında
    /// gösterilmesi zorunlu. Fotoğraf yoksa null.
    String? photoAttribution,

    /// Commons dosya sayfası; atıfa dokunulduğunda açılır.
    String? photoSource,

    String? description,

    /// Bulunduğu şehrin kimliği — beğenilenlerden doğrudan plan kurmak için.
    int? cityId,
    String? cityName,
    String? districtName,
    required double latitude,
    required double longitude,
    int? averageVisitMinutes,
    required int qualityScore,

    /// Yolun neresinde (0-1). Yalnızca koridor modunda dolu.
    double? routeProgress,

    /// Ana yoldan sapma mesafesi (metre). Yalnızca koridor modunda dolu.
    double? detourMeters,
  }) = _PlaceCard;

  const PlaceCard._();

  factory PlaceCard.fromJson(Map<String, dynamic> json) =>
      _$PlaceCardFromJson(json);

  /// Koridor kartı mı — "5 km sapma" rozetini göstermeye karar vermek için.
  bool get isOnRoute => routeProgress != null;

  /// Sapmayı okunur biçimde verir: 900 m altı metre, üstü km.
  String? get detourLabel {
    final meters = detourMeters;
    if (meters == null) return null;
    if (meters < 950) return '${(meters / 50).round() * 50} m sapma';
    return '${(meters / 1000).toStringAsFixed(1).replaceAll('.', ',')} km sapma';
  }

  /// Kartın altındaki konum satırı: "Ürgüp, Nevşehir".
  String get locationLabel =>
      [districtName, cityName].whereType<String>().toSet().join(', ');
}
