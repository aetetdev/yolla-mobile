import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/place_suggestion.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Kullanıcıların önerdiği yerlerin uçları.
///
/// Hepsi hesap gerektiriyor: öneri kişiye bağlı, onayı da coin kazandırıyor.
class PlaceSuggestionService {
  const PlaceSuggestionService(this._api);

  final ApiClient _api;

  /// Öneri kurulurken seçilebilecek kategoriler.
  Future<List<SuggestionCategory>> categories() async {
    final envelope = await _api.get(
      '/places/oneriler/kategoriler',
      decode: (json) => (json! as List)
          .map((e) => SuggestionCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }

  /// Yeni bir yer önerir. Öneri doğrudan kataloğa girmiyor, moderasyona düşüyor.
  Future<PlaceSuggestion> suggest({
    required String name,
    required String categoryKey,
    required double latitude,
    required double longitude,
    String? description,
    String? address,
  }) async {
    final envelope = await _api.post(
      '/places/oneriler',
      body: {
        'name': name,
        'categoryKey': categoryKey,
        'latitude': latitude,
        'longitude': longitude,
        if (description != null && description.isNotEmpty)
          'description': description,
        if (address != null && address.isNotEmpty) 'address': address,
      },
      decode: (json) => PlaceSuggestion.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Kullanıcının kendi önerileri, yeniden eskiye.
  Future<List<PlaceSuggestion>> mine() async {
    final envelope = await _api.get(
      '/places/oneriler/benim',
      decode: (json) => (json! as List)
          .map((e) => PlaceSuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }
}

final placeSuggestionServiceProvider = Provider<PlaceSuggestionService>(
  (ref) => PlaceSuggestionService(ref.watch(apiClientProvider)),
);

/// Kategoriler oturum boyunca değişmiyor; bir kez çekilmesi yeterli.
final suggestionCategoriesProvider = FutureProvider<List<SuggestionCategory>>((
  ref,
) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(placeSuggestionServiceProvider).categories();
});

/// Kullanıcının önerileri. Yeni öneri gönderilince geçersiz kılınıyor.
final mySuggestionsProvider = FutureProvider<List<PlaceSuggestion>>((ref) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(placeSuggestionServiceProvider).mine();
});
