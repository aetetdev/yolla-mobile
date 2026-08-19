import 'package:freezed_annotation/freezed_annotation.dart';

import 'place_card.dart';

part 'feed_page.freezed.dart';
part 'feed_page.g.dart';

/// İmleçle sayfalanan kart listesi.
///
/// Sayfa numarası yok: `nextCursor` bir sonraki isteğe olduğu gibi verilir.
/// Bozuk imleç gönderilirse sunucu hata dönmez, ilk sayfayı verir.
@freezed
abstract class FeedPage with _$FeedPage {
  const factory FeedPage({
    @Default(<PlaceCard>[]) List<PlaceCard> items,
    String? nextCursor,
    @Default(false) bool hasMore,
  }) = _FeedPage;

  factory FeedPage.fromJson(Map<String, dynamic> json) =>
      _$FeedPageFromJson(json);
}

/// `/routes/corridor` yanıtı: kartlar + hesaplanmış yol.
@freezed
abstract class CorridorResult with _$CorridorResult {
  const factory CorridorResult({
    required FeedPage cards,
    // Sunucu ondalıklı döndürebiliyor; `int` çözümlemeyi patlatır.
    required double routeDistanceMeters,
    required double routeDurationSeconds,

    /// Kodlanmış polyline (precision 5). Haritada çizmeden önce çözülmeli.
    String? routeGeometry,
  }) = _CorridorResult;

  factory CorridorResult.fromJson(Map<String, dynamic> json) =>
      _$CorridorResultFromJson(json);
}

/// Koridorda uğranan bir şehir.
@freezed
abstract class CorridorCity with _$CorridorCity {
  const factory CorridorCity({
    required int cityId,
    required String name,

    /// Bu şehirde koridora giren yer sayısı.
    required int placeCount,

    /// Şehrin yol üzerindeki yeri (0 = başlangıç, 1 = varış).
    required double progress,
  }) = _CorridorCity;

  factory CorridorCity.fromJson(Map<String, dynamic> json) =>
      _$CorridorCityFromJson(json);
}

/// `/routes/corridor/cities` yanıtı: koridordaki şehirler, yol boyunca sıralı.
@freezed
abstract class CorridorCities with _$CorridorCities {
  const factory CorridorCities({
    @Default(<CorridorCity>[]) List<CorridorCity> cities,
    required double routeDistanceMeters,
    required double routeDurationSeconds,
    String? routeGeometry,
  }) = _CorridorCities;

  factory CorridorCities.fromJson(Map<String, dynamic> json) =>
      _$CorridorCitiesFromJson(json);
}
