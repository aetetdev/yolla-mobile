// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_City _$CityFromJson(Map<String, dynamic> json) => _City(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  readyPlaceCount: (json['readyPlaceCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CityToJson(_City instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'readyPlaceCount': instance.readyPlaceCount,
};
