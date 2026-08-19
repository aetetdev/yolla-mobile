import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/place_detail.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

class PlaceService {
  const PlaceService(this._api);

  final ApiClient _api;

  Future<PlaceDetail> byId(int id) async {
    final envelope = await _api.get(
      '/places/$id',
      decode: (json) => PlaceDetail.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }
}

final placeServiceProvider = Provider<PlaceService>(
  (ref) => PlaceService(ref.watch(apiClientProvider)),
);

final placeDetailProvider = FutureProvider.family<PlaceDetail, int>((
  ref,
  id,
) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(placeServiceProvider).byId(id);
});
