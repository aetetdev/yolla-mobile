import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/place_suggestion.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import '../../shared/widgets/yolla_message.dart';
import 'place_suggestion_service.dart';
import 'rewards_service.dart';

/// Haritada seçilen noktaya yeni bir turistik yer önerme formu.
///
/// Konum ekranda değil haritada seçiliyor: kullanıcı koordinat yazmıyor,
/// gördüğü yere basıyor. Bu yüzden sayfa koordinatı hazır alıyor ve yalnızca
/// ad, kategori ve tanıtımı soruyor.
class SuggestPlacePage extends ConsumerStatefulWidget {
  const SuggestPlacePage({
    required this.latitude,
    required this.longitude,
    super.key,
  });

  final double latitude;
  final double longitude;

  @override
  ConsumerState<SuggestPlacePage> createState() => _SuggestPlacePageState();
}

class _SuggestPlacePageState extends ConsumerState<SuggestPlacePage> {
  final _name = TextEditingController();
  final _description = TextEditingController();

  String? _categoryKey;
  bool _isSending = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l10n = L10n.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      _isSending = true;
      _error = null;
    });

    try {
      await ref
          .read(placeSuggestionServiceProvider)
          .suggest(
            name: _name.text.trim(),
            categoryKey: _categoryKey!,
            latitude: widget.latitude,
            longitude: widget.longitude,
            description: _description.text.trim(),
          );

      // Liste ve coin durumu değişti; eski hallerini göstermesinler.
      ref
        ..invalidate(mySuggestionsProvider)
        ..invalidate(rewardStatusProvider);

      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(l10n.suggestSent)));
      context.pop();
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final categories = ref.watch(suggestionCategoriesProvider);

    // Ad ve kategori olmadan gönderilemez; tanıtım isteğe bağlı.
    final canSend =
        !_isSending &&
        _categoryKey != null &&
        _name.text.trim().length >= _minNameLength;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.suggestTitle)),
      body: switch (categories) {
        AsyncData(:final value) => _form(l10n, value, canSend),
        AsyncError(:final error) => YollaMessage(
          icon: Icons.wifi_off_rounded,
          title: error is ApiException ? error.title : l10n.commonLoadFailed,
          detail: error is ApiException ? error.message : '$error',
          actionLabel: l10n.commonRetry,
          onAction: () => ref.invalidate(suggestionCategoriesProvider),
        ),
        _ => const Center(child: YollaLoader()),
      },
    );
  }

  Widget _form(L10n l10n, List<SuggestionCategory> categories, bool canSend) {
    return ListView(
      padding: const EdgeInsets.all(Space.xl),
      children: [
        Text(l10n.suggestIntro, style: YollaText.body),
        const SizedBox(height: Space.md),

        // Konum burada yalnızca gösteriliyor: haritada seçildi, formda
        // değiştirilmiyor. Yanlışsa kullanıcı geri dönüp yeniden basıyor.
        Container(
          padding: const EdgeInsets.all(Space.md),
          decoration: BoxDecoration(
            color: YollaColors.accentSoft,
            borderRadius: BorderRadius.circular(Radii.md),
          ),
          child: Row(
            children: [
              const Icon(Icons.place_outlined, size: 18),
              const SizedBox(width: Space.sm),
              Expanded(
                child: Text(
                  l10n.suggestLocation(
                    widget.latitude.toStringAsFixed(5),
                    widget.longitude.toStringAsFixed(5),
                  ),
                  style: YollaText.caption,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Space.xl),

        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          maxLength: _maxNameLength,
          decoration: InputDecoration(
            labelText: l10n.suggestNameLabel,
            hintText: l10n.suggestNameHint,
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: Space.md),

        DropdownButtonFormField<String>(
          initialValue: _categoryKey,
          isExpanded: true,
          decoration: InputDecoration(labelText: l10n.suggestCategoryLabel),
          items: [
            for (final category in categories)
              DropdownMenuItem(
                value: category.key,
                child: Text(category.name, overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (value) => setState(() => _categoryKey = value),
        ),
        const SizedBox(height: Space.md),

        TextField(
          controller: _description,
          maxLines: 4,
          maxLength: _maxDescriptionLength,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.suggestDescriptionLabel,
            hintText: l10n.suggestDescriptionHint,
            alignLabelWithHint: true,
          ),
        ),

        if (_error case final error?) ...[
          const SizedBox(height: Space.sm),
          Text(
            error,
            style: YollaText.caption.copyWith(color: YollaColors.pass),
          ),
        ],

        const SizedBox(height: Space.lg),
        FilledButton.icon(
          onPressed: canSend ? _send : null,
          icon: _isSending
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.send_rounded),
          label: Text(l10n.suggestSend),
        ),
        const SizedBox(height: Space.sm),
        Text(
          l10n.suggestModerationNote,
          style: YollaText.micro.copyWith(color: YollaColors.inkFaint),
        ),
      ],
    );
  }

  /// Sunucudaki sınırların istemci karşılığı; kullanıcıyı hataya koşturmamak
  /// için. Sunucu kuralı yine kendisi uyguluyor.
  static const _minNameLength = 3;
  static const _maxNameLength = 250;
  static const _maxDescriptionLength = 1000;
}
