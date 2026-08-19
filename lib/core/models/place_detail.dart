import 'package:freezed_annotation/freezed_annotation.dart';

import 'place_card.dart';

part 'place_detail.freezed.dart';
part 'place_detail.g.dart';

/// `GET /places/{id}` yanıtı.
///
/// Kart alanlarına ek olarak adres, çalışma saatleri, Wikipedia bağlantısı,
/// yol tarifi ve yakındaki yerler taşır. Alanların çoğu OSM'den geldiği için
/// **sıklıkla boş**; arayüz her birini koşullu göstermek zorunda.
@freezed
abstract class PlaceDetail with _$PlaceDetail {
  const factory PlaceDetail({
    required int id,
    required String name,
    String? nameEn,
    required String slug,
    required String categoryKey,
    required String categoryName,
    String? categoryIcon,
    String? description,

    /// Fotoğrafsız yerlerde **null**.
    ///
    /// Harita fotoğrafsız yerleri de gösteriyor (kullanıcıdan fotoğraf
    /// istemenin yeri orası), yani detay ekranı bu durumu karşılamak zorunda.
    /// Eskiden zorunluydu ve haritadan fotoğrafsız bir yere dokunmak
    /// "type 'Null' is not a subtype of type 'String'" ile çöküyordu.
    String? photoUrl,
    String? photoThumbUrl,
    String? photoLargeUrl,

    /// Fotoğrafın yanında gösterilmesi zorunlu atıf. Fotoğraf yoksa null;
    /// **atıf yoksa fotoğraf gösterilemez** (bkz. [PlaceImage.canDisplay]).
    String? photoAttribution,
    String? photoSource,
    required double latitude,
    required double longitude,
    String? cityName,
    String? citySlug,
    String? districtName,
    String? address,
    String? website,
    String? openingHours,
    String? wikipediaUrl,
    int? averageVisitMinutes,
    required int qualityScore,

    /// Harita uygulamasında yol tarifi açar.
    String? directionsUrl,

    @Default(<NearbyPlace>[]) List<NearbyPlace> nearby,
  }) = _PlaceDetail;

  const PlaceDetail._();

  factory PlaceDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailFromJson(json);

  /// Fotoğraf bileşenleri kart modeliyle çalıştığı için köprü.
  PlaceCard get asCard => PlaceCard(
    id: id,
    name: name,
    slug: slug,
    categoryKey: categoryKey,
    categoryName: categoryName,
    categoryIcon: categoryIcon,
    photoUrl: photoUrl,
    photoThumbUrl: photoThumbUrl,
    photoLargeUrl: photoLargeUrl,
    photoAttribution: photoAttribution,
    photoSource: photoSource,
    description: description,
    cityName: cityName,
    districtName: districtName,
    latitude: latitude,
    longitude: longitude,
    averageVisitMinutes: averageVisitMinutes,
    qualityScore: qualityScore,
  );

  String get locationLabel =>
      [districtName, cityName].whereType<String>().toSet().join(', ');
}

/// Yakındaki yer.
///
/// Kart DTO'sundan daha dar bir şekil: `categoryKey` ve koordinat taşımaz.
/// Fotoğrafın yanında gösterilmesi zorunlu olan [photoAttribution] var, o
/// yüzden görselli çizilebiliyor.
@freezed
abstract class NearbyPlace with _$NearbyPlace {
  const factory NearbyPlace({
    required int id,
    required String name,
    required String slug,
    String? categoryName,
    String? photoUrl,
    String? photoThumbUrl,

    /// Görselin yanında gösterilmesi zorunlu atıf satırı (CC BY-SA).
    String? photoAttribution,
    required int distanceMeters,
  }) = _NearbyPlace;

  const NearbyPlace._();

  factory NearbyPlace.fromJson(Map<String, dynamic> json) =>
      _$NearbyPlaceFromJson(json);

  /// "120 m" · "1,4 km"
  String get distanceLabel => distanceMeters < 950
      ? '$distanceMeters m'
      : '${(distanceMeters / 1000).toStringAsFixed(1).replaceAll('.', ',')} km';
}
