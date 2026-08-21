import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../notifications/push_service.dart';
import 'rewards_service.dart';

/// Fotoğrafsız bir yer için "fotoğraf ekle" çağrısı.
///
/// Otomatik kaynaklar tükendi: feed'e girmeye layık binlerce yer fotoğrafsız
/// kaldı. Bu boşluğu kullanıcılar dolduruyor, karşılığında coin kazanıyorlar.
class ContributePhotoCard extends ConsumerWidget {
  const ContributePhotoCard({
    required this.placeId,
    required this.placeName,
    super.key,
  });

  final int placeId;
  final String placeName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final rules = ref.watch(rewardRulesProvider);
    final coins = rules.value?.coinsPerApprovedPhoto;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Space.lg),
      decoration: BoxDecoration(
        color: YollaColors.brand.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: YollaColors.brand.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.add_a_photo_outlined,
                color: YollaColors.brand,
                size: 20,
              ),
              const SizedBox(width: Space.sm),
              Expanded(
                child: Text(
                  l10n.contributePhotoTitle,
                  style: YollaText.subtitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.sm),
          Text(
            // Kuralları sunucu veriyor; gelmediyse sayı vaat etmiyoruz.
            coins == null
                ? l10n.contributePhotoDetail
                : l10n.contributePhotoDetailWithCoins(coins),
            style: YollaText.caption.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Space.lg),
          FilledButton.icon(
            onPressed: () => showContributePhotoSheet(
              context,
              placeId: placeId,
              placeName: placeName,
            ),
            icon: const Icon(Icons.add_a_photo_outlined, size: 18),
            label: Text(l10n.contributePhotoAction),
          ),
        ],
      ),
    );
  }
}

/// Kamera/galeri seçimi ve gönderim.
Future<void> showContributePhotoSheet(
  BuildContext context, {
  required int placeId,
  required String placeName,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) =>
        _ContributeSheet(placeId: placeId, placeName: placeName),
  );
}

class _ContributeSheet extends ConsumerStatefulWidget {
  const _ContributeSheet({required this.placeId, required this.placeName});

  final int placeId;
  final String placeName;

  @override
  ConsumerState<_ContributeSheet> createState() => _ContributeSheetState();
}

class _ContributeSheetState extends ConsumerState<_ContributeSheet> {
  bool _isBusy = false;
  String? _error;

  Future<void> _pick(ImageSource source) async {
    setState(() {
      _isBusy = true;
      _error = null;
    });

    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        // Sunucu zaten 1920'ye indiriyor; cihazda küçültmek yüklemeyi
        // hızlandırıyor ve kullanıcının verisini yiyor olmuyoruz.
        maxWidth: 2400,
        maxHeight: 2400,
        imageQuality: 90,
      );

      if (picked == null) {
        if (mounted) setState(() => _isBusy = false);
        return;
      }

      await ref
          .read(rewardsServiceProvider)
          .submitPhoto(placeId: widget.placeId, filePath: picked.path);

      // Bekleyen gönderi sayısı ve liste değişti.
      ref
        ..invalidate(rewardStatusProvider)
        ..invalidate(mySubmissionsProvider);

      // Bildirim izni tam burada isteniyor: kullanıcı az önce inceleme
      // bekleyen bir şey gönderdi, sonucun kendisine haber verilmesi işine
      // geliyor. Açılışta sorulsa reddedilirdi.
      unawaited(ref.read(pushServiceProvider).promptAfterSubmission());

      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context).contributePhotoSent)),
      );
    } on ApiException catch (error) {
      if (mounted) {
        setState(() {
          _error =
              error.fieldErrors.values.firstOrNull?.firstOrNull ??
              error.message;
        });
      }
    } on Object catch (error) {
      // Kamera/galeri izni reddi buraya düşüyor.
      if (mounted) setState(() => _error = '$error');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Space.xl, 0, Space.xl, Space.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.placeName, style: YollaText.title),
            const SizedBox(height: Space.xs),
            Text(
              l10n.contributePhotoRules,
              style: YollaText.caption.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Space.xl),
            if (_isBusy)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Space.xl),
                child: Center(child: CircularProgressIndicator()),
              )
            else ...[
              FilledButton.icon(
                onPressed: () => _pick(ImageSource.camera),
                icon: const Icon(Icons.photo_camera_outlined),
                label: Text(l10n.contributePhotoCamera),
              ),
              const SizedBox(height: Space.sm),
              OutlinedButton.icon(
                onPressed: () => _pick(ImageSource.gallery),
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(l10n.contributePhotoGallery),
              ),
            ],
            if (_error case final message?) ...[
              const SizedBox(height: Space.md),
              Text(
                message,
                style: YollaText.caption.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: Space.lg),
            Text(
              l10n.contributePhotoModeration,
              textAlign: TextAlign.center,
              style: YollaText.micro.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
