import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

/// Şehir.
///
/// [readyPlaceCount] o şehirde kart olarak gösterilebilecek yer sayısıdır.
/// İçerik kapsaması dengesiz (İstanbul 832, Kırıkkale 0) — sıfır olan
/// şehirlerde deste boş gelir, arayüz bunu kullanıcıya söylemek zorunda.
@freezed
abstract class City with _$City {
  const factory City({
    required int id,
    required String name,
    required String slug,
    double? latitude,
    double? longitude,
    @Default(0) int readyPlaceCount,
  }) = _City;

  const City._();

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  bool get hasContent => readyPlaceCount > 0;
}
