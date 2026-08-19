import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/routes.dart';
import '../../core/models/place_detail.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../core/media/place_image.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/place_photo.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import '../rewards/photo_contribute.dart';
import 'place_service.dart';

/// Yer detayı.
class PlaceDetailPage extends ConsumerWidget {
  const PlaceDetailPage({required this.placeId, super.key});

  final int placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final place = ref.watch(placeDetailProvider(placeId));

    return Scaffold(
      body: switch (place) {
        AsyncData(:final value) => _Body(place: value),
        AsyncError(:final error) => SafeArea(
          child: YollaMessage(
            icon: Icons.cloud_off_rounded,
            title: error is ApiException ? error.title : l10n.commonLoadFailed,
            detail: error is ApiException ? error.message : '$error',
            actionLabel: l10n.commonRetry,
            onAction: () => ref.invalidate(placeDetailProvider(placeId)),
          ),
        ),
        _ => const Center(child: YollaLoader()),
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.place});

  final PlaceDetail place;

  Future<void> _open(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(content: Text(L10n.of(context).placeLinkFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 280,
          pinned: true,
          // Başlık bir fotoğrafın üstünde; saat ve pil ikonları koyu kalırsa
          // açık renkli fotoğraflarda kayboluyor.
          systemOverlayStyle: SystemUiOverlayStyle.light,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black.withValues(alpha: 0.35),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                PlacePhoto(image: PlaceImage.fromDetail(place)),
                // Geri okunun fotoğraf üstünde okunur kalması için üstte
                // hafif bir karartma.
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [Color(0x66000000), Color(0x00000000)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(Space.xl),
          sliver: SliverList.list(
            children: [
              // Fotoğrafsız yerde atıf satırı hiç çizilmiyor.
              if (place.photoAttribution case final credit?
                  when credit.isNotEmpty) ...[
                Text(
                  credit,
                  style: YollaText.micro.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Space.lg),
              ],
              Text(place.name, style: YollaText.display),
              if (place.nameEn case final english?
                  when english.isNotEmpty && english != place.name) ...[
                const SizedBox(height: Space.xxs),
                Text(
                  english,
                  style: YollaText.caption.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: Space.sm),
              Text(
                [place.categoryName, place.locationLabel]
                    .where((e) => e.isNotEmpty)
                    .join(' · '),
                style: YollaText.caption.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (place.description case final description?
                  when description.isNotEmpty) ...[
                const SizedBox(height: Space.xl),
                Text(description, style: YollaText.body),
              ],

              // Fotoğrafsız yerde kullanıcıdan fotoğraf isteniyor. Bu ekran
              // haritadan doğrudan açılabildiği için çağrının doğal yeri burası.
              if (!PlaceImage.fromDetail(place).canDisplay) ...[
                const SizedBox(height: Space.xl),
                ContributePhotoCard(
                  placeId: place.id,
                  placeName: place.name,
                ),
              ],

              const SizedBox(height: Space.xl),

              // OSM verisi seyrek: bu alanların çoğu çoğu yerde boş.
              _Fact(
                icon: Icons.place_outlined,
                label: l10n.placeAddress,
                value: place.address,
              ),
              _Fact(
                icon: Icons.schedule_outlined,
                label: l10n.placeOpeningHours,
                value: place.openingHours,
              ),
              _Fact(
                icon: Icons.hourglass_empty,
                label: l10n.placeAverageVisit,
                value: place.averageVisitMinutes == null
                    ? null
                    : l10n.placeAverageVisitValue(place.averageVisitMinutes!),
              ),

              const SizedBox(height: Space.lg),
              if (place.directionsUrl case final url?)
                FilledButton.icon(
                  onPressed: () => _open(context, url),
                  icon: const Icon(Icons.directions_rounded),
                  label: Text(l10n.placeDirections),
                ),
              const SizedBox(height: Space.sm),
              Row(
                children: [
                  if (place.website case final url?)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _open(context, url),
                        icon: const Icon(Icons.language, size: 18),
                        label: Text(l10n.placeWebsite),
                      ),
                    ),
                  if (place.website != null && place.wikipediaUrl != null)
                    const SizedBox(width: Space.sm),
                  if (place.wikipediaUrl case final url?)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _open(context, url),
                        icon: const Icon(Icons.menu_book_outlined, size: 18),
                        label: Text(l10n.placeWikipedia),
                      ),
                    ),
                ],
              ),

              if (place.nearby.isNotEmpty) ...[
                const SizedBox(height: Space.xxl),
                Text(l10n.placeNearby, style: YollaText.subtitle),
                const SizedBox(height: Space.md),
                for (final nearby in place.nearby)
                  _NearbyRow(place: nearby),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final text = value;
    if (text == null || text.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Space.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: YollaText.micro.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(text, style: YollaText.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Yakındaki yer satırı.
///
/// Atıf sunucudan geldiği için görselli çiziliyor. Atfı olmayan kayıtlarda
/// [PlacePhoto] görsel yerine yedek görünüm gösterir.
class _NearbyRow extends StatelessWidget {
  const _NearbyRow({required this.place});

  final NearbyPlace place;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Space.sm),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Radii.md),
        child: InkWell(
          onTap: () => context.push(Routes.placeFor(place.id)),
          borderRadius: BorderRadius.circular(Radii.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Space.lg,
              vertical: Space.md,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.sm),
                  child: SizedBox(
                    width: 52,
                    height: 52,
                    child: PlacePhoto(
                      image: PlaceImage.fromNearby(place),
                      size: PhotoSize.thumb,
                    ),
                  ),
                ),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: YollaText.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        [
                          ?place.categoryName,
                          place.distanceLabel,
                        ].join(' · '),
                        style: YollaText.micro.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      // Atıf, görselin yanında durmak zorunda.
                      if (place.photoAttribution case final credit?
                          when credit.isNotEmpty)
                        Text(
                          credit,
                          style: YollaText.micro.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
