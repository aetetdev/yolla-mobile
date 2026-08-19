// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardRules _$RewardRulesFromJson(Map<String, dynamic> json) => _RewardRules(
  coinsPerApprovedPhoto: (json['coinsPerApprovedPhoto'] as num).toInt(),
  coinsForOneMonth: (json['coinsForOneMonth'] as num).toInt(),
  coinsForTwoMonths: (json['coinsForTwoMonths'] as num).toInt(),
  coinsForUnlimited: (json['coinsForUnlimited'] as num).toInt(),
  freeMonthlyTripLimit: (json['freeMonthlyTripLimit'] as num).toInt(),
);

Map<String, dynamic> _$RewardRulesToJson(_RewardRules instance) =>
    <String, dynamic>{
      'coinsPerApprovedPhoto': instance.coinsPerApprovedPhoto,
      'coinsForOneMonth': instance.coinsForOneMonth,
      'coinsForTwoMonths': instance.coinsForTwoMonths,
      'coinsForUnlimited': instance.coinsForUnlimited,
      'freeMonthlyTripLimit': instance.freeMonthlyTripLimit,
    };

_RewardStatus _$RewardStatusFromJson(Map<String, dynamic> json) =>
    _RewardStatus(
      coinBalance: (json['coinBalance'] as num?)?.toInt() ?? 0,
      pendingSubmissions: (json['pendingSubmissions'] as num?)?.toInt() ?? 0,
      approvedSubmissions: (json['approvedSubmissions'] as num?)?.toInt() ?? 0,
      rejectedSubmissions: (json['rejectedSubmissions'] as num?)?.toInt() ?? 0,
      isPremium: json['isPremium'] as bool? ?? false,
      premiumExpiresAt: json['premiumExpiresAt'] == null
          ? null
          : DateTime.parse(json['premiumExpiresAt'] as String),
      isPremiumUnlimited: json['isPremiumUnlimited'] as bool? ?? false,
      tripsThisMonth: (json['tripsThisMonth'] as num?)?.toInt() ?? 0,
      monthlyTripLimit: (json['monthlyTripLimit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RewardStatusToJson(_RewardStatus instance) =>
    <String, dynamic>{
      'coinBalance': instance.coinBalance,
      'pendingSubmissions': instance.pendingSubmissions,
      'approvedSubmissions': instance.approvedSubmissions,
      'rejectedSubmissions': instance.rejectedSubmissions,
      'isPremium': instance.isPremium,
      'premiumExpiresAt': instance.premiumExpiresAt?.toIso8601String(),
      'isPremiumUnlimited': instance.isPremiumUnlimited,
      'tripsThisMonth': instance.tripsThisMonth,
      'monthlyTripLimit': instance.monthlyTripLimit,
    };

_PhotoSubmission _$PhotoSubmissionFromJson(Map<String, dynamic> json) =>
    _PhotoSubmission(
      id: (json['id'] as num).toInt(),
      placeId: (json['placeId'] as num).toInt(),
      placeName: json['placeName'] as String,
      status: json['status'] as String,
      url: json['url'] as String,
      rejectionReason: json['rejectionReason'] as String?,
      coinsAwarded: (json['coinsAwarded'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reviewedAt: json['reviewedAt'] == null
          ? null
          : DateTime.parse(json['reviewedAt'] as String),
    );

Map<String, dynamic> _$PhotoSubmissionToJson(_PhotoSubmission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'placeName': instance.placeName,
      'status': instance.status,
      'url': instance.url,
      'rejectionReason': instance.rejectionReason,
      'coinsAwarded': instance.coinsAwarded,
      'createdAt': instance.createdAt.toIso8601String(),
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
    };

_CoinEntry _$CoinEntryFromJson(Map<String, dynamic> json) => _CoinEntry(
  amount: (json['amount'] as num).toInt(),
  reason: json['reason'] as String,
  note: json['note'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CoinEntryToJson(_CoinEntry instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'reason': instance.reason,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
    };
