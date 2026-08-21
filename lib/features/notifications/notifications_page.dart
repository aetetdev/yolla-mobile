import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/app_notification.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/format.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'notification_service.dart';

/// Bildirim listesi.
///
/// Gönderilen fotoğrafın ve önerilen yerin sonucunu kullanıcının gördüğü yer.
/// Push teslimi garanti olmadığı için liste tek güvenilir kaynak: telefon
/// kapalıyken kaçan bildirim burada duruyor.
class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  void initState() {
    super.initState();

    // İlk çizimden sonra: liste `build` içinde izleniyor ve `autoDispose`
    // olduğu için buradan doğrudan okumak onu izleyicisiz oluşturup hemen
    // düşürebilir — sonuç iki ayrı istek olurdu.
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_markRead()));
  }

  /// Liste yüklendikten sonra hepsini okundu işaretler.
  ///
  /// İşaretleme **yüklemeden sonra** yapılıyor: ekrandaki satırlar elde
  /// okunmamış haliyle duruyor, kullanıcı hangilerinin yeni olduğunu görmeye
  /// devam ediyor. Rozet ise ekran açılır açılmaz sıfırlanıyor.
  Future<void> _markRead() async {
    try {
      final list = await ref.read(notificationsProvider.future);
      if (!mounted || !list.any((notification) => !notification.isRead)) return;

      await ref.read(notificationServiceProvider).markRead();
      if (!mounted) return;

      ref.invalidate(unreadNotificationCountProvider);
    } on ApiException {
      // Okundu işaretlemek ekranın asıl işi değil: başarısız olursa liste yine
      // görünüyor, rozet bir sonraki açılışta düzeliyor.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notificationsTitle)),
      body: switch (notifications) {
        AsyncData(:final value) when value.isEmpty => YollaMessage(
          icon: Icons.notifications_none_rounded,
          title: l10n.notificationsEmptyTitle,
          detail: l10n.notificationsEmptyDetail,
        ),
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(notificationsProvider);
            await _markRead();
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(Space.xl),
            itemCount: value.length,
            separatorBuilder: (_, _) => const SizedBox(height: Space.md),
            itemBuilder: (context, index) => _NotificationCard(value[index]),
          ),
        ),
        AsyncError(:final error) => YollaMessage(
          icon: Icons.wifi_off_rounded,
          title: error is ApiException ? error.title : l10n.commonLoadFailed,
          detail: error is ApiException ? error.message : '$error',
          actionLabel: l10n.commonRetry,
          onAction: () => ref.invalidate(notificationsProvider),
        ),
        _ => const Center(child: YollaLoader()),
      },
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard(this.notification);

  final AppNotification notification;

  /// Simge ve renk türden geliyor. Renk tek başına anlam taşımıyor — metin
  /// zaten sonucu söylüyor — yalnızca listeyi taranabilir kılıyor.
  (IconData, Color) get _mark => switch (notification.kind) {
    NotificationKind.photoApproved => (
      Icons.photo_library_outlined,
      YollaColors.like,
    ),
    NotificationKind.photoRejected => (
      Icons.hide_image_outlined,
      YollaColors.pass,
    ),
    NotificationKind.suggestionApproved => (
      Icons.add_location_alt_outlined,
      YollaColors.like,
    ),
    NotificationKind.suggestionRejected => (
      Icons.wrong_location_outlined,
      YollaColors.pass,
    ),
    NotificationKind.unknown => (
      Icons.notifications_none_rounded,
      YollaColors.later,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final (icon, color) = _mark;
    final placeId = notification.placeId;

    return Material(
      // Okunmamış olan hafifçe vurgulanıyor; "Yeni" etiketi de yanında duruyor
      // ki ayrım yalnızca renge bağlı kalmasın.
      color: notification.isRead
          ? theme.colorScheme.surface
          : YollaColors.brandSoft,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.md),
        onTap: placeId == null
            ? null
            : () => context.push(Routes.placeFor(placeId)),
        child: Padding(
          padding: const EdgeInsets.all(Space.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: Space.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: YollaText.subtitle,
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Space.sm,
                              vertical: Space.xxs,
                            ),
                            decoration: BoxDecoration(
                              color: YollaColors.brand.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(Radii.pill),
                            ),
                            child: Text(
                              l10n.notificationsNew,
                              style: YollaText.micro.copyWith(
                                color: YollaColors.brandDark,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: Space.xxs),
                    Text(notification.body, style: YollaText.body),
                    const SizedBox(height: Space.sm),
                    Row(
                      children: [
                        Text(
                          Format.relativeTime(context, notification.createdAt),
                          style: YollaText.micro.copyWith(
                            color: YollaColors.inkFaint,
                          ),
                        ),
                        if (placeId != null) ...[
                          const Spacer(),
                          Text(
                            l10n.notificationsOpenPlace,
                            style: YollaText.micro.copyWith(
                              color: YollaColors.brandDark,
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: YollaColors.brandDark,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
