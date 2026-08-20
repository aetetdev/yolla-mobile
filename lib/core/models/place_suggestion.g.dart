// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuggestionCategory _$SuggestionCategoryFromJson(Map<String, dynamic> json) =>
    _SuggestionCategory(
      key: json['key'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$SuggestionCategoryToJson(_SuggestionCategory instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'icon': instance.icon,
    };

_PlaceSuggestion _$PlaceSuggestionFromJson(Map<String, dynamic> json) =>
    _PlaceSuggestion(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      categoryName: json['categoryName'] as String,
      cityName: json['cityName'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] as String?,
      status: json['status'] as String,
      rejectionReason: json['rejectionReason'] as String?,
      placeId: (json['placeId'] as num?)?.toInt(),
      coinsAwarded: (json['coinsAwarded'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reviewedAt: json['reviewedAt'] == null
          ? null
          : DateTime.parse(json['reviewedAt'] as String),
    );

Map<String, dynamic> _$PlaceSuggestionToJson(_PlaceSuggestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryName': instance.categoryName,
      'cityName': instance.cityName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description': instance.description,
      'status': instance.status,
      'rejectionReason': instance.rejectionReason,
      'placeId': instance.placeId,
      'coinsAwarded': instance.coinsAwarded,
      'createdAt': instance.createdAt.toIso8601String(),
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
    };
