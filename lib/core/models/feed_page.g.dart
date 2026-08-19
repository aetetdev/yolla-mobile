// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedPage _$FeedPageFromJson(Map<String, dynamic> json) => _FeedPage(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => PlaceCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PlaceCard>[],
  nextCursor: json['nextCursor'] as String?,
  hasMore: json['hasMore'] as bool? ?? false,
);

Map<String, dynamic> _$FeedPageToJson(_FeedPage instance) => <String, dynamic>{
  'items': instance.items,
  'nextCursor': instance.nextCursor,
  'hasMore': instance.hasMore,
};

_CorridorResult _$CorridorResultFromJson(Map<String, dynamic> json) =>
    _CorridorResult(
      cards: FeedPage.fromJson(json['cards'] as Map<String, dynamic>),
      routeDistanceMeters: (json['routeDistanceMeters'] as num).toDouble(),
      routeDurationSeconds: (json['routeDurationSeconds'] as num).toDouble(),
      routeGeometry: json['routeGeometry'] as String?,
    );

Map<String, dynamic> _$CorridorResultToJson(_CorridorResult instance) =>
    <String, dynamic>{
      'cards': instance.cards,
      'routeDistanceMeters': instance.routeDistanceMeters,
      'routeDurationSeconds': instance.routeDurationSeconds,
      'routeGeometry': instance.routeGeometry,
    };

_CorridorCity _$CorridorCityFromJson(Map<String, dynamic> json) =>
    _CorridorCity(
      cityId: (json['cityId'] as num).toInt(),
      name: json['name'] as String,
      placeCount: (json['placeCount'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$CorridorCityToJson(_CorridorCity instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'name': instance.name,
      'placeCount': instance.placeCount,
      'progress': instance.progress,
    };

_CorridorCities _$CorridorCitiesFromJson(Map<String, dynamic> json) =>
    _CorridorCities(
      cities:
          (json['cities'] as List<dynamic>?)
              ?.map((e) => CorridorCity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CorridorCity>[],
      routeDistanceMeters: (json['routeDistanceMeters'] as num).toDouble(),
      routeDurationSeconds: (json['routeDurationSeconds'] as num).toDouble(),
      routeGeometry: json['routeGeometry'] as String?,
    );

Map<String, dynamic> _$CorridorCitiesToJson(_CorridorCities instance) =>
    <String, dynamic>{
      'cities': instance.cities,
      'routeDistanceMeters': instance.routeDistanceMeters,
      'routeDurationSeconds': instance.routeDurationSeconds,
      'routeGeometry': instance.routeGeometry,
    };
