import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/app_notification.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Bildirim uçları.
///
/// Bildirim sunucuda önce veritabanına yazılıyor, telefona iletim ayrı bir
/// kanal. Push teslimi garanti olmadığı için (izin reddedilebilir, telefon
/// kapalı olabilir) uygulamanın kendi listesi tek güvenilir kaynak.
class NotificationService {
  const NotificationService(this._api);

  final ApiClient _api;

  /// Bildirimler, yeniden eskiye.
  Future<List<AppNotification>> mine({int take = 50}) async {
    final envelope = await _api.get(
      '/bildirimler',
      query: {'take': take},
      decode: (json) => (json! as List)
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }

  /// Sekmedeki rozetin sayısı.
  Future<int> unreadCount() async {
    final envelope = await _api.get(
      '/bildirimler/okunmamis',
      decode: (json) => (json as num?)?.toInt() ?? 0,
    );
    return envelope.data;
  }

  /// Okundu işaretler. [ids] verilmezse hepsi.
  Future<void> markRead([List<int>? ids]) => _api.post<void>(
    '/bildirimler/okundu',
    // Gövde boş bırakılamıyor: sunucu `ids` yokken hepsini okundu sayıyor ama
    // istek yine de bir JSON nesnesi taşımalı.
    body: {'ids': ?ids},
    decode: (_) {},
  );
}

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(ref.watch(apiClientProvider)),
);

/// Bildirim listesi.
///
/// `autoDispose`: ekran kapanınca liste de düşüyor, bir sonraki açılışta
/// yeniden çekiliyor. Riverpod'da varsayılan davranış bu **değil** — sürekli
/// bellekte kalsaydı kullanıcı listeyi ikinci kez açtığında arada gelen
/// bildirimleri göremezdi.
final notificationsProvider = FutureProvider.autoDispose<List<AppNotification>>((
  ref,
) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(notificationServiceProvider).mine();
});

/// Okunmamış bildirim sayısı; profil sekmesindeki rozet.
///
/// Push devreye girene kadar tek tazeleme yolu uygulamanın öne gelmesi
/// ([YollaShell] onu dinliyor) ve listenin açılıp kapanması.
final unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(notificationServiceProvider).unreadCount();
});
