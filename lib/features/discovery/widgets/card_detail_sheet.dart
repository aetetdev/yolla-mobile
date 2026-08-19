import 'package:flutter/material.dart';

import '../../../core/models/place_card.dart';
import '../../../core/theme/yolla_tokens.dart';
import '../../../core/theme/yolla_typography.dart';
import '../../../core/media/place_image.dart';
import '../../../shared/widgets/place_photo.dart';

/// Kartın hızlı önizlemesi.
///
/// Tam yer detayı ayrı bir ekran olacak ve `/places/{id}` ucundan adres,
/// çalışma saatleri, yakındakiler ve yol tarifi bağlantısını da getirecek.
/// Bu sayfa yalnızca destede elde olan alanları gösterir; kullanıcı kaydırmayı
/// bölmeden "bu neymiş" sorusuna cevap alsın diye var.
Future<void> showCardDetailSheet(BuildContext context, PlaceCard card) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _CardDetailSheet(card: card),
  );
}

class _CardDetailSheet extends StatelessWidget {
  const _CardDetailSheet({required this.card});

  final PlaceCard card;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.62,
      maxChildSize: 0.92,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(
          Space.xl,
          0,
          Space.xl,
          Space.xxl,
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.lg),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: PlacePhoto(image: PlaceImage.fromCard(card)),
            ),
          ),
          // Atıf yalnızca fotoğraf varken var; fotoğrafsız yerde satır hiç
          // çizilmiyor.
          if (card.photoAttribution case final credit?
              when credit.isNotEmpty) ...[
            const SizedBox(height: Space.md),
            Text(
              credit,
              style: YollaText.micro.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: Space.lg),
          Text(card.name, style: YollaText.title),
          const SizedBox(height: Space.xs),
          Text(
            [card.categoryName, card.locationLabel]
                .where((e) => e.isNotEmpty)
                .join(' · '),
            style: YollaText.caption.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (card.description case final description?
              when description.isNotEmpty) ...[
            const SizedBox(height: Space.lg),
            Text(description, style: YollaText.body),
          ],
          if (card.averageVisitMinutes case final minutes?) ...[
            const SizedBox(height: Space.lg),
            Row(
              children: [
                const Icon(Icons.schedule, size: 16),
                const SizedBox(width: Space.sm),
                Text('Ortalama $minutes dakika', style: YollaText.caption),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
