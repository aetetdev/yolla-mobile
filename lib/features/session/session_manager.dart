import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../app/env.dart';
import '../../core/models/device_session.dart';
import '../../core/network/api_client.dart';
import 'session_store.dart';

/// Oturumun süresi dolmuş ve hesap zorunlu olduğu için yenilenememiş.
///
/// Yakalayan taraf kullanıcıyı giriş ekranına götürür.
class SessionExpired implements Exception {
  const SessionExpired();

  @override
  String toString() => 'SessionExpired';
}

/// Cihaz oturumunu kurar ve tazeler.
///
/// Akış: UUID'yi al → saklanan jeton varsa ve süresi dolmadıysa kullan →
/// yoksa `devices/register` çağır. Uç aynı UUID ile tekrar çağrılmaya karşı
/// güvenli olduğu için her açılışta çağrılabilir.
class SessionManager implements SessionTokenSource {
  SessionManager({required this.store, required this.api}) {
    api.tokenSource = this;
  }

  final SessionStore store;
  final ApiClient api;

  /// Hesap zorunlu mu?
  ///
  /// `true` iken jeton düştüğünde **anonim kayıt açılmaz**. Açılsaydı kullanıcı
  /// giriş yapmış görünmeye devam eder ama bomboş bir cihaz oturumuna düşerdi:
  /// planları ve beğenileri yok olmuş gibi görünürdü. Onun yerine oturum
  /// kapatılır ve [onSignedOut] ile giriş ekranına dönülür.
  ///
  /// Anonim kullanım altyapısı yerinde duruyor; bu bayrak `false` yapılınca
  /// (ve yönlendiricideki duvar kaldırılınca) hesapsız akış geri gelir.
  bool requireAccount = true;

  /// Oturumun dışarıdan kapandığını haber verir.
  void Function()? onSignedOut;

  DeviceSession? _session;

  /// Aynı anda birden çok istek 401 alırsa hepsi ayrı ayrı kayıt açmaya
  /// çalışır. Tek bir kayıt işlemi paylaştırılır.
  Future<DeviceSession>? _inFlight;

  DeviceSession? get session => _session;

  /// Dışarıdan gelen bir oturumu benimser.
  ///
  /// Hesap açma/giriş yeni bir jeton döndürüyor. Yalnızca depoya yazmak
  /// yetmez: bellekteki `_session` eski (anonim) hali tutmaya devam eder ve
  /// arayüz kullanıcıyı hâlâ hesapsız gösterir.
  Future<void> adopt(DeviceSession session) async {
    _session = session;
    await store.writeSession(session);
  }

  /// Oturumu sıfırlar — çıkış ve hesap silme sonrası.
  Future<void> reset() async {
    _session = null;
    await store.clearSession();
  }

  /// Geçerli bir oturum döndürür; gerekirse kurar.
  Future<DeviceSession> ensure() async {
    final current = _session ??= await store.readSession();
    if (current != null && !current.needsRenewal) {
      return current;
    }

    if (requireAccount) {
      await reset();
      onSignedOut?.call();
      throw const SessionExpired();
    }

    return _register();
  }

  @override
  Future<String?> currentToken() async {
    _session ??= await store.readSession();
    return _session?.accessToken;
  }

  @override
  Future<String?> renewSession() async {
    // Reddedilen jetonu at ki `currentToken` eskisini vermeye devam etmesin.
    _session = null;
    await store.clearSession();

    if (requireAccount) {
      onSignedOut?.call();
      return null;
    }

    try {
      final renewed = await _register();
      return renewed.accessToken;
    } on Object catch (error) {
      debugPrint('Oturum tazelenemedi: $error');
      return null;
    }
  }

  Future<DeviceSession> _register() {
    return _inFlight ??= _doRegister().whenComplete(() => _inFlight = null);
  }

  Future<DeviceSession> _doRegister() async {
    final stored = await store.readSession();
    if (stored != null && !stored.needsRenewal) {
      _session = stored;
      return stored;
    }

    final uuid = await store.deviceUuid();

    final envelope = await api.post(
      '/devices/register',
      body: {
        'deviceUuid': uuid,
        'platform': _platform,
        'appVersion': Env.appVersion,
        'language': 'tr',
      },
      decode: (json) => DeviceSession.fromJson(json! as Map<String, dynamic>),
    );

    _session = envelope.data;
    await store.writeSession(envelope.data);
    return envelope.data;
  }

  /// Backend `ios`, `android` ve `web` kabul ediyor; başka değer 400 döner.
  static String get _platform {
    if (kIsWeb) return 'web';
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => 'ios',
      TargetPlatform.android => 'android',
      // Masaüstünde geliştirme yaparken en yakın kabul edilen değer.
      _ => 'web',
    };
  }
}
