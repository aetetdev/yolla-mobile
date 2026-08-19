import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';

/// Keşfet sekmesinin kökü: iki mod arasında seçim.
///
/// Ürünün iki ayrı işi var ve ikisi farklı soru soruyor — "hangi şehirdesin"
/// ile "nereden nereye gidiyorsun". Tek bir akışa sıkıştırmak yerine girişte
/// ayrılıyorlar.
class ModePage extends StatelessWidget {
  const ModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Space.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Space.xl),
              Text(l10n.appName, style: YollaText.display),
              const SizedBox(height: Space.xs),
              Text(
                l10n.appTagline,
                style: YollaText.body.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: Space.xxl),
              _ModeCard(
                icon: Icons.location_city_rounded,
                title: l10n.modeCityTitle,
                detail: l10n.modeCityDetail,
                color: YollaColors.brand,
                onTap: () => context.go(Routes.cityPicker),
              ),
              const SizedBox(height: Space.lg),
              _ModeCard(
                icon: Icons.alt_route_rounded,
                title: l10n.modeRouteTitle,
                detail: l10n.modeRouteDetail,
                color: YollaColors.accent,
                onTap: () => context.go(Routes.corridor),
              ),
              const SizedBox(height: Space.lg),

              // Beğeniler artık keşif oturumuna bağlı: bir desteyi bitirince
              // plana yalnızca o destede beğenilenler giriyor. Eski beğeniler
              // kaybolmuyor, girişleri burası — kullanıcı hazır olduğunda
              // onlardan ayrı bir plan kuruyor.
              _ModeCard(
                icon: Icons.favorite_rounded,
                title: l10n.modeLikedTitle,
                detail: l10n.modeLikedDetail,
                color: YollaColors.like,
                onTap: () => context.push(Routes.likedFor(null)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.icon,
    required this.title,
    required this.detail,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String detail;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(Radii.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.lg),
        child: Padding(
          padding: const EdgeInsets.all(Space.xl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(Radii.md),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: Space.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: YollaText.subtitle),
                    const SizedBox(height: Space.xs),
                    Text(
                      detail,
                      style: YollaText.caption.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
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
