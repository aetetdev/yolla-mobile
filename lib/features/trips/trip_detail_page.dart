import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/enums.dart';
import '../../core/models/trip.dart';
import '../../core/network/api_exception.dart';
import '../../core/trip_rules.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../core/media/place_image.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/format.dart';
import '../../shared/widgets/place_photo.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'trips_service.dart';
import 'widgets/navigation_sheet.dart';
import 'widgets/trip_map.dart';

/// Plan detayı: duraklar, hesaplanmış rota ve harita.
class TripDetailPage extends ConsumerStatefulWidget {
  const TripDetailPage({required this.tripId, super.key});

  final int tripId;

  @override
  ConsumerState<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends ConsumerState<TripDetailPage> {
  bool _isBusy = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _isBusy = true);
    try {
      await action();
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _optimize() => _run(() async {
    await ref.read(tripsServiceProvider).optimize(widget.tripId);
    ref
      ..invalidate(tripProvider(widget.tripId))
      ..invalidate(tripsProvider);
  });

  Future<void> _removePlace(int placeId) => _run(() async {
    await ref
        .read(tripsServiceProvider)
        .updatePlaces(widget.tripId, remove: [placeId]);
    ref
      ..invalidate(tripProvider(widget.tripId))
      ..invalidate(tripsProvider);
  });

  Future<void> _rename(String current) async {
    final l10n = L10n.of(context);
    final controller = TextEditingController(text: current);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.tripRenameTitle),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(context).pop(controller.text.trim()),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );

    if (name == null || name.isEmpty) return;
    await _run(() async {
      await ref.read(tripsServiceProvider).rename(widget.tripId, name);
      ref
        ..invalidate(tripProvider(widget.tripId))
        ..invalidate(tripsProvider);
    });
  }

  Future<void> _delete() async {
    final l10n = L10n.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.tripDeleteTitle),
        content: Text(l10n.tripDeleteDetail),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: YollaColors.danger,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await _run(() async {
      await ref.read(tripsServiceProvider).delete(widget.tripId);
      ref.invalidate(tripsProvider);
      if (mounted) context.go(Routes.trips);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final trip = ref.watch(tripProvider(widget.tripId));

    return Scaffold(
      appBar: AppBar(
        title: Text(trip.value?.name ?? l10n.tripFallbackTitle),
        actions: [
          if (trip.value case final value?)
            PopupMenuButton<String>(
              onSelected: (action) => switch (action) {
                'rename' => _rename(value.name),
                'delete' => _delete(),
                _ => null,
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'rename', child: Text(l10n.tripRename)),
                PopupMenuItem(value: 'delete', child: Text(l10n.tripDelete)),
              ],
            ),
        ],
      ),
      body: SafeArea(
        child: switch (trip) {
          AsyncData(:final value) => _Body(
            trip: value,
            isBusy: _isBusy,
            onOptimize: _optimize,
            onRemove: _removePlace,
          ),
          AsyncError(:final error) => YollaMessage(
            icon: Icons.cloud_off_rounded,
            title: error is ApiException ? error.title : l10n.commonLoadFailed,
            detail: error is ApiException ? error.message : '$error',
            actionLabel: l10n.commonRetry,
            onAction: () => ref.invalidate(tripProvider(widget.tripId)),
          ),
          _ => const Center(child: YollaLoader()),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.trip,
    required this.isBusy,
    required this.onOptimize,
    required this.onRemove,
  });

  final Trip trip;
  final bool isBusy;
  final VoidCallback onOptimize;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    if (trip.isEmpty) {
      final l10n = L10n.of(context);
      return YollaMessage(
        icon: Icons.playlist_remove_rounded,
        title: l10n.tripNoStopsTitle,
        detail: l10n.tripNoStopsDetail,
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Space.lg,
              Space.lg,
              Space.lg,
              Space.sm,
            ),
            children: [
              TripMap(trip: trip),
              const SizedBox(height: Space.lg),
              _Summary(trip: trip),
              const SizedBox(height: Space.lg),
              Text(L10n.of(context).tripStopsTitle, style: YollaText.subtitle),
              const SizedBox(height: Space.sm),
              for (final stop in trip.places)
                Padding(
                  padding: const EdgeInsets.only(bottom: Space.sm),
                  child: _StopRow(
                    stop: stop,
                    showOrder: trip.hasRoute,
                    onRemove: () => onRemove(stop.place.id),
                  ),
                ),
            ],
          ),
        ),
        _ActionBar(trip: trip, isBusy: isBusy, onOptimize: onOptimize),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    if (!trip.hasRoute) {
      return Container(
        padding: const EdgeInsets.all(Space.lg),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(Radii.md),
        ),
        child: Row(
          children: [
            Icon(
              Icons.route_outlined,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: Space.md),
            Expanded(
              child: Text(
                l10n.tripRouteHint,
                style: YollaText.caption.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _Metric(
                icon: trip.travelMode == TravelMode.foot
                    ? Icons.directions_walk
                    : Icons.directions_car,
                label: l10n.tripMetricDistance,
                value: trip.distanceLabel ?? '—',
              ),
            ),
            Expanded(
              child: _Metric(
                icon: Icons.timer_outlined,
                label: l10n.tripMetricTravel,
                value: Format.duration(
                  context,
                  Duration(seconds: (trip.durationSeconds ?? 0).round()),
                ),
              ),
            ),
            Expanded(
              child: _Metric(
                icon: Icons.photo_camera_outlined,
                label: l10n.tripMetricVisit,
                value: Format.duration(
                  context,
                  Duration(minutes: trip.visitDurationMinutes ?? 0),
                ),
              ),
            ),
          ],
        ),
        if (trip.isTooLongOnFoot) ...[
          const SizedBox(height: Space.md),
          Container(
            padding: const EdgeInsets.all(Space.md),
            decoration: BoxDecoration(
              color: YollaColors.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: YollaColors.warning,
                ),
                const SizedBox(width: Space.sm),
                Expanded(
                  child: Text(
                    l10n.tripTooLongOnFoot,
                    style: YollaText.caption,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(height: Space.xs),
        Text(value, style: YollaText.subtitle),
        Text(
          label,
          style: YollaText.micro.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StopRow extends StatelessWidget {
  const _StopRow({
    required this.stop,
    required this.showOrder,
    required this.onRemove,
  });

  final TripPlace stop;
  final bool showOrder;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: () => context.push(Routes.placeFor(stop.place.id)),
        borderRadius: BorderRadius.circular(Radii.md),
        child: Padding(
          padding: const EdgeInsets.all(Space.sm),
          child: Row(
            children: [
              if (showOrder) ...[
                Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: YollaColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${stop.order}',
                    style: YollaText.micro.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: Space.sm),
              ],
              ClipRRect(
                borderRadius: BorderRadius.circular(Radii.sm),
                child: SizedBox(
                  width: 52,
                  height: 52,
                  child: PlacePhoto(
                    image: PlaceImage.fromCard(stop.place),
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
                      stop.place.name,
                      style: YollaText.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      stop.place.categoryName,
                      style: YollaText.caption.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                tooltip: L10n.of(context).tripRemoveStop,
                icon: Icon(
                  Icons.close_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.trip,
    required this.isBusy,
    required this.onOptimize,
  });

  final Trip trip;
  final bool isBusy;
  final VoidCallback onOptimize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        Space.lg,
        Space.md,
        Space.lg,
        Space.lg,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tek durakla "en kısa sıra" anlamsız ve sunucu da reddediyor;
          // düğme baştan kapalı ve altında sebebi yazıyor.
          if (trip.places.length < TripRules.minStops) ...[
            Text(
              l10n.tripNeedTwoStops,
              textAlign: TextAlign.center,
              style: YollaText.caption.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Space.sm),
          ],
          FilledButton.icon(
            onPressed: isBusy || trip.places.length < TripRules.minStops
                ? null
                : onOptimize,
            icon: isBusy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.route_rounded),
            label: Text(
              trip.hasRoute ? l10n.tripReoptimize : l10n.tripOptimize,
            ),
          ),
          // Rota hesaplanmadan navigasyona göndermek anlamsız: sıra belli
          // değilken duraklar rastgele bir düzende gider.
          if (trip.hasRoute) ...[
            const SizedBox(height: Space.sm),
            OutlinedButton.icon(
              onPressed: isBusy
                  ? null
                  : () => showNavigationSheet(context, trip),
              icon: const Icon(Icons.navigation_outlined),
              label: Text(l10n.navHandoffOpen),
            ),
          ],
        ],
      ),
    );
  }
}
