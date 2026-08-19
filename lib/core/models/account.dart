import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

/// Hesap bilgisi.
///
/// Hesap **zorunlu değil**; uygulama cihaz oturumuyla tam çalışıyor. Hesabın
/// tek işlevi verileri cihazlar arasında taşımak.
@freezed
abstract class Account with _$Account {
  const factory Account({
    required int userId,
    required String email,
    String? displayName,
    required DateTime createdAt,
    @Default(0) int deviceCount,
    @Default(0) int tripCount,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}

/// Kayıt ve giriş yanıtı: hesap + yeni jeton.
@freezed
abstract class AccountSession with _$AccountSession {
  const factory AccountSession({
    required Account account,
    required String accessToken,
    required DateTime expiresAt,
    required int deviceId,
  }) = _AccountSession;

  factory AccountSession.fromJson(Map<String, dynamic> json) =>
      _$AccountSessionFromJson(json);
}
