import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/account.dart';
import '../../core/models/device_session.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';
import '../session/session_manager.dart';

/// Hesap uçları.
///
/// Kayıt ve girişte cihaz UUID'si gönderiliyor: o cihazda anonim olarak
/// yapılmış kaydırmalar ve oluşturulmuş planlar hesaba bağlanıyor, yani
/// kullanıcı geçmişini kaybetmiyor.
class AccountService {
  const AccountService(this._api, this._session);

  final ApiClient _api;
  final SessionManager _session;

  Future<AccountSession> register({
    required String email,
    required String password,
  }) => _authenticate('/account/register', email, password);

  Future<AccountSession> login({
    required String email,
    required String password,
  }) => _authenticate('/account/login', email, password);

  Future<AccountSession> _authenticate(
    String path,
    String email,
    String password,
  ) async {
    final uuid = await _session.store.deviceUuid();

    final envelope = await _api.post(
      path,
      body: {
        'email': email,
        'password': password,
        'deviceUuid': uuid,
      },
      decode: (json) => AccountSession.fromJson(json! as Map<String, dynamic>),
    );

    // Dönen jeton artık hesaba bağlı. Oturum yöneticisine devredilmezse hem
    // sonraki isteklerde eski jeton gider hem de arayüz kullanıcıyı hesapsız
    // göstermeye devam eder.
    await _session.adopt(
      DeviceSession(
        deviceId: envelope.data.deviceId,
        accessToken: envelope.data.accessToken,
        expiresAt: envelope.data.expiresAt,
        userId: envelope.data.account.userId,
      ),
    );

    return envelope.data;
  }

  Future<Account> me() async {
    final envelope = await _api.get(
      '/account/me',
      decode: (json) => Account.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Hesabı ve verilerini siler.
  ///
  /// Mağaza zorunluluğu: hesap açtıran uygulamalar silme yolu sunmak zorunda.
  Future<void> delete(String password) async {
    await _api.post<void>(
      '/account/delete',
      body: {'password': password},
      decode: (_) {},
    );
    await _session.reset();
  }

  /// Çıkış: hesap silinmez, cihaz yeniden anonim oturuma döner.
  ///
  /// Cihaz UUID'si duruyor, yani aynı cihazda tekrar anonim oturum açıldığında
  /// hesaba bağlanmamış eski geçmiş geri gelir.
  Future<void> signOut() => _session.reset();
}

final accountServiceProvider = Provider<AccountService>(
  (ref) => AccountService(
    ref.watch(apiClientProvider),
    ref.watch(sessionManagerProvider),
  ),
);
