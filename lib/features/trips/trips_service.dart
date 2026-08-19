import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/enums.dart';
import '../../core/models/geo_point.dart';
import '../../core/models/place_card.dart';
import '../../core/models/trip.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Gezi planı uçları. Hepsi jeton gerektirir; her cihaz yalnızca kendi
/// planlarını görür.
class TripsService {
  const TripsService(this._api);

  final ApiClient _api;

  /// Plan listesi.
  ///
  /// Liste ucu detaydan farklı, daha hafif bir gövde döndürür — bu yüzden
  /// [TripSummary].
  Future<List<TripSummary>> list() async {
    final envelope = await _api.get(
      '/trips',
      decode: (json) => (json! as List)
          .map((e) => TripSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }

  Future<Trip> get(int id) async {
    final envelope = await _api.get(
      '/trips/$id',
      decode: (json) => Trip.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Şehir içi plan oluşturur.
  Future<Trip> createCityTrip({
    required String name,
    required int cityId,
    required List<int> placeIds,
    TravelMode travelMode = TravelMode.foot,
  }) => _create({
    'name': name,
    'mode': TripMode.city.wireValue,
    'travelMode': travelMode.wireValue,
    'cityId': cityId,
    'placeIds': placeIds,
  });

  /// Şehirlerarası plan oluşturur.
  ///
  /// [start] ve [end] koridor akışından geliyor: kullanıcı "şuradan şuraya"
  /// dediği için uçlar sabit, yerler yolun üstünden seçiliyor. Haritadan
  /// birden çok şehirden yer toplandığında uç yok — elde yalnızca duraklar
  /// var ve sıralarını sunucu belirliyor. Sunucu iki gelişi de kabul ediyor.
  Future<Trip> createRouteTrip({
    required String name,
    required List<int> placeIds,
    GeoPoint? start,
    GeoPoint? end,
    TravelMode travelMode = TravelMode.car,
  }) => _create({
    'name': name,
    'mode': TripMode.route.wireValue,
    'travelMode': travelMode.wireValue,
    if (start != null)
      'startPoint': {'latitude': start.latitude, 'longitude': start.longitude},
    if (end != null)
      'endPoint': {'latitude': end.latitude, 'longitude': end.longitude},
    'placeIds': placeIds,
  });

  Future<Trip> _create(Map<String, Object?> body) async {
    final envelope = await _api.post(
      '/trips',
      body: body,
      decode: (json) => Trip.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  Future<Trip> rename(int id, String name) async {
    final envelope = await _api.patch(
      '/trips/$id',
      body: {'name': name},
      decode: (json) => Trip.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  Future<void> delete(int id) =>
      _api.delete<void>('/trips/$id', decode: (_) {});

  /// Durak ekler ve/veya çıkarır.
  ///
  /// Duraklar değişince sunucu hesaplanmış rotayı temizler; dönen planda
  /// `routeGeometry` null olur ve yeniden [optimize] çağrılması gerekir.
  Future<Trip> updatePlaces(
    int id, {
    List<int> add = const [],
    List<int> remove = const [],
  }) async {
    final envelope = await _api.post(
      '/trips/$id/places',
      body: {
        if (add.isNotEmpty) 'add': add,
        if (remove.isNotEmpty) 'remove': remove,
      },
      decode: (json) => Trip.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Rotayı hesaplar (gezgin satıcı) ve plana kaydeder.
  Future<Trip> optimize(int id) async {
    final envelope = await _api.post(
      '/trips/$id/optimize',
      decode: (json) => Trip.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Beğenilen yerler — plan kurmanın başlangıç noktası.
  Future<List<PlaceCard>> liked() async {
    final envelope = await _api.get(
      '/discovery/swipes/liked',
      decode: (json) => (json! as List)
          .map((e) => PlaceCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }
}

final tripsServiceProvider = Provider<TripsService>(
  (ref) => TripsService(ref.watch(apiClientProvider)),
);

/// Kullanıcının planları.
final tripsProvider = FutureProvider<List<TripSummary>>((ref) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(tripsServiceProvider).list();
});

/// Tek bir planın güncel hali.
final tripProvider = FutureProvider.family<Trip, int>((ref, id) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(tripsServiceProvider).get(id);
});

/// Beğenilen yerler.
final likedPlacesProvider = FutureProvider<List<PlaceCard>>((ref) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(tripsServiceProvider).liked();
});
