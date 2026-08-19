// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceCard _$PlaceCardFromJson(Map<String, dynamic> json) => _PlaceCard(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  categoryKey: json['categoryKey'] as String,
  categoryName: json['categoryName'] as String,
  categoryIcon: json['categoryIcon'] as String?,
  photoUrl: json['photoUrl'] as String?,
  photoThumbUrl: json['photoThumbUrl'] as String?,
  photoLargeUrl: json['photoLargeUrl'] as String?,
  photoAttribution: json['photoAttribution'] as String?,
  photoSource: json['photoSource'] as String?,
  description: json['description'] as String?,
  cityId: (json['cityId'] as num?)?.toInt(),
  cityName: json['cityName'] as String?,
  districtName: json['districtName'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  averageVisitMinutes: (json['averageVisitMinutes'] as num?)?.toInt(),
  qualityScore: (json['qualityScore'] as num).toInt(),
  routeProgress: (json['routeProgress'] as num?)?.toDouble(),
  detourMeters: (json['detourMeters'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PlaceCardToJson(_PlaceCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'categoryKey': instance.categoryKey,
      'categoryName': instance.categoryName,
      'categoryIcon': instance.categoryIcon,
      'photoUrl': instance.photoUrl,
      'photoThumbUrl': instance.photoThumbUrl,
      'photoLargeUrl': instance.photoLargeUrl,
      'photoAttribution': instance.photoAttribution,
      'photoSource': instance.photoSource,
      'description': instance.description,
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'districtName': instance.districtName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'averageVisitMinutes': instance.averageVisitMinutes,
      'qualityScore': instance.qualityScore,
      'routeProgress': instance.routeProgress,
      'detourMeters': instance.detourMeters,
    };
