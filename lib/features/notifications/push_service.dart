import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../../core/providers.dart';

/// Telefonun bildirim çekmecesine düşen bildirimler.
///
/// Uygulama içindeki liste ([notificationsProvider]) tek güvenilir kaynak
/// olmaya devam ediyor; bu servis yalnızca **iletimle** ilgileniyor: izin
/// istemek, cihazın jetonunu sunucuya yazmak ve gelen bildirime dokunulunca
/// haber vermek.
class PushService {
  PushService(this._api, this._messaging);

  final ApiClient _api;
  final FirebaseMessaging _messaging;

  StreamSubscription<String>? _refresh;

  /// Firebase kurulu mu?
  ///
  /// iOS'ta `GoogleService-Info.plist` gelene kadar kurulmuyor. Kurulmadığında
  /// servis sessizce hiçbir şey yapmıyor — uygulama bildirimsiz çalışmaya
  /// devam ediyor, kullanıcı sonuçları listeden görüyor.
  bool get isReady => Firebase.apps.isNotEmpty;

  /// Kullanıcı bir şey gönderdikten **sonra** izin ister.
  ///
  /// Zamanlama kasıtlı: açılışta sormak en kötüsü, kullanıcı henüz neye izin
  /// verdiğini bilmiyor ve bir kez reddedince Android bir daha sormaya izin
  /// vermiyor. Fotoğrafını ya da önerisini gönderdiği an ise bildirimin ne işe
  /// yarayacağı belli — "sonucu sana haber verelim mi".
  Future<void> promptAfterSubmission() async {
    if (!isReady) return;

    try {
      final settings = await _messaging.getNotificationSettings();

      // Karar zaten verilmişse üstelenmiyor; verilmişse jeton tazeleniyor.
      if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        await _messaging.requestPermission();
      }

      await syncToken();
    } on Object catch (error) {
      debugPrint('Bildirim izni istenemedi: $error');
    }
  }

  /// İzin varsa cihazın jetonunu sunucuya yazar.
  ///
  /// Her açılışta çağrılıyor: jeton kendiliğinden değişebiliyor ve sunucudaki
  /// eski jeton ölü demek — bildirim hiçbir yere gitmez.
  Future<void> syncToken() async {
    if (!isReady) return;

    try {
      final settings = await _messaging.getNotificationSettings();
      final granted =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;

      if (!granted) return;

      await _write(await _messaging.getToken());
    } on Object catch (error) {
      debugPrint('Bildirim jetonu alınamadı: $error');
    }
  }

  /// Jeton yenilenince sunucudakini günceller.
  ///
  /// Uygulama silinip kurulunca ya da veriler temizlenince jeton değişiyor.
  void watchTokenRefresh() {
    if (!isReady) return;
    _refresh ??= _messaging.onTokenRefresh.listen(_write);
  }

  /// Bildirim dinleyicilerini bağlar; sökme işlevini döndürür.
  ///
  /// [onOpened] bildirime dokunulduğunda çağrılıyor — uygulama kapalıyken
  /// açılmış olabilir, arka plandan öne gelmiş olabilir, ikisi de aynı yere
  /// gitmeli. [onReceived] uygulama öndeyken geliyor: Android bu durumda
  /// sistem bildirimini göstermiyor, en azından rozet tazelenmeli.
  VoidCallback attach({
    required void Function(int? placeId) onOpened,
    required VoidCallback onReceived,
  }) {
    if (!isReady) return () {};

    void open(RemoteMessage message) => onOpened(placeIdOf(message));

    // Uygulama tamamen kapalıyken bildirime dokunulmuşsa, açılışı başlatan
    // ileti burada duruyor.
    unawaited(
      _messaging.getInitialMessage().then((message) {
        if (message != null) open(message);
      }),
    );

    final opened = FirebaseMessaging.onMessageOpenedApp.listen(open);
    final received = FirebaseMessaging.onMessage.listen((_) => onReceived());

    return () {
      unawaited(opened.cancel());
      unawaited(received.cancel());
    };
  }

  void dispose() {
    unawaited(_refresh?.cancel());
    _refresh = null;
  }

  /// İletideki yer kimliği. Sunucu `data` içinde metin olarak gönderiyor —
  /// FCM veri alanlarında sayı taşınmıyor.
  static int? placeIdOf(RemoteMessage message) {
    final raw = message.data['placeId'];
    return raw == null ? null : int.tryParse('$raw');
  }

  Future<void> _write(String? token) async {
    if (token == null || token.isEmpty) return;

    try {
      await _api.put<void>(
        '/devices/bildirim-jetonu',
        body: {'token': token},
        decode: (_) {},
      );
    } on ApiException catch (error) {
      // Jeton yazılamazsa bildirim telefona düşmez ama uygulama içindeki liste
      // çalışmaya devam ediyor; kullanıcıyı hatayla rahatsız etmenin anlamı yok.
      debugPrint('Bildirim jetonu sunucuya yazılamadı: ${error.message}');
    }
  }
}

final pushServiceProvider = Provider<PushService>((ref) {
  final service = PushService(
    ref.watch(apiClientProvider),
    FirebaseMessaging.instance,
  );
  ref.onDispose(service.dispose);
  return service;
});

/// Açılışta jetonu tazeler ve yenilenmesini dinlemeye başlar.
///
/// Oturumu bekliyor: jeton ucu hesap istiyor, oturum kurulmadan çağrılırsa
/// istek jetonsuz gidip 401 alır.
final pushRegistrationProvider = FutureProvider<void>((ref) async {
  await ref.watch(sessionProvider.future);

  final push = ref.watch(pushServiceProvider);
  push.watchTokenRefresh();
  await push.syncToken();
});
