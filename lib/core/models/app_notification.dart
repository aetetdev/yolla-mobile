import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// Bildirimin sebebi.
///
/// Sunucudaki `NotificationKind` ile birebir; metin değeri taşınıyor, sayı
/// değil — sıralama değişirse sessizce bozulmasın.
enum NotificationKind {
  @JsonValue('PhotoApproved')
  photoApproved,

  @JsonValue('PhotoRejected')
  photoRejected,

  @JsonValue('SuggestionApproved')
  suggestionApproved,

  @JsonValue('SuggestionRejected')
  suggestionRejected,

  /// Sunucu yeni bir tür eklediğinde eski sürüm çökmesin diye var; hiçbir
  /// zaman gövdeden çözülmüyor, bilinmeyen değerin düştüğü yer burası.
  unknown;

  /// Olumsuz bir sonucu mu anlatıyor? Simge ve renk buna göre seçiliyor.
  bool get isRejection =>
      this == photoRejected || this == suggestionRejected;
}

/// Kullanıcıya olan biteni haber veren bildirim.
///
/// Başlık ve metin **sunucuda** kuruluyor: bildirim telefon kapalıyken de
/// gelmek zorunda ve o anda uygulamanın çeviri dosyaları devrede değil. Bu
/// yüzden burada çevrilmiyor, olduğu gibi gösteriliyor.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,

    /// Bilinmeyen tür gelirse [NotificationKind.unknown]'a düşüyor.
    @JsonKey(unknownEnumValue: NotificationKind.unknown)
    required NotificationKind kind,
    required String title,
    required String body,

    /// Varsa konu olan yer; bildirime dokununca oraya gidiliyor.
    int? placeId,
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
