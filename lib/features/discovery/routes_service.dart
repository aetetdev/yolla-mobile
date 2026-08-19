import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/feed_page.dart';
import '../../core/models/geo_point.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Rota uçları: yol koridoru keşfi ve sıralama.
class RoutesService {
  const RoutesService(this._api);

  final ApiClient _api;

  /// İki nokta arasındaki yol koridorunda kalan yerleri getirir.
  ///
  /// Kartlar `routeProgress` sırasına göre gelir: kullanıcı önce yolun
  /// başındaki yerleri görür, İstanbul'dan çıkarken Antalya'nın kartı gelmez.
  /// [bufferKm] ve [excludeEndpointsKm] **tam sayı** olmalı: sunucu bu alanları
  /// `int` olarak çözümlüyor ve ondalıklı değer gönderilirse 400 döndürüyor.
  Future<CorridorResult> corridor({
    required GeoPoint start,
    required GeoPoint end,
    int bufferKm = 15,
    int excludeEndpointsKm = 20,
    int take = 20,
    String? cursor,
    List<int>? cityIds,
  }) async {
    final envelope = await _api.post(
      '/routes/corridor',
      body: {
        'start': {
          'latitude': start.latitude,
          'longitude': start.longitude,
        },
        'end': {'latitude': end.latitude, 'longitude': end.longitude},
        'bufferKm': bufferKm,
        'excludeEndpointsKm': excludeEndpointsKm,
        'take': take,
        'cursor': ?cursor,
        // Boş liste göndermek "hiçbir şehir" demek olurdu; seçim yoksa alan
        // hiç gitmiyor ve sunucu bütün koridoru veriyor.
        if (cityIds != null && cityIds.isNotEmpty) 'cityIds': cityIds,
      },
      decode: (json) => CorridorResult.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Koridorun geçtiği şehirleri, yol boyunca sırasıyla getirir.
  ///
  /// Eleme koşulları [corridor] ile aynı olduğu için buradaki `placeCount`,
  /// o şehir seçilip kart akışına geçildiğinde çıkan sayıyla tutuyor.
  Future<CorridorCities> corridorCities({
    required GeoPoint start,
    required GeoPoint end,
    int bufferKm = 15,
    int excludeEndpointsKm = 20,
  }) async {
    final envelope = await _api.post(
      '/routes/corridor/cities',
      body: {
        'start': {
          'latitude': start.latitude,
          'longitude': start.longitude,
        },
        'end': {'latitude': end.latitude, 'longitude': end.longitude},
        'bufferKm': bufferKm,
        'excludeEndpointsKm': excludeEndpointsKm,
      },
      decode: (json) => CorridorCities.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }
}

final routesServiceProvider = Provider<RoutesService>(
  (ref) => RoutesService(ref.watch(apiClientProvider)),
);
