import 'package:flutter/material.dart';

import '../../../core/models/place_card.dart';
import '../../../core/theme/yolla_colors.dart';
import '../../../core/theme/yolla_tokens.dart';
import '../../../core/theme/yolla_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/media/place_image.dart';
import '../../../shared/widgets/place_photo.dart';

/// Destedeki tek bir kart.
///
/// Kart baştan sona fotoğraf; metin fotoğrafın üstünde karartma üzerine
/// yazılır. Fotoğrafın açık ya da koyu olması önceden bilinemediği için
/// karartma her kartta var.
class PlaceCardView extends StatelessWidget {
  const PlaceCardView({
    required this.card,
    this.onDetailTap,
    this.isBackground = false,
    super.key,
  });

  final PlaceCard card;
  final VoidCallback? onDetailTap;

  /// Arkadaki kart: etkileşimsiz ve daha ucuz çizilir.
  final bool isBackground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.card),
        color: YollaColors.surfaceMutedDark,
        boxShadow: isBackground
            ? null
            : const [
                BoxShadow(
                  color: Color(0x2E000000),
                  blurRadius: 28,
                  offset: Offset(0, 12),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Radii.card),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PlacePhoto(image: PlaceImage.fromCard(card)),
            const _Scrim(),
            if (!isBackground) _Content(card: card, onTap: onDetailTap),
          ],
        ),
      ),
    );
  }
}

class _Scrim extends StatelessWidget {
  const _Scrim();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: YollaColors.scrim,
          stops: YollaColors.scrimStops,
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.card, this.onTap});

  final PlaceCard card;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Space.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Badge(
                icon: Icons.local_offer_outlined,
                label: card.categoryName,
              ),
              if (card.detourLabel case final detour?) ...[
                const SizedBox(width: Space.sm),
                _Badge(icon: Icons.alt_route, label: detour),
              ],
            ],
          ),
          const Spacer(),
          Text(
            card.name,
            style: YollaText.title.copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (card.locationLabel.isNotEmpty) ...[
            const SizedBox(height: Space.xs),
            Row(
              children: [
                const Icon(
                  Icons.place_outlined,
                  size: 15,
                  color: Colors.white70,
                ),
                const SizedBox(width: Space.xs),
                Expanded(
                  child: Text(
                    card.locationLabel,
                    style: YollaText.caption.copyWith(color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          if (card.description case final description?
              when description.isNotEmpty) ...[
            const SizedBox(height: Space.sm),
            Text(
              description,
              style: YollaText.body.copyWith(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: Space.md),
          Row(
            children: [
              // Atıf gösterimi hukuki zorunluluk (Commons görselleri çoğunlukla
              // CC BY-SA). Tasarım gereği küçük ama silinemez.
              //
              // Fotoğrafsız kart destede çıkmıyor (sunucu eliyor); yine de
              // atıf null gelirse yeri boş bırakılıyor, uydurma metin
              // yazılmıyor.
              Expanded(
                child: switch (card.photoAttribution) {
                  final credit? when credit.isNotEmpty => Text(
                    credit,
                    style: YollaText.micro.copyWith(color: Colors.white60),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _ => const SizedBox.shrink(),
                },
              ),
              const SizedBox(width: Space.sm),
              _DetailButton(onTap: onTap),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Space.md,
        vertical: Space.xs + 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: Space.xs + 2),
          Text(
            label,
            style: YollaText.micro.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _DetailButton extends StatelessWidget {
  const _DetailButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: L10n.of(context).deckDetailSemantics,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.md,
            vertical: Space.xs + 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(Radii.pill),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.keyboard_arrow_up,
                size: 15,
                color: Colors.white,
              ),
              const SizedBox(width: Space.xxs),
              Text(
                L10n.of(context).deckDetail,
                style: YollaText.micro.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
