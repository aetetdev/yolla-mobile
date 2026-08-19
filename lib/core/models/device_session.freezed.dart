// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceSession {

 int get deviceId; String get accessToken; DateTime get expiresAt;/// Cihaz bir hesaba bağlandığında dolar. Hesap özelliği backend'de
/// yazılıyor; şimdilik her zaman null.
 int? get userId;
/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSessionCopyWith<DeviceSession> get copyWith => _$DeviceSessionCopyWithImpl<DeviceSession>(this as DeviceSession, _$identity);

  /// Serializes this DeviceSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSession&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,accessToken,expiresAt,userId);

@override
String toString() {
  return 'DeviceSession(deviceId: $deviceId, accessToken: $accessToken, expiresAt: $expiresAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $DeviceSessionCopyWith<$Res>  {
  factory $DeviceSessionCopyWith(DeviceSession value, $Res Function(DeviceSession) _then) = _$DeviceSessionCopyWithImpl;
@useResult
$Res call({
 int deviceId, String accessToken, DateTime expiresAt, int? userId
});




}
/// @nodoc
class _$DeviceSessionCopyWithImpl<$Res>
    implements $DeviceSessionCopyWith<$Res> {
  _$DeviceSessionCopyWithImpl(this._self, this._then);

  final DeviceSession _self;
  final $Res Function(DeviceSession) _then;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? accessToken = null,Object? expiresAt = null,Object? userId = freezed,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceSession].
extension DeviceSessionPatterns on DeviceSession {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceSession value)  $default,){
final _that = this;
switch (_that) {
case _DeviceSession():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceSession value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int deviceId,  String accessToken,  DateTime expiresAt,  int? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
return $default(_that.deviceId,_that.accessToken,_that.expiresAt,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int deviceId,  String accessToken,  DateTime expiresAt,  int? userId)  $default,) {final _that = this;
switch (_that) {
case _DeviceSession():
return $default(_that.deviceId,_that.accessToken,_that.expiresAt,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int deviceId,  String accessToken,  DateTime expiresAt,  int? userId)?  $default,) {final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
return $default(_that.deviceId,_that.accessToken,_that.expiresAt,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceSession extends DeviceSession {
  const _DeviceSession({required this.deviceId, required this.accessToken, required this.expiresAt, this.userId}): super._();
  factory _DeviceSession.fromJson(Map<String, dynamic> json) => _$DeviceSessionFromJson(json);

@override final  int deviceId;
@override final  String accessToken;
@override final  DateTime expiresAt;
/// Cihaz bir hesaba bağlandığında dolar. Hesap özelliği backend'de
/// yazılıyor; şimdilik her zaman null.
@override final  int? userId;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSessionCopyWith<_DeviceSession> get copyWith => __$DeviceSessionCopyWithImpl<_DeviceSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSession&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,accessToken,expiresAt,userId);

@override
String toString() {
  return 'DeviceSession(deviceId: $deviceId, accessToken: $accessToken, expiresAt: $expiresAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$DeviceSessionCopyWith<$Res> implements $DeviceSessionCopyWith<$Res> {
  factory _$DeviceSessionCopyWith(_DeviceSession value, $Res Function(_DeviceSession) _then) = __$DeviceSessionCopyWithImpl;
@override @useResult
$Res call({
 int deviceId, String accessToken, DateTime expiresAt, int? userId
});




}
/// @nodoc
class __$DeviceSessionCopyWithImpl<$Res>
    implements _$DeviceSessionCopyWith<$Res> {
  __$DeviceSessionCopyWithImpl(this._self, this._then);

  final _DeviceSession _self;
  final $Res Function(_DeviceSession) _then;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? accessToken = null,Object? expiresAt = null,Object? userId = freezed,}) {
  return _then(_DeviceSession(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
