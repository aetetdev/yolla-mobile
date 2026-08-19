import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/models/enums.dart';
import '../../../core/models/place_card.dart';
import '../../../core/theme/yolla_colors.dart';
import '../../../core/theme/yolla_tokens.dart';
import '../../../core/theme/yolla_typography.dart';
import '../../../l10n/app_localizations.dart';
import 'place_card_view.dart';

/// Deste dışından kaydırma tetiklemek için — alttaki düğmeler bunu kullanır.
class SwipeDeckController extends ChangeNotifier {
  SwipeDirection? _requested;

  void fling(SwipeDirection direction) {
    _requested = direction;
    notifyListeners();
  }

  SwipeDirection? takeRequest() {
    final request = _requested;
    _requested = null;
    return request;
  }
}

/// Kaydırılabilir kart destesi.
///
/// Dört yön farklı iş yapar:
/// sağ = plana ekle · sol = geç · aşağı = sonra bakarım · yukarı = ayrıntı.
/// Yukarı kaydırma kartı **tüketmez**; kart yerine yaylanır ve ayrıntı açılır.
class SwipeDeck extends StatefulWidget {
  const SwipeDeck({
    required this.top,
    required this.next,
    required this.onSwipe,
    this.onDetail,
    this.controller,
    super.key,
  });

  final PlaceCard? top;
  final PlaceCard? next;
  final ValueChanged<SwipeDirection> onSwipe;
  final VoidCallback? onDetail;
  final SwipeDeckController? controller;

  @override
  State<SwipeDeck> createState() => _SwipeDeckState();
}

class _SwipeDeckState extends State<SwipeDeck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: Motion.normal,
  )..addListener(_onTick);

  Offset _drag = Offset.zero;
  Offset _from = Offset.zero;
  Offset _to = Offset.zero;

  /// Uçuş bittiğinde bildirilecek yön. Null ise kart geri yaylanıyordur.
  SwipeDirection? _flyingTo;

  Size _deckSize = Size.zero;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onControllerRequest);
  }

  @override
  void didUpdateWidget(SwipeDeck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerRequest);
      widget.controller?.addListener(_onControllerRequest);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerRequest);
    _animation.dispose();
    super.dispose();
  }

  void _onControllerRequest() {
    final request = widget.controller?.takeRequest();
    if (request != null && !_animation.isAnimating && widget.top != null) {
      _flyOut(request);
    }
  }

  void _onTick() {
    setState(() {
      _drag = Offset.lerp(_from, _to, Curves.easeOutCubic.transform(_animation.value))!;
    });

    if (_animation.isCompleted) {
      final direction = _flyingTo;
      _flyingTo = null;
      _drag = Offset.zero;
      _from = Offset.zero;
      _to = Offset.zero;
      _animation.value = 0;

      if (direction != null) widget.onSwipe(direction);
    }
  }

  // --- Sürükleme ---

  void _onPanUpdate(DragUpdateDetails details) {
    if (_animation.isAnimating) return;
    setState(() => _drag += details.delta);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_animation.isAnimating) return;

    final velocity = details.velocity.pixelsPerSecond;
    final width = _deckSize.width;
    final height = _deckSize.height;

    final horizontalIntent =
        _drag.dx.abs() > width * 0.26 || velocity.dx.abs() > 720;
    final verticalIntent =
        _drag.dy.abs() > height * 0.20 || velocity.dy.abs() > 720;

    // Baskın eksen: kullanıcı çapraz sürüklediğinde hangi niyetin daha güçlü
    // olduğuna karar verilmeli, yoksa "geç" ile "sonra" karışır.
    final horizontalDominant = _drag.dx.abs() >= _drag.dy.abs();

    if (horizontalIntent && horizontalDominant) {
      _flyOut(_drag.dx > 0 ? SwipeDirection.like : SwipeDirection.pass);
      return;
    }

    if (verticalIntent && !horizontalDominant) {
      if (_drag.dy > 0) {
        _flyOut(SwipeDirection.later);
      } else {
        // Yukarı: kart kalır, ayrıntı açılır.
        _springBack();
        widget.onDetail?.call();
      }
      return;
    }

    _springBack();
  }

  void _springBack() {
    _flyingTo = null;
    _from = _drag;
    _to = Offset.zero;
    _animation.duration = Motion.slow;
    _animation.forward(from: 0);
  }

  void _flyOut(SwipeDirection direction) {
    HapticFeedback.selectionClick();

    final width = _deckSize.width == 0 ? 400.0 : _deckSize.width;
    final height = _deckSize.height == 0 ? 700.0 : _deckSize.height;

    _flyingTo = direction;
    _from = _drag;
    _to = switch (direction) {
      SwipeDirection.like => Offset(width * 1.6, _drag.dy - 60),
      SwipeDirection.pass => Offset(-width * 1.6, _drag.dy - 60),
      SwipeDirection.later => Offset(_drag.dx, height * 1.4),
    };
    _animation.duration = Motion.normal;
    _animation.forward(from: 0);
  }

  // --- Damga görünürlüğü ---

  /// 0..1 — kaydırmanın o yöndeki tamamlanma oranı.
  double _progressFor(SwipeDirection direction) {
    if (_deckSize == Size.zero) return 0;

    final value = switch (direction) {
      SwipeDirection.like => _drag.dx / (_deckSize.width * 0.26),
      SwipeDirection.pass => -_drag.dx / (_deckSize.width * 0.26),
      SwipeDirection.later => _drag.dy / (_deckSize.height * 0.20),
    };

    // Yatay hareket dikeyden baskınsa dikey damga gösterilmemeli.
    final horizontalDominant = _drag.dx.abs() >= _drag.dy.abs();
    final matchesAxis = direction == SwipeDirection.later
        ? !horizontalDominant
        : horizontalDominant;
    if (!matchesAxis) return 0;

    return value.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final top = widget.top;

    return LayoutBuilder(
      builder: (context, constraints) {
        _deckSize = Size(constraints.maxWidth, constraints.maxHeight);

        final next = widget.next;
        // Arkadaki kart, öndeki uzaklaştıkça öne çıkar.
        final reveal = _deckSize.width == 0
            ? 0.0
            : (_drag.distance / (_deckSize.width * 0.6)).clamp(0.0, 1.0);

        return Stack(
          alignment: Alignment.center,
          children: [
            if (next != null)
              Transform.scale(
                scale: 0.94 + 0.06 * reveal,
                child: Opacity(
                  opacity: 0.55 + 0.45 * reveal,
                  child: PlaceCardView(card: next, isBackground: true),
                ),
              ),
            if (top != null)
              Transform.translate(
                offset: _drag,
                child: Transform.rotate(
                  angle: _deckSize.width == 0
                      ? 0
                      : (_drag.dx / _deckSize.width) * 0.30,
                  child: GestureDetector(
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PlaceCardView(card: top, onDetailTap: widget.onDetail),
                        _Stamp(
                          label: L10n.of(context).deckStampLike,
                          color: YollaColors.like,
                          alignment: Alignment.topLeft,
                          angle: -math.pi / 14,
                          opacity: _progressFor(SwipeDirection.like),
                        ),
                        _Stamp(
                          label: L10n.of(context).deckStampPass,
                          color: YollaColors.pass,
                          alignment: Alignment.topRight,
                          angle: math.pi / 14,
                          opacity: _progressFor(SwipeDirection.pass),
                        ),
                        _Stamp(
                          label: L10n.of(context).deckStampLater,
                          color: YollaColors.later,
                          alignment: Alignment.bottomCenter,
                          angle: 0,
                          opacity: _progressFor(SwipeDirection.later),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Kaydırma sırasında kartın üstünde beliren damga.
class _Stamp extends StatelessWidget {
  const _Stamp({
    required this.label,
    required this.color,
    required this.alignment,
    required this.angle,
    required this.opacity,
  });

  final String label;
  final Color color;
  final Alignment alignment;
  final double angle;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    if (opacity <= 0.01) return const SizedBox.shrink();

    return IgnorePointer(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(Space.xxl),
          child: Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: angle,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Space.lg,
                  vertical: Space.sm,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 4),
                  borderRadius: BorderRadius.circular(Radii.md),
                  color: color.withValues(alpha: 0.18),
                ),
                child: Text(
                  label,
                  style: YollaText.stamp.copyWith(color: color),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
