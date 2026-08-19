import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/city.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'geo_service.dart';

/// Şehir seçimi.
///
/// Yalnızca içeriği olan şehirler listelenir (`onlyWithContent`). İçerik
/// kapsaması dengesiz olduğu için bu eleme olmadan kullanıcı boş desteyle
/// karşılaşırdı.
class CityPickerPage extends ConsumerStatefulWidget {
  const CityPickerPage({super.key});

  @override
  ConsumerState<CityPickerPage> createState() => _CityPickerPageState();
}

class _CityPickerPageState extends ConsumerState<CityPickerPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _search = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    // Her harfte istek atmak hız sınırını yer; yazma durunca sorgulanır.
    _debounce = Timer(const Duration(milliseconds: 320), () {
      if (mounted) setState(() => _search = value.trim());
    });
  }

  void _open(City city) => context.push(Routes.deckFor(city.id), extra: city);

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final cities = ref.watch(citiesProvider(_search));

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Space.xl,
                Space.xl,
                Space.xl,
                Space.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.cityPickerTitle, style: YollaText.display),
                  const SizedBox(height: Space.xs),
                  Text(
                    l10n.cityPickerSubtitle,
                    style: YollaText.body.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: Space.lg),
                  TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: l10n.citySearchHint,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: switch (cities) {
                AsyncData(:final value) when value.isEmpty => YollaMessage(
                  icon: Icons.travel_explore_outlined,
                  title: l10n.cityNotFoundTitle,
                  detail: _search.isEmpty
                      ? l10n.cityNotFoundEmpty
                      : l10n.cityNotFoundQuery(_search),
                ),
                AsyncData(:final value) => _CityList(
                  cities: value,
                  onTap: _open,
                ),
                AsyncError(:final error) => YollaMessage(
                  icon: Icons.cloud_off_rounded,
                  title: error is ApiException
                      ? error.title
                      : l10n.citiesLoadFailed,
                  detail: error is ApiException ? error.message : '$error',
                  actionLabel: l10n.commonRetry,
                  onAction: () => ref.invalidate(citiesProvider(_search)),
                ),
                _ => const Center(child: YollaLoader()),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CityList extends StatelessWidget {
  const _CityList({required this.cities, required this.onTap});

  final List<City> cities;
  final ValueChanged<City> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(Space.xl, 0, Space.xl, Space.xxl),
      itemCount: cities.length,
      separatorBuilder: (_, _) => const SizedBox(height: Space.sm),
      itemBuilder: (context, index) {
        final city = cities[index];

        return Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(Radii.md),
          child: InkWell(
            onTap: () => onTap(city),
            borderRadius: BorderRadius.circular(Radii.md),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Space.lg,
                vertical: Space.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(city.name, style: YollaText.subtitle),
                        const SizedBox(height: Space.xxs),
                        Text(
                          city.readyPlaceCount == 0
                              ? L10n.of(context).cityNoContent
                              : L10n.of(
                                  context,
                                ).cityPlaceCount(city.readyPlaceCount),
                          style: YollaText.caption.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
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
        );
      },
    );
  }
}
