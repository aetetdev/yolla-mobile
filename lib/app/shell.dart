import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/notifications/notification_service.dart';
import '../l10n/app_localizations.dart';

/// Alt sekmeli uygulama kabuğu.
///
/// Üç sekme ürünün üç sorusuna karşılık geliyor: nereyi gezeyim, ne planladım,
/// hesabım ne durumda. Her sekme kendi gezinme yığınını koruyor.
///
/// Okunmamış bildirim sayısı profil sekmesinde rozet olarak duruyor: bildirim
/// listesi o sekmenin altında ve fotoğraf/öneri sonuçları hesaba ait.
class YollaShell extends ConsumerStatefulWidget {
  const YollaShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<YollaShell> createState() => _YollaShellState();
}

class _YollaShellState extends ConsumerState<YollaShell> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();

    // Push devreye girene kadar rozetin tazelendiği tek an uygulamanın öne
    // gelmesi: moderasyon, kullanıcı uygulamayı kapatmışken de sonuç yazıyor.
    _lifecycle = AppLifecycleListener(
      onResume: () => ref.invalidate(unreadNotificationCountProvider),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final navigationShell = widget.navigationShell;

    // Sayı gelmeden rozet çizilmiyor; yükleme sırasında "0" göstermek
    // kullanıcıya bildirimi olmadığını söylemek olurdu.
    final unread = ref.watch(unreadNotificationCountProvider).value ?? 0;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Zaten açık sekmeye dokunmak o sekmenin köküne döndürür.
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.explore_outlined),
            selectedIcon: const Icon(Icons.explore),
            label: l10n.navDiscover,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined),
            selectedIcon: const Icon(Icons.map),
            label: l10n.navTrips,
          ),
          NavigationDestination(
            icon: _UnreadBadge(
              count: unread,
              child: const Icon(Icons.person_outline),
            ),
            selectedIcon: _UnreadBadge(
              count: unread,
              child: const Icon(Icons.person),
            ),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}

/// Okunmamış bildirim rozeti. Sayı sıfırsa simge olduğu gibi kalıyor.
class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count, required this.child});

  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) => Badge(
    isLabelVisible: count > 0,
    // Çift haneden sonra rozet sekmeyi eziyor; "9+" okunur kalıyor.
    label: Text(count > 9 ? '9+' : '$count'),
    child: child,
  );
}
