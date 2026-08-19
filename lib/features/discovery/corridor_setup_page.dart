import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/city.dart';
import '../../core/models/geo_point.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/turkish_text.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import '../geo/geo_service.dart';
import 'corridor_cities_page.dart';

/// Şehirlerarası mod: nereden nereye.
///
/// Başlangıç ve varış şehir listesinden seçiliyor; koridor sorgusu şehir
/// merkez koordinatlarıyla yapılıyor. Serbest nokta seçimi (haritadan) altlık
/// harita geldiğinde eklenebilir.
class CorridorSetupPage extends ConsumerStatefulWidget {
  const CorridorSetupPage({super.key});

  @override
  ConsumerState<CorridorSetupPage> createState() => _CorridorSetupPageState();
}

class _CorridorSetupPageState extends ConsumerState<CorridorSetupPage> {
  CorridorEndpoint? _from;
  CorridorEndpoint? _to;
  double _bufferKm = 15;
  bool _isLocating = false;

  /// Aynı şehir iki uçta da seçilemez. Konum ucu şehir kimliği taşımadığı için
  /// bu kontrole girmiyor — kullanıcı bulunduğu şehri varış olarak seçerse
  /// koridor yine de anlamlı (kısa da olsa bir yol var).
  bool get _isSameCity =>
      _from?.cityId != null && _from!.cityId == _to?.cityId;

  bool get _isReady => _from != null && _to != null && !_isSameCity;

  /// Kullanıcının bulunduğu noktayı başlangıç yapar.
  ///
  /// Yola çıkarken başlangıç neredeyse her zaman kullanıcının olduğu yer;
  /// şehir seçtirmek gereksiz bir adımdı.
  Future<void> _useMyLocation() async {
    final l10n = L10n.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _isLocating = true);
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.corridorLocationDenied)),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 15),
        ),
      );

      if (!mounted) return;
      setState(() {
        _from = CorridorEndpoint.myLocation(
          GeoPoint(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
          label: l10n.corridorMyLocation,
        );
      });
    } on Object {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.corridorLocationFailed)),
      );
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _pick({required bool isStart}) async {
    // Koridor için şehrin koordinatı şart; içeriği olmayan şehirler de
    // başlangıç/varış olabilir, o yüzden eleme yapılmıyor.
    final cities = await ref.read(allCitiesProvider.future);
    if (!mounted) return;

    final chosen = await showModalBottomSheet<City>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => _CityPickerSheet(
        title: isStart
            ? L10n.of(context).corridorFrom
            : L10n.of(context).corridorTo,
        cities: cities,
      ),
    );

    if (chosen == null || chosen.latitude == null || chosen.longitude == null) {
      return;
    }

    final endpoint = CorridorEndpoint.city(chosen);
    setState(() {
      if (isStart) {
        _from = endpoint;
      } else {
        _to = endpoint;
      }
    });
  }

  /// Kart akışına **doğrudan** gitmiyor: önce koridordaki şehirler sorulup
  /// kullanıcıya uğramak istemediklerini eleme şansı veriliyor.
  void _start() {
    final from = _from!;
    final to = _to!;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CorridorCitiesPage(
          start: from.point,
          end: to.point,
          startName: from.label,
          endName: to.label,
          bufferKm: _bufferKm.round(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final cities = ref.watch(allCitiesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.corridorTitle)),
      body: SafeArea(
        child: switch (cities) {
          AsyncError(:final error) => YollaMessage(
            icon: Icons.cloud_off_rounded,
            title: error is ApiException ? error.title : l10n.commonLoadFailed,
            detail: error is ApiException ? error.message : '$error',
            actionLabel: l10n.commonRetry,
            onAction: () => ref.invalidate(allCitiesProvider),
          ),
          AsyncData() => Padding(
            padding: const EdgeInsets.all(Space.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.corridorIntro,
                  style: YollaText.body.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Space.xl),
                _PointField(
                  label: l10n.corridorFrom,
                  endpoint: _from,
                  icon: Icons.trip_origin,
                  onTap: () => _pick(isStart: true),
                ),
                const SizedBox(height: Space.xs),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _isLocating ? null : _useMyLocation,
                    icon: _isLocating
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.my_location, size: 18),
                    label: Text(l10n.corridorUseMyLocation),
                  ),
                ),
                const SizedBox(height: Space.sm),
                _PointField(
                  label: l10n.corridorTo,
                  endpoint: _to,
                  icon: Icons.place,
                  onTap: () => _pick(isStart: false),
                ),
                if (_isSameCity) ...[
                  const SizedBox(height: Space.md),
                  Text(
                    l10n.corridorSameCity,
                    style: YollaText.caption.copyWith(
                      color: YollaColors.danger,
                    ),
                  ),
                ],
                const SizedBox(height: Space.xxl),
                Text(l10n.corridorBufferTitle, style: YollaText.subtitle),
                Text(
                  l10n.corridorBufferDetail(_bufferKm.round()),
                  style: YollaText.caption.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Slider(
                  value: _bufferKm,
                  min: 5,
                  max: 50,
                  divisions: 9,
                  label: '${_bufferKm.round()} km',
                  onChanged: (value) => setState(() => _bufferKm = value),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _isReady ? _start : null,
                  child: Text(l10n.corridorStart),
                ),
              ],
            ),
          ),
          _ => const Center(child: YollaLoader()),
        },
      ),
    );
  }
}

class _PointField extends StatelessWidget {
  const _PointField({
    required this.label,
    required this.endpoint,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final CorridorEndpoint? endpoint;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Container(
          padding: const EdgeInsets.all(Space.lg),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(Radii.md),
          ),
          child: Row(
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
                    Text(
                      endpoint?.label ?? L10n.of(context).corridorPickCity,
                      style: YollaText.subtitle.copyWith(
                        color: endpoint == null
                            ? theme.colorScheme.onSurfaceVariant
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.expand_more,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CityPickerSheet extends StatefulWidget {
  const _CityPickerSheet({required this.title, required this.cities});

  final String title;
  final List<City> cities;

  @override
  State<_CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<_CityPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final matches = widget.cities
        .where((city) => TurkishText.contains(city.name, _query))
        .toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      builder: (context, controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Space.xl,
              0,
              Space.xl,
              Space.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: YollaText.subtitle),
                const SizedBox(height: Space.md),
                TextField(
                  autofocus: true,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: L10n.of(context).citySearchHint,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final city = matches[index];
                return ListTile(
                  title: Text(city.name),
                  subtitle: Text(
                    city.readyPlaceCount == 0
                        ? L10n.of(context).cityNoContent
                        : L10n.of(context).cityPlaceCount(city.readyPlaceCount),
                  ),
                  onTap: () => Navigator.of(context).pop(city),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Koridorun bir ucu: seçilen şehir ya da kullanıcının bulunduğu nokta.
///
/// Sunucu koridoru ham koordinatla kuruyor, şehir kimliğiyle değil; bu yüzden
/// "başlangıç mutlaka bir şehir olmalı" kısıtı yalnızca arayüzdeydi.
@immutable
class CorridorEndpoint {
  const CorridorEndpoint._({
    required this.point,
    required this.label,
    this.cityId,
  });

  /// Listeden seçilen şehir. Koordinatı olmayan şehir uç olamaz.
  factory CorridorEndpoint.city(City city) => CorridorEndpoint._(
    point: GeoPoint(latitude: city.latitude!, longitude: city.longitude!),
    label: city.name,
    cityId: city.id,
  );

  /// Kullanıcının konumu. Şehre bağlı değil, o yüzden [cityId] yok.
  factory CorridorEndpoint.myLocation(GeoPoint point, {required String label}) =>
      CorridorEndpoint._(point: point, label: label);

  final GeoPoint point;
  final String label;
  final int? cityId;
}
