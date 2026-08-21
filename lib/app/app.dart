import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/yolla_theme.dart';
import '../features/notifications/notification_service.dart';
import '../features/notifications/push_service.dart';
import '../l10n/app_localizations.dart';
import '../features/splash/splash_screen.dart';
import 'router.dart';
import 'routes.dart';

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

  /// Bildirim dinleyicilerini söken işlev.
  VoidCallback? _detachPush;

  @override
  void initState() {
    super.initState();
    unawaited(_wirePush());
  }

  @override
  void dispose() {
    _detachPush?.call();
    super.dispose();
  }

  /// Bildirim iletimini bağlar.
  Future<void> _wirePush() async {
    final push = ref.read(pushServiceProvider);

    _detachPush = push.attach(
      onOpened: _openNotification,
      // Uygulama öndeyken Android sistem bildirimini göstermiyor; rozet ile
      // liste tazelenmezse kullanıcı gelen bildirimi hiç fark etmiyor.
      onReceived: () => ref
        ..invalidate(unreadNotificationCountProvider)
        ..invalidate(notificationsProvider),
    );

    // Jeton yazımı oturumun kurulmasını bekliyor.
    await ref.read(pushRegistrationProvider.future);
  }

  /// Bildirime dokunulunca: yer varsa oraya, yoksa listeye.
  void _openNotification(int? placeId) {
    if (!mounted) return;

    ref.invalidate(unreadNotificationCountProvider);
    ref
        .read(routerProvider)
        .push(placeId == null ? Routes.notifications : Routes.placeFor(placeId));
  }

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
