import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward.freezed.dart';
part 'reward.g.dart';

/// Coin ve premium ekonomisinin sunucudan gelen sayıları.
///
/// Değerler uygulamaya gömülmüyor: ekonomi değişince mağaza güncellemesi
/// beklemeden yeni sayılar geçerli olsun.
@freezed
abstract class RewardRules with _$RewardRules {
  const factory RewardRules({
    required int coinsPerApprovedPhoto,
    required int coinsForOneMonth,
    required int coinsForTwoMonths,
    required int coinsForUnlimited,
    required int freeMonthlyTripLimit,
  }) = _RewardRules;

  factory RewardRules.fromJson(Map<String, dynamic> json) =>
      _$RewardRulesFromJson(json);
}

/// Kullanıcının coin bakiyesi, premium durumu ve aylık plan kotası.
@freezed
abstract class RewardStatus with _$RewardStatus {
  const factory RewardStatus({
    @Default(0) int coinBalance,
    @Default(0) int pendingSubmissions,
    @Default(0) int approvedSubmissions,
    @Default(0) int rejectedSubmissions,
    @Default(false) bool isPremium,
    DateTime? premiumExpiresAt,
    @Default(false) bool isPremiumUnlimited,
    @Default(0) int tripsThisMonth,

    /// Ücretsiz hesabın aylık plan kotası. Premium'da **null** — sınırsız.
    int? monthlyTripLimit,
  }) = _RewardStatus;

  const RewardStatus._();

  factory RewardStatus.fromJson(Map<String, dynamic> json) =>
      _$RewardStatusFromJson(json);

  /// Bu ay kaç plan hakkı kaldı. Premium'da null.
  int? get remainingTrips {
    final limit = monthlyTripLimit;
    if (limit == null) return null;
    return (limit - tripsThisMonth).clamp(0, limit);
  }
}

/// Gönderilen bir fotoğrafın durumu.
@freezed
abstract class PhotoSubmission with _$PhotoSubmission {
  const factory PhotoSubmission({
    required int id,
    required int placeId,
    required String placeName,

    /// "Pending" · "Approved" · "Rejected"
    required String status,
    required String url,
    String? rejectionReason,
    int? coinsAwarded,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _PhotoSubmission;

  const PhotoSubmission._();

  factory PhotoSubmission.fromJson(Map<String, dynamic> json) =>
      _$PhotoSubmissionFromJson(json);

  bool get isPending => status == 'Pending';
  bool get isApproved => status == 'Approved';
  bool get isRejected => status == 'Rejected';
}

/// Coin defterindeki bir hareket.
@freezed
abstract class CoinEntry with _$CoinEntry {
  const factory CoinEntry({
    /// Kazanımda artı, harcamada eksi.
    required int amount,

    /// "PhotoApproved" · "PremiumRedeemed" · "Adjustment"
    required String reason,
    String? note,
    required DateTime createdAt,
  }) = _CoinEntry;

  factory CoinEntry.fromJson(Map<String, dynamic> json) =>
      _$CoinEntryFromJson(json);
}

/// Coinle alınabilen premium paketleri.
enum PremiumPackage {
  @JsonValue('OneMonth')
  oneMonth,

  @JsonValue('TwoMonths')
  twoMonths,

  @JsonValue('Unlimited')
  unlimited;

  String get wireValue => switch (this) {
    PremiumPackage.oneMonth => 'OneMonth',
    PremiumPackage.twoMonths => 'TwoMonths',
    PremiumPackage.unlimited => 'Unlimited',
  };
}
