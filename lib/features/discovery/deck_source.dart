import '../../core/models/city.dart';
import '../../core/models/enums.dart';
import '../../core/models/feed_page.dart';
import '../../core/models/geo_point.dart';
import 'discovery_service.dart';
import 'routes_service.dart';

/// Destenin kartları nereden geliyor?
///
/// İki mod aynı deste arayüzünü kullanıyor ama farklı uçlardan besleniyor.
/// Bu ayrım sayesinde kaydırma, sayfalama ve geri alma mantığı tek yerde
/// kalıyor.
sealed class DeckSource {
  const DeckSource();

  /// Başlıkta gösterilecek metin.
  String get title;

  /// Kaydırma kaydına yazılacak bağlam — öneri motoru şehir içi ile yol
  /// üstünü ayrı değerlendiriyor.
  SwipeContext get swipeContext;

  Future<FeedPage> load({
    required DiscoveryService discovery,
    required RoutesService routes,
    String? cursor,
    int take,
  });
}

/// Şehir içi deste.
class CityDeckSource extends DeckSource {
  const CityDeckSource(this.city);

  final City city;

  @override
  String get title => city.name;

  @override
  SwipeContext get swipeContext => SwipeContext.city;

  @override
  Future<FeedPage> load({
    required DiscoveryService discovery,
    required RoutesService routes,
    String? cursor,
    int take = 20,
  }) => discovery.cityFeed(cityId: city.id, cursor: cursor, take: take);
}

/// Şehirlerarası yol koridoru destesi.
///
/// İlk yüklemede hesaplanan rota bilgisi ([routeGeometry], [distanceMeters])
/// burada tutulur; plan oluşturulurken kullanılır.
class CorridorDeckSource extends DeckSource {
  CorridorDeckSource({
    required this.start,
    required this.end,
    required this.startName,
    required this.endName,
    this.bufferKm = 15,
    this.cityIds,
  }) : assert(bufferKm > 0, 'sapma payı sıfırdan büyük olmalı');

  final GeoPoint start;
  final GeoPoint end;
  final String startName;
  final String endName;

  /// Sunucu tam sayı bekliyor.
  final int bufferKm;

  /// Kullanıcının uğramak istediği şehirler. Boş ya da null ise koridordaki
  /// bütün şehirler dahil.
  final List<int>? cityIds;

  String? routeGeometry;
  double? distanceMeters;
  double? durationSeconds;

  @override
  String get title => '$startName → $endName';

  @override
  SwipeContext get swipeContext => SwipeContext.route;

  @override
  Future<FeedPage> load({
    required DiscoveryService discovery,
    required RoutesService routes,
    String? cursor,
    int take = 20,
  }) async {
    final result = await routes.corridor(
      start: start,
      end: end,
      bufferKm: bufferKm,
      take: take,
      cursor: cursor,
      cityIds: cityIds,
    );

    routeGeometry = result.routeGeometry;
    distanceMeters = result.routeDistanceMeters;
    durationSeconds = result.routeDurationSeconds;

    return result.cards;
  }
}
