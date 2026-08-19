import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import 'session_store.dart';

/// Kullanıcının oturum durumu.
enum AuthStatus {
  /// Saklanan oturum henüz okunmadı. Açılışta bu durumda başlanır; bu sırada
  /// yönlendirme yapılmaz, yoksa hesabı olan kullanıcı bir an giriş ekranını
  /// görürdü.
  unknown,

  /// Hesaba bağlı geçerli oturum yok.
  signedOut,

  /// Hesaba bağlı geçerli oturum var.
  signedIn,
}

/// Uygulamanın kimlik kapısı.
///
/// Hesap **zorunlu**: hesabı olmayan uygulamayı kullanamaz. Anonim cihaz
/// oturumu altyapısı silinmedi, yalnızca devre dışı — [SessionManager]
/// üzerindeki `requireAccount` bayrağı ve yönlendiricideki duvar kaldırılırsa
/// hesapsız akış olduğu gibi geri gelir.
class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    final manager = ref.watch(sessionManagerProvider)
      ..requireAccount = true
      // Jeton reddedilirse (401) ya da süresi dolmuşsa oturum kapanır;
      // yönlendirici bunu dinleyip giriş ekranına götürür.
      ..onSignedOut = _handleExternalSignOut;

    unawaited(_restore(manager.store));

    return AuthStatus.unknown;
  }

  /// Saklanan oturumu okuyup duruma çevirir.
  Future<void> _restore(SessionStore store) async {
    try {
      final stored = await store.readSession();

      if (stored == null || stored.isAnonymous || stored.needsRenewal) {
        _set(AuthStatus.signedOut);
        return;
      }

      // Bellekteki oturumu da doldur; yoksa ilk isteğe kadar jeton yok sayılır.
      await ref.read(sessionManagerProvider).adopt(stored);
      _set(AuthStatus.signedIn);
    } on Object catch (error) {
      // Güvenli depo okunamazsa (anahtar zinciri kilitli, kayıt bozuk)
      // kullanıcıyı içeride bırakmak yerine girişe düşürmek doğrusu.
      debugPrint('Oturum okunamadı: $error');
      _set(AuthStatus.signedOut);
    }
  }

  /// Giriş veya kayıt başarılı olduğunda çağrılır.
  ///
  /// Jetonu [AccountService] zaten oturum yöneticisine devretmiş oluyor;
  /// burada yalnızca durum güncelleniyor.
  void markSignedIn() => _set(AuthStatus.signedIn);

  /// Kullanıcının kendi isteğiyle çıkışı.
  Future<void> signOut() async {
    await ref.read(sessionManagerProvider).reset();
    _set(AuthStatus.signedOut);
  }

  /// Jeton düştüğü için oturumun dışarıdan kapanması.
  void _handleExternalSignOut() => _set(AuthStatus.signedOut);

  void _set(AuthStatus next) {
    // Denetleyici elden çıkmışsa (test, hot restart) durum yazmak hata verir.
    if (!ref.mounted || state == next) return;
    state = next;
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthStatus>(
  AuthController.new,
);
