// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: (json['id'] as num).toInt(),
      kind: $enumDecode(
        _$NotificationKindEnumMap,
        json['kind'],
        unknownValue: NotificationKind.unknown,
      ),
      title: json['title'] as String,
      body: json['body'] as String,
      placeId: (json['placeId'] as num?)?.toInt(),
      isRead: json['isRead'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$NotificationKindEnumMap[instance.kind]!,
      'title': instance.title,
      'body': instance.body,
      'placeId': instance.placeId,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$NotificationKindEnumMap = {
  NotificationKind.photoApproved: 'PhotoApproved',
  NotificationKind.photoRejected: 'PhotoRejected',
  NotificationKind.suggestionApproved: 'SuggestionApproved',
  NotificationKind.suggestionRejected: 'SuggestionRejected',
  NotificationKind.unknown: 'unknown',
};
