import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/place_suggestion.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'place_suggestion_service.dart';

/// Kullanıcının önerdiği yerler ve durumları.
///
/// Öneri gönderdikten sonra ne olduğunu görebileceği tek yer burası: bekliyor
/// mu, kataloğa girdi mi, reddedildiyse neden.
class MySuggestionsPage extends ConsumerWidget {
  const MySuggestionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final suggestions = ref.watch(mySuggestionsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mySuggestionsTitle)),
      body: switch (suggestions) {
        AsyncData(:final value) when value.isEmpty => YollaMessage(
          icon: Icons.add_location_alt_outlined,
          title: l10n.mySuggestionsEmptyTitle,
          detail: l10n.mySuggestionsEmptyDetail,
        ),
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(mySuggestionsProvider),
          child: ListView.separated(
            padding: const EdgeInsets.all(Space.xl),
            itemCount: value.length,
            separatorBuilder: (_, _) => const SizedBox(height: Space.md),
            itemBuilder: (context, index) => _SuggestionCard(value[index]),
          ),
        ),
        AsyncError(:final error) => YollaMessage(
          icon: Icons.wifi_off_rounded,
          title: error is ApiException ? error.title : l10n.commonLoadFailed,
          detail: error is ApiException ? error.message : '$error',
          actionLabel: l10n.commonRetry,
          onAction: () => ref.invalidate(mySuggestionsProvider),
        ),
        _ => const Center(child: YollaLoader()),
      },
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard(this.suggestion);

  final PlaceSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    // Durum rengi metinle birlikte veriliyor; rengi tek başına anlam taşıyan
    // bir gösterge yapmak renk körlüğünde okunmaz oluyor.
    final (color, label) = switch (suggestion) {
      final s when s.isApproved => (YollaColors.like, l10n.suggestStatusApproved),
      final s when s.isRejected => (YollaColors.pass, l10n.suggestStatusRejected),
      _ => (YollaColors.later, l10n.suggestStatusPending),
    };

    return Container(
      padding: const EdgeInsets.all(Space.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(color: YollaColors.accentSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(suggestion.name, style: YollaText.subtitle),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Space.sm,
                  vertical: Space.xxs,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
                child: Text(
                  label,
                  style: YollaText.micro.copyWith(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.xxs),
          Text(
            '${suggestion.categoryName} · ${suggestion.cityName}',
            style: YollaText.caption.copyWith(color: YollaColors.inkFaint),
          ),

          if (suggestion.rejectionReason case final reason?) ...[
            const SizedBox(height: Space.sm),
            Text(reason, style: YollaText.caption),
          ],

          if (suggestion.coinsAwarded case final coins?) ...[
            const SizedBox(height: Space.sm),
            Text(
              l10n.suggestCoinsEarned(coins),
              style: YollaText.caption.copyWith(color: YollaColors.like),
            ),
          ],

          // Kataloğa giren öneri artık gerçek bir yer; kullanıcı gidip
          // görebilmeli.
          if (suggestion.placeId case final placeId?) ...[
            const SizedBox(height: Space.sm),
            TextButton.icon(
              onPressed: () => context.push(Routes.placeFor(placeId)),
              icon: const Icon(Icons.open_in_new_rounded, size: 16),
              label: Text(l10n.suggestOpenPlace),
            ),
          ],
        ],
      ),
    );
  }
}
