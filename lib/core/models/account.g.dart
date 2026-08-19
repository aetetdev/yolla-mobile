// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Account _$AccountFromJson(Map<String, dynamic> json) => _Account(
  userId: (json['userId'] as num).toInt(),
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  deviceCount: (json['deviceCount'] as num?)?.toInt() ?? 0,
  tripCount: (json['tripCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AccountToJson(_Account instance) => <String, dynamic>{
  'userId': instance.userId,
  'email': instance.email,
  'displayName': instance.displayName,
  'createdAt': instance.createdAt.toIso8601String(),
  'deviceCount': instance.deviceCount,
  'tripCount': instance.tripCount,
};

_AccountSession _$AccountSessionFromJson(Map<String, dynamic> json) =>
    _AccountSession(
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      deviceId: (json['deviceId'] as num).toInt(),
    );

Map<String, dynamic> _$AccountSessionToJson(_AccountSession instance) =>
    <String, dynamic>{
      'account': instance.account,
      'accessToken': instance.accessToken,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'deviceId': instance.deviceId,
    };
