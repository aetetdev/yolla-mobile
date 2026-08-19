import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/models/city.dart';
import '../features/discovery/corridor_setup_page.dart';
import '../features/discovery/deck_page.dart';
import '../features/discovery/deck_source.dart';
import '../features/discovery/map_page.dart';
import '../features/discovery/mode_page.dart';
import '../features/geo/city_picker_page.dart';
import '../features/place/place_detail_page.dart';
import '../features/profile/attributions_page.dart';
import '../features/profile/auth_page.dart';
import '../features/profile/profile_page.dart';
import '../features/rewards/premium_page.dart';
import '../features/session/auth_state.dart';
import '../features/trips/liked_page.dart';
import '../features/trips/trip_detail_page.dart';
import '../features/trips/trips_page.dart';
import 'routes.dart';
import 'shell.dart';

final _rootKey = GlobalKey<NavigatorState>();

/// Uygulama yönlendiricisi.
///
/// Üç sekme `StatefulShellRoute` ile ayrı yığınlar olarak tutuluyor; sekme
/// değiştirince kullanıcının bulunduğu yer kayboluyor olmasın.
///
/// Yer detayı, beğenilenler ve atıflar sekmelerin **üstüne** açılıyor
/// (kök gezgin) — bunlar bir sekmeye ait değil.
///
/// Hesap zorunlu: [_redirect] oturumu olmayan herkesi [Routes.auth]'a
/// gönderiyor. Duvarı kaldırmak için o işlevi ve [SessionManager.requireAccount]
/// bayrağını değiştirmek yeterli; anonim akış olduğu gibi duruyor.
final routerProvider = Provider<GoRouter>((ref) {
  // Kimlik durumu değişince yönlendirmenin yeniden değerlendirilmesi gerekiyor;
  // `refreshListenable` bunun için. Riverpod durumunu dinleyen ince bir köprü.
  final authListenable = _AuthListenable(ref);
  ref.onDispose(authListenable.dispose);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.discover,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final status = ref.read(authControllerProvider);
      final atAuth = state.matchedLocation == Routes.auth;

      return switch (status) {
        // Saklanan oturum daha okunmadı: kimseyi oynatma, yoksa hesabı olan
        // kullanıcı bir an giriş ekranını görür.
        AuthStatus.unknown => null,
        AuthStatus.signedOut when !atAuth => Routes.auth,
        AuthStatus.signedIn when atAuth => Routes.discover,
        _ => null,
      };
    },
    routes: [
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.auth,
        builder: (context, state) => const AuthPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            YollaShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.discover,
                // Keşfetin kökü harita. Mod seçimi haritadaki "Gir" düğmesinin
                // arkasında duruyor — kullanıcı önce nereye gideceğini görüyor,
                // sonra nasıl planlayacağını seçiyor.
                builder: (context, state) => const MapPage(),
                routes: [
                  GoRoute(
                    path: 'mod',
                    builder: (context, state) => const ModePage(),
                  ),
                  GoRoute(
                    path: 'sehir',
                    builder: (context, state) => const CityPickerPage(),
                    routes: [
                      GoRoute(
                        path: ':cityId',
                        // Şehir nesnesi `extra` ile taşınıyor. Derin
                        // bağlantıyla gelinirse şehri kimlikten çözecek uç
                        // sözleşmede yok, o yüzden listeye dönülüyor.
                        redirect: (context, state) =>
                            state.extra is City ? null : Routes.cityPicker,
                        builder: (context, state) => DeckPage(
                          source: CityDeckSource(state.extra! as City),
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'rota',
                    builder: (context, state) => const CorridorSetupPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.trips,
                builder: (context, state) => const TripsPage(),
                routes: [
                  GoRoute(
                    path: ':tripId',
                    builder: (context, state) => TripDetailPage(
                      tripId: int.parse(state.pathParameters['tripId']!),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.liked,
        builder: (context, state) => LikedPage(
          cityId: int.tryParse(state.uri.queryParameters['sehir'] ?? ''),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.place,
        builder: (context, state) => PlaceDetailPage(
          placeId: int.parse(state.pathParameters['placeId']!),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.attributions,
        builder: (context, state) => const AttributionsPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.premium,
        builder: (context, state) => const PremiumPage(),
      ),
    ],
  );
});

/// Riverpod'daki kimlik durumunu `go_router`'ın anladığı [Listenable]'a çevirir.
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(Ref ref) {
    _subscription = ref.listen<AuthStatus>(
      authControllerProvider,
      (_, _) => notifyListeners(),
      // Açılışta durum zaten `unknown`; ilk gerçek değeri beklemek yeterli.
      fireImmediately: false,
    );
  }

  late final ProviderSubscription<AuthStatus> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
