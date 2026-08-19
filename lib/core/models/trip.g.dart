// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Trip _$TripFromJson(Map<String, dynamic> json) => _Trip(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  mode: $enumDecode(_$TripModeEnumMap, json['mode']),
  travelMode: $enumDecode(_$TravelModeEnumMap, json['travelMode']),
  cityName: json['cityName'] as String?,
  cityId: (json['cityId'] as num?)?.toInt(),
  startPoint: json['startPoint'] == null
      ? null
      : GeoPoint.fromJson(json['startPoint'] as Map<String, dynamic>),
  endPoint: json['endPoint'] == null
      ? null
      : GeoPoint.fromJson(json['endPoint'] as Map<String, dynamic>),
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => TripPlace.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TripPlace>[],
  distanceMeters: (json['distanceMeters'] as num?)?.toDouble(),
  durationSeconds: (json['durationSeconds'] as num?)?.toDouble(),
  visitDurationMinutes: (json['visitDurationMinutes'] as num?)?.toInt(),
  routeGeometry: json['routeGeometry'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TripToJson(_Trip instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'mode': _$TripModeEnumMap[instance.mode]!,
  'travelMode': _$TravelModeEnumMap[instance.travelMode]!,
  'cityName': instance.cityName,
  'cityId': instance.cityId,
  'startPoint': instance.startPoint,
  'endPoint': instance.endPoint,
  'places': instance.places,
  'distanceMeters': instance.distanceMeters,
  'durationSeconds': instance.durationSeconds,
  'visitDurationMinutes': instance.visitDurationMinutes,
  'routeGeometry': instance.routeGeometry,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$TripModeEnumMap = {TripMode.city: 'City', TripMode.route: 'Route'};

const _$TravelModeEnumMap = {TravelMode.foot: 'Foot', TravelMode.car: 'Car'};

_TripSummary _$TripSummaryFromJson(Map<String, dynamic> json) => _TripSummary(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  mode: $enumDecode(_$TripModeEnumMap, json['mode']),
  travelMode: $enumDecode(_$TravelModeEnumMap, json['travelMode']),
  cityName: json['cityName'] as String?,
  placeCount: (json['placeCount'] as num?)?.toInt() ?? 0,
  distanceMeters: (json['distanceMeters'] as num?)?.toDouble(),
  coverPhotoUrl: json['coverPhotoUrl'] as String?,
  coverPhotoThumbUrl: json['coverPhotoThumbUrl'] as String?,
  coverPhotoAttribution: json['coverPhotoAttribution'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TripSummaryToJson(_TripSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mode': _$TripModeEnumMap[instance.mode]!,
      'travelMode': _$TravelModeEnumMap[instance.travelMode]!,
      'cityName': instance.cityName,
      'placeCount': instance.placeCount,
      'distanceMeters': instance.distanceMeters,
      'coverPhotoUrl': instance.coverPhotoUrl,
      'coverPhotoThumbUrl': instance.coverPhotoThumbUrl,
      'coverPhotoAttribution': instance.coverPhotoAttribution,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_TripPlace _$TripPlaceFromJson(Map<String, dynamic> json) => _TripPlace(
  order: (json['order'] as num).toInt(),
  dayIndex: (json['dayIndex'] as num?)?.toInt() ?? 0,
  isVisited: json['isVisited'] as bool? ?? false,
  note: json['note'] as String?,
  place: PlaceCard.fromJson(json['place'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripPlaceToJson(_TripPlace instance) =>
    <String, dynamic>{
      'order': instance.order,
      'dayIndex': instance.dayIndex,
      'isVisited': instance.isVisited,
      'note': instance.note,
      'place': instance.place,
    };
