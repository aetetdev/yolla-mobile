// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlacePin _$PlacePinFromJson(Map<String, dynamic> json) => _PlacePin(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  categoryKey: json['categoryKey'] as String,
  categoryIcon: json['categoryIcon'] as String?,
  hasPhoto: json['hasPhoto'] as bool? ?? false,
  qualityScore: (json['qualityScore'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PlacePinToJson(_PlacePin instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'categoryKey': instance.categoryKey,
  'categoryIcon': instance.categoryIcon,
  'hasPhoto': instance.hasPhoto,
  'qualityScore': instance.qualityScore,
};
