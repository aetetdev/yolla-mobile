import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/enums.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import '../trips/trips_service.dart';
import 'deck_controller.dart';
import 'deck_source.dart';
import 'widgets/card_detail_sheet.dart';
import 'widgets/swipe_deck.dart';

/// Kart destesi ekranı — ürünün kalbi.
class DeckPage extends ConsumerStatefulWidget {
  const DeckPage({required this.source, super.key});

  final DeckSource source;

  @override
  ConsumerState<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends ConsumerState<DeckPage>
    with WidgetsBindingObserver {
  final _deck = SwipeDeckController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(deckControllerProvider.notifier).open(widget.source);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _deck.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Uygulama arka plana giderken biriken kaydırmalar gönderilir; kullanıcı
    // uygulamayı kapatırsa kaybolmasın.
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      ref.read(deckControllerProvider.notifier).flushNow();
    }
  }

  void _swipe(SwipeDirection direction) => _deck.fling(direction);

  void _openDetail() {
    final card = ref.read(deckControllerProvider).top;
    if (card == null) return;
    showCardDetailSheet(context, card);
  }

  /// Beğenilenlere geçer. Kaydırmalar önce gönderilir, yoksa liste eksik gelir.
  Future<void> _openLiked() async {
    await ref.read(deckControllerProvider.notifier).flushNow();
    if (!mounted) return;
    ref.invalidate(likedPlacesProvider);

    // Şehir içi plan bir şehre bağlanmak zorunda; koridor modunda şehir yok.
    final source = widget.source;
    final cityId = source is CityDeckSource ? source.city.id : null;
    context.push(Routes.likedFor(cityId));
  }

  Future<void> _undo() async {
    final undone = await ref.read(deckControllerProvider.notifier).undo();
    if (!undone && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context).deckUndoFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deckControllerProvider);
    final notifier = ref.read(deckControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.source.title),
        actions: [
          if (state.likedCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: Space.lg),
              child: Center(
                child: _LikedPill(
                  count: state.likedCount,
                  onTap: _openLiked,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: Column(
            children: [
              Expanded(
                child: _DeckArea(
                  deck: _deck,
                  onDetail: _openDetail,
                  onFinish: _openLiked,
                ),
              ),
              const SizedBox(height: Space.lg),
              _Actions(
                enabled: state.top != null,
                canUndo: notifier.canUndo,
                onSwipe: _swipe,
                onUndo: _undo,
              ),
              const SizedBox(height: Space.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeckArea extends ConsumerWidget {
  const _DeckArea({
    required this.deck,
    required this.onDetail,
    required this.onFinish,
  });

  final SwipeDeckController deck;
  final VoidCallback onDetail;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final state = ref.watch(deckControllerProvider);
    final notifier = ref.read(deckControllerProvider.notifier);

    if (state.isLoading && state.cards.isEmpty) {
      return const Center(child: YollaLoader());
    }

    if (state.error case final error? when state.cards.isEmpty) {
      return YollaMessage(
        icon: Icons.wifi_off_rounded,
        title: error.title,
        detail: error.message,
        actionLabel: error.isRetryable ? l10n.commonRetry : null,
        onAction: notifier.retry,
      );
    }

    if (state.cards.isEmpty && state.isExhausted) {
      return YollaMessage(
        icon: state.likedCount > 0
            ? Icons.check_circle_outline
            : Icons.explore_off_outlined,
        title: state.likedCount > 0
            ? l10n.deckFinishedTitle
            : l10n.deckEmptyTitle,
        detail: state.likedCount > 0
            ? l10n.deckFinishedDetail(state.likedCount)
            : l10n.deckEmptyDetail,
        actionLabel: state.likedCount > 0 ? l10n.deckCreatePlan : null,
        onAction: state.likedCount > 0 ? onFinish : null,
      );
    }

    return SwipeDeck(
      top: state.top,
      next: state.next,
      controller: deck,
      onDetail: onDetail,
      onSwipe: notifier.swipe,
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.enabled,
    required this.canUndo,
    required this.onSwipe,
    required this.onUndo,
  });

  final bool enabled;
  final bool canUndo;
  final ValueChanged<SwipeDirection> onSwipe;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionButton(
          icon: Icons.undo_rounded,
          color: YollaColors.inkFaint,
          tooltip: l10n.deckActionUndo,
          size: 48,
          onTap: canUndo ? onUndo : null,
        ),
        _ActionButton(
          icon: Icons.close_rounded,
          color: YollaColors.pass,
          tooltip: l10n.deckActionPass,
          onTap: enabled ? () => onSwipe(SwipeDirection.pass) : null,
        ),
        _ActionButton(
          icon: Icons.schedule_rounded,
          color: YollaColors.later,
          tooltip: l10n.deckActionLater,
          size: 48,
          onTap: enabled ? () => onSwipe(SwipeDirection.later) : null,
        ),
        _ActionButton(
          icon: Icons.favorite_rounded,
          color: YollaColors.like,
          tooltip: l10n.deckActionLike,
          onTap: enabled ? () => onSwipe(SwipeDirection.like) : null,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
    this.size = 62,
  });

  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onTap != null;

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        enabled: isEnabled,
        label: tooltip,
        child: Material(
          color: theme.colorScheme.surface,
          shape: CircleBorder(
            side: BorderSide(
              color: isEnabled
                  ? color.withValues(alpha: 0.35)
                  : theme.colorScheme.outline,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                color: isEnabled ? color : theme.colorScheme.outline,
                size: size * 0.42,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LikedPill extends StatelessWidget {
  const _LikedPill({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: L10n.of(context).deckLikedSemantics(count),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.md,
            vertical: Space.xs + 1,
          ),
          decoration: BoxDecoration(
            color: YollaColors.like.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(Radii.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.favorite_rounded,
                size: 14,
                color: YollaColors.like,
              ),
              const SizedBox(width: Space.xs),
              Text(
                '$count',
                style: YollaText.caption.copyWith(color: YollaColors.like),
              ),
              const SizedBox(width: Space.xxs),
              const Icon(
                Icons.chevron_right,
                size: 16,
                color: YollaColors.like,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
