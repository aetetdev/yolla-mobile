import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/place_card.dart';
import '../../core/network/api_exception.dart';
import '../../core/trip_rules.dart';
import '../rewards/rewards_service.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../core/media/place_image.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/place_photo.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'trips_service.dart';

/// Beğenilen yerler ve buradan plan oluşturma.
///
/// Kaydırma ile plan arasındaki köprü: kullanıcı beğendiklerini burada görür,
/// istemediğini çıkarır ve kalanlarla bir gezi planı kurar.
class LikedPage extends ConsumerStatefulWidget {
  const LikedPage({this.cityId, super.key});

  /// Deste ekranından gelindiyse plan bu şehir için kurulur.
  final int? cityId;

  @override
  ConsumerState<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends ConsumerState<LikedPage> {
  /// Plana girecek yerler. Varsayılan olarak hepsi seçili.
  final _selected = <int>{};
  bool _primed = false;
  bool _isCreating = false;

  void _prime(List<PlaceCard> places) {
    if (_primed) return;
    _primed = true;
    _selected.addAll(places.map((p) => p.id));
  }

  Future<void> _createTrip(List<PlaceCard> places) async {
    final chosen = places.where((p) => _selected.contains(p.id)).toList();
    if (chosen.isEmpty) return;

    // Şehir içi plan bir şehre bağlı olmak zorunda. Deste ekranından
    // gelindiyse şehir bellidir; gelinmediyse seçilen yerlerin şehrinden
    // çıkarılır — kartlar `cityId` taşıyor.
    final cityId = widget.cityId ?? _cityOf(chosen);
    if (cityId == null) {
      _showError(L10n.of(context).likedNeedCity);
      return;
    }

    final name = await _askName(chosen.first.cityName);
    if (name == null || !mounted) return;

    setState(() => _isCreating = true);
    try {
      final trip = await ref
          .read(tripsServiceProvider)
          .createCityTrip(
            name: name,
            cityId: cityId,
            placeIds: chosen.map((p) => p.id).toList(),
          );
      ref
        ..invalidate(tripsProvider)
        // Aylık plan kotası değişti; premium ekranı eski sayıyı göstermesin.
        ..invalidate(rewardStatusProvider);
      if (!mounted) return;
      context.go(Routes.tripFor(trip.id));
    } on ApiException catch (error) {
      _showError(error.message);
    } finally {
      if (mounted) setState(() => _isCreating = false);
    }
  }

  /// Seçilen yerlerin şehri.
  ///
  /// Beğeniler birden çok şehirden olabilir (kullanıcı önce Nevşehir sonra
  /// İzmir gezmiş olabilir); en çok yeri olan şehir seçilir, çünkü plan tek
  /// bir şehre bağlanmak zorunda.
  int? _cityOf(List<PlaceCard> places) {
    final counts = <int, int>{};
    for (final place in places) {
      if (place.cityId case final id?) {
        counts[id] = (counts[id] ?? 0) + 1;
      }
    }
    if (counts.isEmpty) return null;

    return counts.entries
        .reduce((a, b) => b.value > a.value ? b : a)
        .key;
  }

  Future<String?> _askName(String? cityName) {
    final l10n = L10n.of(context);
    final controller = TextEditingController(
      text: cityName == null
          ? l10n.tripDefaultName
          : l10n.tripCityName(cityName),
    );

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.tripNameDialogTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(hintText: l10n.tripNameHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              Navigator.of(
                context,
              ).pop(value.isEmpty ? l10n.tripDefaultName : value);
            },
            child: Text(l10n.commonCreate),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final liked = ref.watch(likedPlacesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.likedTitle)),
      body: SafeArea(
        child: switch (liked) {
          AsyncData(:final value) when value.isEmpty => YollaMessage(
            icon: Icons.favorite_border_rounded,
            title: l10n.likedEmptyTitle,
            detail: l10n.likedEmptyDetail,
          ),
          AsyncData(:final value) => _Body(
            places: value,
            selected: _selected,
            isCreating: _isCreating,
            onPrime: _prime,
            onToggle: (id) => setState(() {
              _selected.contains(id)
                  ? _selected.remove(id)
                  : _selected.add(id);
            }),
            onCreate: () => _createTrip(value),
          ),
          AsyncError(:final error) => YollaMessage(
            icon: Icons.cloud_off_rounded,
            title: error is ApiException ? error.title : l10n.commonLoadFailed,
            detail: error is ApiException ? error.message : '$error',
            actionLabel: l10n.commonRetry,
            onAction: () => ref.invalidate(likedPlacesProvider),
          ),
          _ => const Center(child: YollaLoader()),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.places,
    required this.selected,
    required this.isCreating,
    required this.onPrime,
    required this.onToggle,
    required this.onCreate,
  });

  final List<PlaceCard> places;
  final Set<int> selected;
  final bool isCreating;
  final ValueChanged<List<PlaceCard>> onPrime;
  final ValueChanged<int> onToggle;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    onPrime(places);

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              Space.lg,
              Space.lg,
              Space.lg,
              Space.sm,
            ),
            itemCount: places.length,
            separatorBuilder: (_, _) => const SizedBox(height: Space.sm),
            itemBuilder: (context, index) {
              final place = places[index];
              return _LikedRow(
                place: place,
                isSelected: selected.contains(place.id),
                onTap: () => onToggle(place.id),
              );
            },
          ),
        ),
        _CreateBar(
          count: selected.length,
          isBusy: isCreating,
          onCreate: onCreate,
        ),
      ],
    );
  }
}

class _LikedRow extends StatelessWidget {
  const _LikedRow({
    required this.place,
    required this.isSelected,
    required this.onTap,
  });

  final PlaceCard place;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      selected: isSelected,
      button: true,
      label: L10n.of(context).likedRowSemantics(
        place.name,
        isSelected
            ? L10n.of(context).likedInPlan
            : L10n.of(context).likedNotInPlan,
      ),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Radii.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.md),
          child: Padding(
            padding: const EdgeInsets.all(Space.sm),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.sm),
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: PlacePhoto(
                      image: PlaceImage.fromCard(place),
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
                        style: YollaText.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Space.xxs),
                      Text(
                        [place.categoryName, place.locationLabel]
                            .where((e) => e.isNotEmpty)
                            .join(' · '),
                        style: YollaText.caption.copyWith(
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
                  isSelected
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? YollaColors.like
                      : theme.colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateBar extends StatelessWidget {
  const _CreateBar({
    required this.count,
    required this.isBusy,
    required this.onCreate,
  });

  final int count;
  final bool isBusy;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      // Tek durakla rota kurulamıyor: sunucu en az iki nokta istiyor ve tek
      // yer için "en kısa sıra" zaten anlamsız. Düğme baştan kapalı, sebebi
      // üstünde yazıyor — kullanıcı deneyip hata almasın.
      child: FilledButton(
        onPressed: count < TripRules.minStops || isBusy ? null : onCreate,
        child: isBusy
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                count < TripRules.minStops
                    ? L10n.of(context).likedSelectAtLeastTwo
                    : L10n.of(context).likedCreateWith(count),
              ),
      ),
    );
  }
}
