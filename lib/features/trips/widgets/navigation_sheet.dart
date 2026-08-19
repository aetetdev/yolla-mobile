import 'package:flutter/material.dart';

import '../../../core/models/trip.dart';
import '../../../core/theme/yolla_tokens.dart';
import '../../../core/theme/yolla_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/yolla_loader.dart';
import '../navigation_handoff.dart';

/// Rotayı hangi navigasyon uygulamasına göndereceğini sorar.
///
/// Tek seçenek varsa da sayfa gösteriliyor: her hedefin durak sınırı farklı ve
/// kullanıcının kaç durağın aktarılamadığını görmesi gerekiyor.
Future<void> showNavigationSheet(BuildContext context, Trip trip) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) => _NavigationSheet(trip: trip),
  );
}

class _NavigationSheet extends StatefulWidget {
  const _NavigationSheet({required this.trip});

  final Trip trip;

  @override
  State<_NavigationSheet> createState() => _NavigationSheetState();
}

class _NavigationSheetState extends State<_NavigationSheet> {
  late final Future<List<NavigationTarget>> _targets =
      NavigationHandoff.available(widget.trip);

  Future<void> _open(NavigationTarget target) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = L10n.of(context);
    final navigator = Navigator.of(context);

    final opened = await NavigationHandoff.open(target);

    if (!mounted) return;
    navigator.pop();

    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.navHandoffFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Space.xl,
          0,
          Space.xl,
          Space.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.navHandoffTitle, style: YollaText.title),
            const SizedBox(height: Space.xs),
            Text(
              l10n.navHandoffDetail,
              style: YollaText.caption.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Space.xl),
            FutureBuilder<List<NavigationTarget>>(
              future: _targets,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: Space.xl),
                    child: Center(child: YollaLoader(size: 72)),
                  );
                }

                final targets = snapshot.data!;
                if (targets.isEmpty) {
                  return Text(l10n.navHandoffNone, style: YollaText.body);
                }

                return Column(
                  children: [
                    for (final target in targets) ...[
                      _TargetTile(target: target, onTap: () => _open(target)),
                      const SizedBox(height: Space.sm),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TargetTile extends StatelessWidget {
  const _TargetTile({required this.target, required this.onTap});

  final NavigationTarget target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    final name = switch (target.app) {
      NavigationApp.googleMaps => l10n.navAppGoogleMaps,
      NavigationApp.yandexMaps => l10n.navAppYandexMaps,
      NavigationApp.yandexNavi => l10n.navAppYandexNavi,
      NavigationApp.appleMaps => l10n.navAppAppleMaps,
    };

    return Material(
      color: theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Padding(
          padding: const EdgeInsets.all(Space.lg),
          child: Row(
            children: [
              Icon(Icons.navigation_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: Space.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: YollaText.body),
                    // Kırpma sessizce yapılmıyor: kullanıcı kaç durağın
                    // gitmediğini bilmeli, yoksa eksik rotayı doğru sanar.
                    if (!target.isComplete)
                      Text(
                        l10n.navHandoffDropped(target.droppedStops),
                        style: YollaText.micro.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.open_in_new,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
