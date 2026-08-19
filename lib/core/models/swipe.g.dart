// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SwipeRecord _$SwipeRecordFromJson(Map<String, dynamic> json) => _SwipeRecord(
  placeId: (json['placeId'] as num).toInt(),
  direction: $enumDecode(_$SwipeDirectionEnumMap, json['direction']),
  context: $enumDecode(_$SwipeContextEnumMap, json['context']),
  swipedAt: json['swipedAt'] == null
      ? null
      : DateTime.parse(json['swipedAt'] as String),
);

Map<String, dynamic> _$SwipeRecordToJson(_SwipeRecord instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'direction': _$SwipeDirectionEnumMap[instance.direction]!,
      'context': _$SwipeContextEnumMap[instance.context]!,
    };

const _$SwipeDirectionEnumMap = {
  SwipeDirection.like: 'Like',
  SwipeDirection.pass: 'Pass',
  SwipeDirection.later: 'Later',
};

const _$SwipeContextEnumMap = {
  SwipeContext.city: 'City',
  SwipeContext.route: 'Route',
};

_SwipeResult _$SwipeResultFromJson(Map<String, dynamic> json) => _SwipeResult(
  recorded: (json['recorded'] as num).toInt(),
  totalLiked: (json['totalLiked'] as num).toInt(),
);

Map<String, dynamic> _$SwipeResultToJson(_SwipeResult instance) =>
    <String, dynamic>{
      'recorded': instance.recorded,
      'totalLiked': instance.totalLiked,
    };

_SwipeUndoResult _$SwipeUndoResultFromJson(Map<String, dynamic> json) =>
    _SwipeUndoResult(
      removed: json['removed'] as bool,
      totalLiked: (json['totalLiked'] as num).toInt(),
    );

Map<String, dynamic> _$SwipeUndoResultToJson(_SwipeUndoResult instance) =>
    <String, dynamic>{
      'removed': instance.removed,
      'totalLiked': instance.totalLiked,
    };
