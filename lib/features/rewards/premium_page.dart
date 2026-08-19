import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/reward.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'rewards_service.dart';

/// Coin bakiyesi, premium avantajları ve premium alma.
///
/// Coin tek yoldan kazanılıyor: onaylanan fotoğraf katkısı. Harcaması da tek:
/// premium süresi. Ekonominin sayıları sunucudan geliyor
/// (`GET /rewards/kurallar`), uygulamaya gömülmüyor.
class PremiumPage extends ConsumerWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final status = ref.watch(rewardStatusProvider);
    final rules = ref.watch(rewardRulesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.premiumTitle)),
      body: SafeArea(
        child: switch ((status, rules)) {
          (AsyncData(value: final s), AsyncData(value: final r)) => _Body(
            status: s,
            rules: r,
          ),
          (AsyncError(:final error), _) || (_, AsyncError(:final error)) =>
            YollaMessage(
              icon: Icons.cloud_off_rounded,
              title: error is ApiException
                  ? error.title
                  : l10n.commonLoadFailed,
              detail: error is ApiException ? error.message : '$error',
              actionLabel: l10n.commonRetry,
              onAction: () => ref
                ..invalidate(rewardStatusProvider)
                ..invalidate(rewardRulesProvider),
            ),
          _ => const Center(child: YollaLoader()),
        },
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({required this.status, required this.rules});

  final RewardStatus status;
  final RewardRules rules;

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  bool _isBusy = false;

  Future<void> _redeem(PremiumPackage package, int cost) async {
    final l10n = L10n.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.premiumConfirmTitle),
        content: Text(l10n.premiumConfirmDetail(cost)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.premiumConfirmAction),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isBusy = true);
    try {
      await ref.read(rewardsServiceProvider).redeem(package);
      ref
        ..invalidate(rewardStatusProvider)
        ..invalidate(coinHistoryProvider);

      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(l10n.premiumRedeemed)));
    } on ApiException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.message)));
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final status = widget.status;
    final rules = widget.rules;

    return ListView(
      padding: const EdgeInsets.all(Space.xl),
      children: [
        _CoinCard(status: status, rules: rules),
        const SizedBox(height: Space.xl),

        if (status.isPremium)
          _PremiumActive(status: status)
        else ...[
          Text(l10n.premiumBenefitsTitle, style: YollaText.subtitle),
          const SizedBox(height: Space.md),
          _Benefit(
            icon: Icons.map_outlined,
            title: l10n.premiumBenefitOfflineTitle,
            detail: l10n.premiumBenefitOfflineDetail,
          ),
          _Benefit(
            icon: Icons.all_inclusive,
            title: l10n.premiumBenefitTripsTitle,
            detail: l10n.premiumBenefitTripsDetail(rules.freeMonthlyTripLimit),
          ),
          _Benefit(
            icon: Icons.block_outlined,
            title: l10n.premiumBenefitAdsTitle,
            detail: l10n.premiumBenefitAdsDetail,
          ),
          const SizedBox(height: Space.xl),

          Text(l10n.premiumWithCoinsTitle, style: YollaText.subtitle),
          const SizedBox(height: Space.xs),
          Text(
            l10n.premiumWithCoinsDetail(rules.coinsPerApprovedPhoto),
            style: YollaText.caption.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Space.md),

          _PackageRow(
            label: l10n.premiumOneMonth,
            cost: rules.coinsForOneMonth,
            balance: status.coinBalance,
            isBusy: _isBusy,
            onTap: () =>
                _redeem(PremiumPackage.oneMonth, rules.coinsForOneMonth),
          ),
          _PackageRow(
            label: l10n.premiumTwoMonths,
            cost: rules.coinsForTwoMonths,
            balance: status.coinBalance,
            isBusy: _isBusy,
            onTap: () =>
                _redeem(PremiumPackage.twoMonths, rules.coinsForTwoMonths),
          ),
          _PackageRow(
            label: l10n.premiumUnlimited,
            cost: rules.coinsForUnlimited,
            balance: status.coinBalance,
            isBusy: _isBusy,
            onTap: () =>
                _redeem(PremiumPackage.unlimited, rules.coinsForUnlimited),
          ),

          const SizedBox(height: Space.xl),
          Text(l10n.premiumWithMoneyTitle, style: YollaText.subtitle),
          const SizedBox(height: Space.xs),
          Text(
            l10n.premiumWithMoneyDetail,
            style: YollaText.caption.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Space.md),
          // Mağaza ürünleri tanımlanmadan satın alma başlatılamaz; düğme
          // görünüyor ama kapalı — olmayan bir akışa yönlendirmek yerine
          // durumu açıkça söylüyoruz.
          OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.shopping_bag_outlined, size: 18),
            label: Text(l10n.premiumWithMoneySoon),
          ),
        ],

        const SizedBox(height: Space.xxl),
        _CoinHistory(),
      ],
    );
  }
}

/// Coin bakiyesi ve bu ayki plan kotası.
class _CoinCard extends StatelessWidget {
  const _CoinCard({required this.status, required this.rules});

  final RewardStatus status;
  final RewardRules rules;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return Container(
      padding: const EdgeInsets.all(Space.xl),
      decoration: BoxDecoration(
        color: YollaColors.brand.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.monetization_on_outlined,
                color: YollaColors.brand,
                size: 28,
              ),
              const SizedBox(width: Space.md),
              Text(
                l10n.premiumCoinBalance(status.coinBalance),
                style: YollaText.display.copyWith(color: YollaColors.brand),
              ),
            ],
          ),
          const SizedBox(height: Space.sm),
          Text(
            l10n.premiumCoinHowTo(rules.coinsPerApprovedPhoto),
            style: YollaText.caption.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (status.pendingSubmissions > 0) ...[
            const SizedBox(height: Space.xs),
            Text(
              l10n.premiumPendingPhotos(status.pendingSubmissions),
              style: YollaText.micro.copyWith(color: YollaColors.brand),
            ),
          ],
          const SizedBox(height: Space.md),
          // Kota premium'da null; o durumda satır hiç gösterilmiyor.
          if (status.remainingTrips case final left?)
            Text(
              l10n.premiumTripQuota(left, status.monthlyTripLimit!),
              style: YollaText.caption.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

class _PremiumActive extends StatelessWidget {
  const _PremiumActive({required this.status});

  final RewardStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Space.xl),
      decoration: BoxDecoration(
        color: YollaColors.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.workspace_premium, color: YollaColors.accent),
          const SizedBox(height: Space.sm),
          Text(l10n.premiumActiveTitle, style: YollaText.subtitle),
          const SizedBox(height: Space.xs),
          Text(
            status.isPremiumUnlimited
                ? l10n.premiumActiveUnlimited
                : l10n.premiumActiveUntil(
                    _formatDate(status.premiumExpiresAt!),
                  ),
            style: YollaText.caption,
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day.toString().padLeft(2, '0')}.'
        '${local.month.toString().padLeft(2, '0')}.${local.year}';
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Space.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: YollaColors.accent),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: YollaText.body),
                Text(
                  detail,
                  style: YollaText.micro.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageRow extends StatelessWidget {
  const _PackageRow({
    required this.label,
    required this.cost,
    required this.balance,
    required this.isBusy,
    required this.onTap,
  });

  final String label;
  final int cost;
  final int balance;
  final bool isBusy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final affordable = balance >= cost;

    return Padding(
      padding: const EdgeInsets.only(bottom: Space.sm),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Radii.md),
        child: InkWell(
          // Bakiye yetmiyorsa dokunmak da kapalı: sunucudan hata almak yerine
          // eksik coin miktarı satırda yazıyor.
          onTap: affordable && !isBusy ? onTap : null,
          borderRadius: BorderRadius.circular(Radii.md),
          child: Padding(
            padding: const EdgeInsets.all(Space.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: YollaText.body),
                      Text(
                        affordable
                            ? l10n.premiumPackageCost(cost)
                            : l10n.premiumPackageShort(cost - balance),
                        style: YollaText.micro.copyWith(
                          color: affordable
                              ? theme.colorScheme.onSurfaceVariant
                              : theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: affordable
                      ? theme.colorScheme.onSurfaceVariant
                      : theme.colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoinHistory extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final history = ref.watch(coinHistoryProvider);

    final entries = history.value ?? const <CoinEntry>[];
    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.premiumCoinHistory, style: YollaText.subtitle),
        const SizedBox(height: Space.sm),
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: Space.xs),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    switch (entry.reason) {
                      'PhotoApproved' => l10n.premiumReasonPhoto,
                      'PremiumRedeemed' => l10n.premiumReasonRedeem,
                      _ => entry.note ?? l10n.premiumReasonAdjustment,
                    },
                    style: YollaText.caption,
                  ),
                ),
                Text(
                  entry.amount > 0 ? '+${entry.amount}' : '${entry.amount}',
                  style: YollaText.caption.copyWith(
                    color: entry.amount > 0
                        ? YollaColors.accent
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
