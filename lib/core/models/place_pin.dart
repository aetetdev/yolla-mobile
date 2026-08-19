import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_pin.freezed.dart';
part 'place_pin.g.dart';

/// Haritadaki bir yer işareti.
///
/// `GET /places/in-bounds` yanıtı. Kart gövdesinin çok küçültülmüş hali:
/// bir ekranda yüzlerce işaret olabildiği için açıklama, fotoğraf adresi ve
/// atıf satırı taşınmıyor. Kullanıcı işarete dokununca yer detayı ayrıca
/// çekiliyor.
@freezed
abstract class PlacePin with _$PlacePin {
  const factory PlacePin({
    required int id,
    required String name,
    required String slug,
    required double latitude,
    required double longitude,
    required String categoryKey,
    String? categoryIcon,

    /// Yayınlanabilir fotoğrafı var mı?
    ///
    /// Fotoğrafsız yerler haritada bilerek gösteriliyor — kullanıcıdan
    /// fotoğraf istemenin doğal yeri burası. İşaret farklı çiziliyor.
    @Default(false) bool hasPhoto,
    @Default(0) int qualityScore,
  }) = _PlacePin;

  factory PlacePin.fromJson(Map<String, dynamic> json) =>
      _$PlacePinFromJson(json);
}
