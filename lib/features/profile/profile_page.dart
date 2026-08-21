import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/env.dart';
import '../../app/routes.dart';
import '../../core/models/device_session.dart';
import '../../core/network/api_exception.dart';
import '../../core/providers.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../notifications/notification_service.dart';
import '../session/auth_state.dart';
import 'account_service.dart';
import 'auth_sheet.dart';

/// Profil sekmesi.
///
/// Hesap zorunlu olduğu için buraya gelen herkesin oturumu açık: ekran yalnızca
/// hesabı yönetmeyi (çıkış, silme) ve kaynak bilgilerini gösteriyor.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final session = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Space.xl),
          children: [
            switch (session) {
              AsyncData(:final value) => _AccountCard(session: value),
              AsyncError(:final error) => Text(
                error is ApiException ? error.message : '$error',
                style: YollaText.body,
              ),
              _ => const Center(child: YollaLoader()),
            },
            const SizedBox(height: Space.xxl),
            _Tile(
              icon: Icons.notifications_none_rounded,
              title: l10n.profileNotifications,
              detail: l10n.profileNotificationsDetail,
              badge: ref.watch(unreadNotificationCountProvider).value,
              onTap: () => context.push(Routes.notifications),
            ),
            const SizedBox(height: Space.sm),
            _Tile(
              icon: Icons.monetization_on_outlined,
              title: l10n.profilePremium,
              detail: l10n.profilePremiumDetail,
              onTap: () => context.push(Routes.premium),
            ),
            const SizedBox(height: Space.sm),
            _Tile(
              icon: Icons.add_location_alt_outlined,
              title: l10n.profileSuggestions,
              detail: l10n.profileSuggestionsDetail,
              onTap: () => context.push(Routes.mySuggestions),
            ),
            const SizedBox(height: Space.sm),
            _Tile(
              icon: Icons.copyright_outlined,
              title: l10n.profileSources,
              detail: l10n.profileSourcesDetail,
              onTap: () => context.push(Routes.attributions),
            ),
            const SizedBox(height: Space.sm),
            _Tile(
              icon: Icons.info_outline,
              title: l10n.profileVersion,
              detail: Env.appVersion,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountCard extends ConsumerStatefulWidget {
  const _AccountCard({required this.session});

  final DeviceSession session;

  @override
  ConsumerState<_AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends ConsumerState<_AccountCard> {
  bool _isBusy = false;

  void _refreshEverything() {
    // Hesap değişince jeton da değişti; oturuma bağlı her şey yenilenmeli.
    ref.invalidate(sessionProvider);
  }

  Future<void> _signOut() async {
    setState(() => _isBusy = true);
    try {
      // Kimlik denetleyicisi oturumu sıfırlıyor; yönlendirici de bunu görüp
      // karşılama ekranına döndürüyor.
      await ref.read(authControllerProvider.notifier).signOut();
      _refreshEverything();
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _delete() async {
    final password = await showPasswordPrompt(context);
    if (password == null || !mounted) return;

    setState(() => _isBusy = true);
    try {
      await ref.read(accountServiceProvider).delete(password);
      // Hesap silindi; oturum da düştü. Kapıyı kapatmazsak kullanıcı geçersiz
      // jetonla içeride kalır.
      await ref.read(authControllerProvider.notifier).signOut();
      _refreshEverything();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.of(context).authDeleted)),
        );
      }
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return Container(
      padding: const EdgeInsets.all(Space.xl),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: YollaColors.brand.withValues(alpha: 0.14),
                child: const Icon(Icons.person, color: YollaColors.brand),
              ),
              const SizedBox(width: Space.lg),
              Expanded(
                child: Text(
                  l10n.profileSignedInTitle,
                  style: YollaText.subtitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.md),
          Text(
            l10n.profileSignedInDetail,
            style: YollaText.caption.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Space.xl),
          if (_isBusy)
            const Center(child: YollaLoader(size: 72))
          else ...[
            OutlinedButton(
              onPressed: _signOut,
              child: Text(l10n.authSignOut),
            ),
            const SizedBox(height: Space.sm),
            TextButton(
              onPressed: _delete,
              style: TextButton.styleFrom(
                foregroundColor: YollaColors.danger,
              ),
              child: Text(l10n.authDeleteAccount),
            ),
          ],
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    this.detail,
    this.badge,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? detail;

  /// Sıfırdan büyükse simgenin üstünde sayı gösterilir.
  final int? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Padding(
          padding: const EdgeInsets.all(Space.lg),
          child: Row(
            children: [
              Badge(
                isLabelVisible: (badge ?? 0) > 0,
                label: Text('${badge ?? 0}'),
                child: Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: Space.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: YollaText.body),
                    if (detail case final text?)
                      Text(
                        text,
                        style: YollaText.micro.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
