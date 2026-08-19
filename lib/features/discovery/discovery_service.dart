import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/feed_page.dart';
import '../../core/models/swipe.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Kart destesi ve kaydırma uçları.
class DiscoveryService {
  const DiscoveryService(this._api);

  final ApiClient _api;

  /// Tek istekte gönderilebilecek en fazla kaydırma sayısı (sözleşme sınırı).
  static const maxSwipesPerRequest = 200;

  /// Şehir içi deste.
  ///
  /// [cursor] verilmezse ilk sayfa gelir. Jeton gönderildiğinde daha önce
  /// kaydırılmış yerler sunucu tarafında elenir.
  Future<FeedPage> cityFeed({
    required int cityId,
    String? cursor,
    int take = 20,
    List<String> categories = const [],
  }) async {
    final envelope = await _api.get(
      '/discovery/city/$cityId/feed',
      query: {
        'take': take,
        'cursor': ?cursor,
        if (categories.isNotEmpty) 'categories': categories.join(','),
      },
      decode: (json) => FeedPage.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Kaydırmaları toplu gönderir.
  Future<SwipeResult> recordSwipes(List<SwipeRecord> swipes) async {
    assert(
      swipes.length <= maxSwipesPerRequest,
      'Tek istekte en fazla $maxSwipesPerRequest kaydırma gönderilebilir',
    );

    final envelope = await _api.post(
      '/discovery/swipes',
      body: {
        'swipes': [
          for (final swipe in swipes)
            {
              'placeId': swipe.placeId,
              'direction': swipe.direction.wireValue,
              'context': swipe.context.wireValue,
            },
        ],
      },
      decode: (json) => SwipeResult.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Bir yerin kaydırma kaydını siler; yer destede yeniden görünebilir.
  ///
  /// Kayıt yoksa sunucu hata vermez, `removed: false` döner — istemci
  /// kaydırmaları toplu gönderdiği için bu uç henüz gönderilmemiş bir
  /// kaydırma için de çağrılabiliyor.
  Future<SwipeUndoResult> undoSwipe(int placeId) async {
    final envelope = await _api.delete(
      '/discovery/swipes/$placeId',
      decode: (json) =>
          SwipeUndoResult.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }
}

final discoveryServiceProvider = Provider<DiscoveryService>(
  (ref) => DiscoveryService(ref.watch(apiClientProvider)),
);
