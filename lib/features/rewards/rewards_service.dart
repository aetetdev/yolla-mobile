import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/reward.dart';
import '../../core/network/api_client.dart';
import '../../core/providers.dart';

/// Fotoğraf katkısı, coin ve premium uçları.
class RewardsService {
  const RewardsService(this._api);

  final ApiClient _api;

  Future<RewardRules> rules() async {
    final envelope = await _api.get(
      '/rewards/kurallar',
      decode: (json) => RewardRules.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  Future<RewardStatus> status() async {
    final envelope = await _api.get(
      '/rewards/durum',
      decode: (json) => RewardStatus.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  Future<List<CoinEntry>> coinHistory({int take = 50}) async {
    final envelope = await _api.get(
      '/rewards/coin-gecmisi',
      query: {'take': take},
      decode: (json) => (json! as List)
          .map((e) => CoinEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }

  Future<List<PhotoSubmission>> mySubmissions() async {
    final envelope = await _api.get(
      '/rewards/fotograflarim',
      decode: (json) => (json! as List)
          .map((e) => PhotoSubmission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return envelope.data;
  }

  /// Bir yer için fotoğraf gönderir.
  ///
  /// `multipart/form-data`: dosya sunucuda JPEG'e çevriliyor, küçültülüyor ve
  /// EXIF'i (konum dahil) siliniyor. Gönderi doğrudan yayına girmiyor,
  /// moderasyona düşüyor.
  Future<PhotoSubmission> submitPhoto({
    required int placeId,
    required String filePath,
  }) async {
    final form = FormData.fromMap({
      'placeId': placeId,
      'photo': await MultipartFile.fromFile(filePath),
    });

    final envelope = await _api.post(
      '/rewards/fotograf',
      body: form,
      decode: (json) => PhotoSubmission.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }

  /// Coini premium hakkına çevirir.
  Future<RewardStatus> redeem(PremiumPackage package) async {
    final envelope = await _api.post(
      '/rewards/premium-al',
      body: {'package': package.wireValue},
      decode: (json) => RewardStatus.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data;
  }
}

final rewardsServiceProvider = Provider<RewardsService>(
  (ref) => RewardsService(ref.watch(apiClientProvider)),
);

/// Ekonomi kuralları. Oturum boyunca bir kez çekilmesi yeterli.
final rewardRulesProvider = FutureProvider<RewardRules>(
  (ref) => ref.watch(rewardsServiceProvider).rules(),
);

/// Kullanıcının coin ve premium durumu.
///
/// Fotoğraf gönderildiğinde ve premium alındığında geçersiz kılınıyor.
final rewardStatusProvider = FutureProvider<RewardStatus>((ref) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(rewardsServiceProvider).status();
});

final coinHistoryProvider = FutureProvider<List<CoinEntry>>((ref) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(rewardsServiceProvider).coinHistory();
});

final mySubmissionsProvider = FutureProvider<List<PhotoSubmission>>((
  ref,
) async {
  await ref.watch(sessionProvider.future);
  return ref.watch(rewardsServiceProvider).mySubmissions();
});
