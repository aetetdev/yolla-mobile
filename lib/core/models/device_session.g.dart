// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceSession _$DeviceSessionFromJson(Map<String, dynamic> json) =>
    _DeviceSession(
      deviceId: (json['deviceId'] as num).toInt(),
      accessToken: json['accessToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeviceSessionToJson(_DeviceSession instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'accessToken': instance.accessToken,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'userId': instance.userId,
    };
