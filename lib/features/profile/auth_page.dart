import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/yolla_loader.dart';
import 'auth_form.dart';

/// Karşılama ekranı: giriş ve kayıt.
///
/// Hesap **zorunlu** — uygulamanın geri kalanına bu ekrandan geçiliyor.
/// Yönlendirici, oturumu olmayan herkesi buraya gönderiyor.
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: Space.xl,
              vertical: Space.xxl,
            ),
            child: ConstrainedBox(
              // Tablette ve yatay çevrildiğinde form ekranın tamamına
              // yayılmasın; okunur genişlikte kalsın.
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Marka işareti olarak yükleyicinin durağan hali kullanılıyor:
                  // aynı kart destesi, aynı rota. Ayrı bir varlık dosyası
                  // gerekmiyor ve ikon setiyle birebir aynı dili konuşuyor.
                  const Center(child: YollaLoader(size: 132)),
                  const SizedBox(height: Space.xl),
                  Text(
                    l10n.appName,
                    textAlign: TextAlign.center,
                    style: YollaText.display.copyWith(
                      color: YollaColors.brand,
                    ),
                  ),
                  const SizedBox(height: Space.xs),
                  Text(
                    l10n.authWallSubtitle,
                    textAlign: TextAlign.center,
                    style: YollaText.body.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: Space.xxl),
                  const AuthForm(),
                  const SizedBox(height: Space.lg),
                  Text(
                    l10n.authWallFootnote,
                    textAlign: TextAlign.center,
                    style: YollaText.micro.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
