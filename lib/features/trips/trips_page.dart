import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/enums.dart';
import '../../core/models/trip.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../core/media/place_image.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/place_photo.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'trips_service.dart';

/// Kullanıcının gezi planları.
class TripsPage extends ConsumerWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final trips = ref.watch(tripsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tripsTitle)),
      body: SafeArea(
        child: switch (trips) {
          AsyncData(:final value) when value.isEmpty => YollaMessage(
            icon: Icons.map_outlined,
            title: l10n.tripsEmptyTitle,
            detail: l10n.tripsEmptyDetail,
            actionLabel: l10n.tripsEmptyAction,
            onAction: () => context.go(Routes.cityPicker),
          ),
          AsyncData(:final value) => RefreshIndicator(
            onRefresh: () async => ref.invalidate(tripsProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(Space.lg),
              itemCount: value.length,
              separatorBuilder: (_, _) => const SizedBox(height: Space.sm),
              itemBuilder: (context, index) => _TripRow(trip: value[index]),
            ),
          ),
          AsyncError(:final error) => YollaMessage(
            icon: Icons.cloud_off_rounded,
            title: error is ApiException ? error.title : l10n.commonLoadFailed,
            detail: error is ApiException ? error.message : '$error',
            actionLabel: l10n.commonRetry,
            onAction: () => ref.invalidate(tripsProvider),
          ),
          _ => const Center(child: YollaLoader()),
        },
      ),
    );
  }
}

class _TripRow extends StatelessWidget {
  const _TripRow({required this.trip});

  final TripSummary trip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: () => context.push(Routes.tripFor(trip.id)),
        borderRadius: BorderRadius.circular(Radii.md),
        child: Padding(
          padding: const EdgeInsets.all(Space.sm),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Radii.sm),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: PlacePhoto(
                    image: PlaceImage.fromTrip(trip),
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
                      trip.name,
                      style: YollaText.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Space.xxs),
                    Text(
                      _summary(context, trip),
                      style: YollaText.caption.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Kapak görselinin atfı yanında durmak zorunda.
                    if (trip.coverPhotoAttribution case final credit?
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
              const SizedBox(width: Space.sm),
              Icon(
                trip.travelMode == TravelMode.foot
                    ? Icons.directions_walk
                    : Icons.directions_car,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _summary(BuildContext context, TripSummary trip) {
    final l10n = L10n.of(context);
    final parts = <String>[
      ?trip.cityName,
      l10n.tripStopCount(trip.placeCount),
      ?trip.distanceLabel,
      if (!trip.hasRoute && trip.placeCount > 0) l10n.tripRouteNotComputed,
    ];
    return parts.join(' · ');
  }
}
