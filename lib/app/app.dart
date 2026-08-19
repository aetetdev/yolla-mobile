import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/yolla_theme.dart';
import '../l10n/app_localizations.dart';
import '../features/splash/splash_screen.dart';
import 'router.dart';

class YollaApp extends ConsumerStatefulWidget {
  const YollaApp({super.key});

  @override
  ConsumerState<YollaApp> createState() => _YollaAppState();
}

class _YollaAppState extends ConsumerState<YollaApp> {
  /// Açılış animasyonu bitti mi?
  ///
  /// Uygulamanın **üstünde** duruyor, yerine geçmiyor: altta yönlendirici ve
  /// oturum okuması çalışmaya devam ediyor, animasyon bittiğinde kullanıcı
  /// gideceği ekrana hazır olarak varıyor.
  bool _splashDone = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => L10n.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: YollaTheme.light,
      darkTheme: YollaTheme.dark,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      // Desteklenmeyen bir dilde açılırsa Türkçeye düşer — veri kapsaması
      // Türkiye ile başlıyor, kullanıcıların çoğu Türkçe.
      localeResolutionCallback: (locale, supported) {
        final match = supported.firstWhere(
          (candidate) => candidate.languageCode == locale?.languageCode,
          orElse: () => const Locale('tr'),
        );
        return match;
      },
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => Stack(
        children: [
          ?child,
          if (!_splashDone)
            SplashScreen(
              onFinished: () {
                if (mounted) setState(() => _splashDone = true);
              },
            ),
        ],
      ),
    );
  }
}
