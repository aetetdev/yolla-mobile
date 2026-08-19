import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';
import 'geo_point.dart';
import 'place_card.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

/// Gezi planı.
///
/// Duraklar ya da ulaşım tipi değiştiğinde sunucu hesaplanmış rotayı
/// **temizler**: [distanceMeters], [durationSeconds] ve [routeGeometry] null
/// olur. Arayüz bu durumda "rotayı hesapla" eylemini yeniden göstermeli.
@freezed
abstract class Trip with _$Trip {
  const factory Trip({
    required int id,
    required String name,
    required TripMode mode,
    required TravelMode travelMode,
    String? cityName,
    int? cityId,
    GeoPoint? startPoint,
    GeoPoint? endPoint,
    @Default(<TripPlace>[]) List<TripPlace> places,

    // Sunucu bu üçünü ondalıklı döndürüyor (ör. 39660.5); `int` olarak
    // modellenirse çözümleme patlar.
    double? distanceMeters,
    double? durationSeconds,
    int? visitDurationMinutes,

    /// Kodlanmış polyline (precision 5). Haritada çizmeden önce çözülmeli.
    String? routeGeometry,
    required DateTime createdAt,
  }) = _Trip;

  const Trip._();

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  /// Rota hesaplanmış mı?
  bool get hasRoute => routeGeometry != null && distanceMeters != null;

  bool get isEmpty => places.isEmpty;

  /// Yürüme/sürüş süresi + duraklarda geçirilecek süre.
  Duration? get totalDuration {
    final travel = durationSeconds;
    if (travel == null) return null;
    return Duration(seconds: travel.round()) +
        Duration(minutes: visitDurationMinutes ?? 0);
  }

  /// "12,4 km" · "840 m"
  String? get distanceLabel {
    final meters = distanceMeters;
    if (meters == null) return null;
    if (meters < 950) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1).replaceAll('.', ',')} km';
  }

  /// Yürüyerek çok uzun süren planlarda kullanıcıyı uyarmak için.
  ///
  /// Kapadokya'da 4 durak yürüyerek 8 saat çıkabiliyor; duraklar birbirinden
  /// uzak olduğunda "araç önerilir" demek gerekiyor.
  bool get isTooLongOnFoot =>
      travelMode == TravelMode.foot &&
      (durationSeconds ?? 0) > const Duration(hours: 3).inSeconds;
}

/// Plan listesi öğesi.
///
/// `GET /trips` detay şeklinden **farklı ve daha hafif** bir gövde döndürüyor:
/// duraklar dizisi yerine [placeCount], rota geometrisi ve süre yok.
/// [Trip] ile modellenirse liste "0 durak" gösterir.
@freezed
abstract class TripSummary with _$TripSummary {
  const factory TripSummary({
    required int id,
    required String name,
    required TripMode mode,
    required TravelMode travelMode,
    String? cityName,
    @Default(0) int placeCount,
    double? distanceMeters,
    String? coverPhotoUrl,
    String? coverPhotoThumbUrl,

    /// Kapak görselinin yanında gösterilmesi zorunlu atıf satırı (CC BY-SA).
    /// Boşsa kapak gösterilemez.
    String? coverPhotoAttribution,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _TripSummary;

  const TripSummary._();

  factory TripSummary.fromJson(Map<String, dynamic> json) =>
      _$TripSummaryFromJson(json);

  bool get hasRoute => distanceMeters != null;

  String? get distanceLabel {
    final meters = distanceMeters;
    if (meters == null) return null;
    if (meters < 950) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1).replaceAll('.', ',')} km';
  }
}

/// Plandaki bir durak.
@freezed
abstract class TripPlace with _$TripPlace {
  const factory TripPlace({
    /// Uğrama sırası (1'den başlar).
    required int order,

    /// Çok günlük planlarda gün numarası. Bölme mantığı henüz sunucuda yok.
    @Default(0) int dayIndex,
    @Default(false) bool isVisited,
    String? note,
    required PlaceCard place,
  }) = _TripPlace;

  factory TripPlace.fromJson(Map<String, dynamic> json) =>
      _$TripPlaceFromJson(json);
}
