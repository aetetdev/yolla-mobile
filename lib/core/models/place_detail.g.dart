// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceDetail _$PlaceDetailFromJson(Map<String, dynamic> json) => _PlaceDetail(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  nameEn: json['nameEn'] as String?,
  slug: json['slug'] as String,
  categoryKey: json['categoryKey'] as String,
  categoryName: json['categoryName'] as String,
  categoryIcon: json['categoryIcon'] as String?,
  description: json['description'] as String?,
  photoUrl: json['photoUrl'] as String?,
  photoThumbUrl: json['photoThumbUrl'] as String?,
  photoLargeUrl: json['photoLargeUrl'] as String?,
  photoAttribution: json['photoAttribution'] as String?,
  photoSource: json['photoSource'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  cityName: json['cityName'] as String?,
  citySlug: json['citySlug'] as String?,
  districtName: json['districtName'] as String?,
  address: json['address'] as String?,
  website: json['website'] as String?,
  openingHours: json['openingHours'] as String?,
  wikipediaUrl: json['wikipediaUrl'] as String?,
  averageVisitMinutes: (json['averageVisitMinutes'] as num?)?.toInt(),
  qualityScore: (json['qualityScore'] as num).toInt(),
  directionsUrl: json['directionsUrl'] as String?,
  nearby:
      (json['nearby'] as List<dynamic>?)
          ?.map((e) => NearbyPlace.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <NearbyPlace>[],
);

Map<String, dynamic> _$PlaceDetailToJson(_PlaceDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'slug': instance.slug,
      'categoryKey': instance.categoryKey,
      'categoryName': instance.categoryName,
      'categoryIcon': instance.categoryIcon,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'photoThumbUrl': instance.photoThumbUrl,
      'photoLargeUrl': instance.photoLargeUrl,
      'photoAttribution': instance.photoAttribution,
      'photoSource': instance.photoSource,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'cityName': instance.cityName,
      'citySlug': instance.citySlug,
      'districtName': instance.districtName,
      'address': instance.address,
      'website': instance.website,
      'openingHours': instance.openingHours,
      'wikipediaUrl': instance.wikipediaUrl,
      'averageVisitMinutes': instance.averageVisitMinutes,
      'qualityScore': instance.qualityScore,
      'directionsUrl': instance.directionsUrl,
      'nearby': instance.nearby,
    };

_NearbyPlace _$NearbyPlaceFromJson(Map<String, dynamic> json) => _NearbyPlace(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  categoryName: json['categoryName'] as String?,
  photoUrl: json['photoUrl'] as String?,
  photoThumbUrl: json['photoThumbUrl'] as String?,
  photoAttribution: json['photoAttribution'] as String?,
  distanceMeters: (json['distanceMeters'] as num).toInt(),
);

Map<String, dynamic> _$NearbyPlaceToJson(_NearbyPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'categoryName': instance.categoryName,
      'photoUrl': instance.photoUrl,
      'photoThumbUrl': instance.photoThumbUrl,
      'photoAttribution': instance.photoAttribution,
      'distanceMeters': instance.distanceMeters,
    };
