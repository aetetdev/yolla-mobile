import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/env.dart';
import '../../core/media/commons_photo.dart';
import '../../core/media/place_image.dart';
import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';

/// İstenen görsel boyutu.
enum PhotoSize {
  /// Liste satırı, küçük önizleme (sunucuda 500px).
  thumb,

  /// Kart destesi, detay başlığı (sunucuda 960px).
  large,
}

/// Yer fotoğrafı.
///
/// Fotoğraf gösterilen her yer bu bileşenden geçer; böylece boyut seçimi,
/// `User-Agent` başlığı ve hata durumu tek yerde tanımlı kalır.
///
/// Atfı olmayan görsel **çizilmez**, yerine yedek görünüm gelir — Commons
/// görsellerinin çoğu CC BY-SA ve atıfsız kullanılamaz.
class PlacePhoto extends StatelessWidget {
  const PlacePhoto({
    required this.image,
    this.size = PhotoSize.large,
    this.fit = BoxFit.cover,
    super.key,
  });

  final PlaceImage image;
  final PhotoSize size;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (!image.canDisplay) return _PhotoFallback(label: image.label);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        return CachedNetworkImage(
          imageUrl: _resolveUrl(context, width),
          // Commons'ın kullanım politikası tanımlayıcı bir kimlik istiyor.
          httpHeaders: const {'User-Agent': Env.imageUserAgent},
          fit: fit,
          fadeInDuration: Motion.fast,
          placeholder: (context, _) => const _PhotoPlaceholder(),
          errorWidget: (context, url, error) {
            // Hata yutulursa "fotoğraf neden gelmedi" sorusu cevapsız kalıyor.
            if (kDebugMode) {
              debugPrint('Fotoğraf yüklenemedi: $url\n  $error');
            }
            return _PhotoFallback(label: image.label);
          },
        );
      },
    );
  }

  /// Gösterilecek adres.
  ///
  /// Sunucu hazır küçültülmüş adresler veriyor; varsa onlar kullanılır. Yoksa
  /// adres istemcide türetilir — sözleşmenin bu alanları eklemesinden önceki
  /// davranış, eski sunucuya karşı da çalışsın diye duruyor.
  String _resolveUrl(BuildContext context, double logicalWidth) {
    final served = switch (size) {
      PhotoSize.thumb => image.thumbUrl,
      PhotoSize.large => image.largeUrl ?? image.thumbUrl,
    };
    if (served != null && served.isNotEmpty) return served;

    return CommonsPhoto.card(
      image.originalUrl!,
      logicalWidth: logicalWidth,
      devicePixelRatio: MediaQuery.devicePixelRatioOf(context),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: YollaColors.surfaceMutedDark,
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: YollaColors.surfaceMutedDark,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Space.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white24,
                size: 26,
              ),
              const SizedBox(height: Space.sm),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: YollaText.caption.copyWith(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
