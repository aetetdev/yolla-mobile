import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/feed_page.dart';
import '../../core/models/geo_point.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'deck_page.dart';
import 'deck_source.dart';
import 'routes_service.dart';

/// Koridordaki şehirleri gösterip hangilerine uğranacağını sorar.
///
/// Kart akışından **önce** geliyor: kullanıcı İstanbul-Antalya yolunda
/// Afyon'a uğramak istemiyorsa o şehrin yerleri hiç kart olarak çıkmıyor.
/// Varsayılan olarak hepsi seçili — soru bir engel değil, bir daraltma aracı.
class CorridorCitiesPage extends ConsumerStatefulWidget {
  const CorridorCitiesPage({
    required this.start,
    required this.end,
    required this.startName,
    required this.endName,
    required this.bufferKm,
    super.key,
  });

  final GeoPoint start;
  final GeoPoint end;
  final String startName;
  final String endName;
  final int bufferKm;

  @override
  ConsumerState<CorridorCitiesPage> createState() => _CorridorCitiesPageState();
}

class _CorridorCitiesPageState extends ConsumerState<CorridorCitiesPage> {
  late Future<CorridorCities> _future;

  /// Seçili şehir kimlikleri. Liste geldiğinde hepsi işaretleniyor.
  final _selected = <int>{};

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  /// Seçim, veri `FutureBuilder`'a ulaşmadan **burada** hazırlanıyor; `build`
  /// içinde durum değiştirmek gerekmesin diye.
  Future<CorridorCities> _load() async {
    final data = await ref
        .read(routesServiceProvider)
        .corridorCities(
          start: widget.start,
          end: widget.end,
          bufferKm: widget.bufferKm,
        );

    _selected
      ..clear()
      ..addAll(data.cities.map((city) => city.cityId));

    return data;
  }

  void _retry() => setState(() => _future = _load());

  void _continue(List<CorridorCity> cities) {
    // Hepsi seçiliyse filtre göndermeye gerek yok; sunucu zaten tamamını
    // veriyor ve istek gövdesi gereksiz büyümüyor.
    final all = _selected.length == cities.length;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => DeckPage(
          source: CorridorDeckSource(
            start: widget.start,
            end: widget.end,
            startName: widget.startName,
            endName: widget.endName,
            bufferKm: widget.bufferKm,
            cityIds: all ? null : _selected.toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.corridorCitiesTitle)),
      body: SafeArea(
        child: FutureBuilder<CorridorCities>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: YollaLoader(label: l10n.commonLoading));
            }

            if (snapshot.error case final error?) {
              return YollaMessage(
                icon: Icons.cloud_off_rounded,
                title: error is ApiException
                    ? error.title
                    : l10n.commonLoadFailed,
                detail: error is ApiException ? error.message : '$error',
                actionLabel: l10n.commonRetry,
                onAction: _retry,
              );
            }

            final cities = snapshot.data?.cities ?? const <CorridorCity>[];

            if (cities.isEmpty) {
              return YollaMessage(
                icon: Icons.location_off_outlined,
                title: l10n.corridorCitiesEmptyTitle,
                detail: l10n.corridorCitiesEmptyDetail,
                actionLabel: l10n.commonBack,
                onAction: () => Navigator.of(context).pop(),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Space.xl,
                    Space.md,
                    Space.xl,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.corridorCitiesIntro,
                        style: YollaText.body.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: Space.sm),
                      Row(
                        children: [
                          TextButton(
                            onPressed: _selected.length == cities.length
                                ? null
                                : () => setState(
                                    () => _selected.addAll(
                                      cities.map((city) => city.cityId),
                                    ),
                                  ),
                            child: Text(l10n.corridorCitiesSelectAll),
                          ),
                          TextButton(
                            onPressed: _selected.isEmpty
                                ? null
                                : () => setState(_selected.clear),
                            child: Text(l10n.corridorCitiesClear),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: Space.lg),
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      final checked = _selected.contains(city.cityId);

                      return CheckboxListTile(
                        value: checked,
                        onChanged: (value) => setState(() {
                          if (value ?? false) {
                            _selected.add(city.cityId);
                          } else {
                            _selected.remove(city.cityId);
                          }
                        }),
                        title: Text(city.name, style: YollaText.subtitle),
                        subtitle: Text(
                          l10n.corridorCitiesPlaces(city.placeCount),
                          style: YollaText.caption.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        // Sıra numarası yolun neresinde olduğunu gösteriyor.
                        secondary: CircleAvatar(
                          radius: 14,
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          child: Text(
                            '${index + 1}',
                            style: YollaText.micro.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(Space.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.corridorCitiesSelected(_selected.length),
                        textAlign: TextAlign.center,
                        style: YollaText.caption.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: Space.sm),
                      FilledButton(
                        onPressed: _selected.isEmpty
                            ? null
                            : () => _continue(cities),
                        child: Text(l10n.corridorCitiesContinue),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
