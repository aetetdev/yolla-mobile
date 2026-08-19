import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_session.freezed.dart';
part 'device_session.g.dart';

/// `POST /devices/register` yanıtı.
///
/// Hesap gerekmez: istemci bir UUID üretir, kalıcı saklar ve her açılışta bu
/// ucu çağırır. Aynı UUID ile tekrar çağırmak güvenlidir — yeni kayıt açılmaz,
/// oturum tazelenir.
@freezed
abstract class DeviceSession with _$DeviceSession {
  const factory DeviceSession({
    required int deviceId,
    required String accessToken,
    required DateTime expiresAt,

    /// Cihaz bir hesaba bağlandığında dolar. Hesap özelliği backend'de
    /// yazılıyor; şimdilik her zaman null.
    int? userId,
  }) = _DeviceSession;

  const DeviceSession._();

  factory DeviceSession.fromJson(Map<String, dynamic> json) =>
      _$DeviceSessionFromJson(json);

  bool get isAnonymous => userId == null;

  /// Jeton 90 gün geçerli. Son güne bırakmadan, bir gün kala yenilenir ki
  /// kullanıcı uçakta/çevrimdışıyken süresi dolmuş jetonla kalmasın.
  bool get needsRenewal =>
      DateTime.now().toUtc().isAfter(
        expiresAt.toUtc().subtract(const Duration(days: 1)),
      );
}
