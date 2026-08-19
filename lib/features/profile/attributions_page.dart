import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/providers.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';

/// Kaynak ve lisans bilgileri.
///
/// Bu ekran süs değil: OSM verisi ODbL, Commons fotoğrafları çoğunlukla
/// CC BY-SA. Her ikisi de atıf zorunluluğu getiriyor. Kart üzerindeki
/// `photoAttribution` fotoğrafın yanında durur; buradaki liste ise veri
/// kümesinin tamamı için genel atıftır.
class AttributionsPage extends ConsumerWidget {
  const AttributionsPage({super.key});

  static List<_Source> _sourcesFor(L10n l10n) => [
    _Source(
      title: l10n.attributionOsmTitle,
      detail: l10n.attributionOsmDetail,
      url: 'https://www.openstreetmap.org/copyright',
    ),
    _Source(
      title: l10n.attributionCommonsTitle,
      detail: l10n.attributionCommonsDetail,
      url: 'https://commons.wikimedia.org/wiki/Commons:Licensing',
    ),
    _Source(
      title: l10n.attributionWikipediaTitle,
      detail: l10n.attributionWikipediaDetail,
      url: 'https://tr.wikipedia.org',
    ),
    _Source(
      title: l10n.attributionOsrmTitle,
      detail: l10n.attributionOsrmDetail,
      url: 'https://project-osrm.org',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final seen = ref.watch(attributionRegistryProvider).all;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.attributionsTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Space.xl),
          children: [
            Text(
              l10n.attributionsIntro,
              style: YollaText.body.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Space.xl),
            for (final source in _sourcesFor(l10n)) ...[
              _SourceTile(source: source),
              const SizedBox(height: Space.md),
            ],
            if (seen.isNotEmpty) ...[
              const SizedBox(height: Space.lg),
              Text(l10n.attributionsSeen, style: YollaText.subtitle),
              const SizedBox(height: Space.sm),
              for (final line in seen)
                Padding(
                  padding: const EdgeInsets.only(bottom: Space.xxs),
                  child: Text(
                    '· $line',
                    style: YollaText.caption.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Source {
  const _Source({
    required this.title,
    required this.detail,
    required this.url,
  });

  final String title;
  final String detail;
  final String url;
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({required this.source});

  final _Source source;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: () async {
          final uri = Uri.tryParse(source.url);
          if (uri != null) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        borderRadius: BorderRadius.circular(Radii.md),
        child: Padding(
          padding: const EdgeInsets.all(Space.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(source.title, style: YollaText.subtitle),
                  ),
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: Space.xs),
              Text(
                source.detail,
                style: YollaText.caption.copyWith(
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
