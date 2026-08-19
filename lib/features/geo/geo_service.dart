import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/city.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Ülke ve şehir uçları.
class GeoService {
  const GeoService(this._api);

  final ApiClient _api;

  /// Şehir listesi.
  ///
  /// [onlyWithContent] varsayılan olarak açık: kart olarak gösterilebilecek
  /// yeri olmayan şehirler listeye hiç girmez. İçerik kapsaması dengesiz
  /// olduğu için (28 ilde 10'dan az kart) bu eleme kullanıcıyı boş desteden
  /// korur.
  Future<List<City>> cities({
    String country = 'TR',
    String? search,
    bool onlyWithContent = true,
  }) async {
    final envelope = await _api.get(
      '/geo/cities',
      query: {
        'country': country,
        'onlyWithContent': onlyWithContent,
        if (search != null && search.isNotEmpty) 'search': search,
      },
      decode: (json) => (json! as List)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }
}

final geoServiceProvider = Provider<GeoService>(
  (ref) => GeoService(ref.watch(apiClientProvider)),
);

/// İçeriği olan şehirler. Arama metni değiştikçe yeniden sorgulanır.
final citiesProvider = FutureProvider.family<List<City>, String>((
  ref,
  search,
) async {
  // Jeton olmadan da çalışır ama oturumu baştan kurmak sonraki çağrıları
  // beklemeden hazır hale getiriyor.
  await ref.watch(sessionProvider.future);
  return ref.watch(geoServiceProvider).cities(search: search);
});

/// Bütün şehirler.
///
/// Koridor modunda başlangıç ve varış içeriği olmayan bir şehir de olabilir —
/// kullanıcı Kırıkkale'den yola çıkabilir, orada gösterilecek kart olmasa da.
final allCitiesProvider = FutureProvider<List<City>>((ref) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(geoServiceProvider).cities(onlyWithContent: false);
});
