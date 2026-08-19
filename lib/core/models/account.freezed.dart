// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Account {

 int get userId; String get email; String? get displayName; DateTime get createdAt; int get deviceCount; int get tripCount;
/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCopyWith<Account> get copyWith => _$AccountCopyWithImpl<Account>(this as Account, _$identity);

  /// Serializes this Account to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Account&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deviceCount, deviceCount) || other.deviceCount == deviceCount)&&(identical(other.tripCount, tripCount) || other.tripCount == tripCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,displayName,createdAt,deviceCount,tripCount);

@override
String toString() {
  return 'Account(userId: $userId, email: $email, displayName: $displayName, createdAt: $createdAt, deviceCount: $deviceCount, tripCount: $tripCount)';
}


}

/// @nodoc
abstract mixin class $AccountCopyWith<$Res>  {
  factory $AccountCopyWith(Account value, $Res Function(Account) _then) = _$AccountCopyWithImpl;
@useResult
$Res call({
 int userId, String email, String? displayName, DateTime createdAt, int deviceCount, int tripCount
});




}
/// @nodoc
class _$AccountCopyWithImpl<$Res>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._self, this._then);

  final Account _self;
  final $Res Function(Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,Object? displayName = freezed,Object? createdAt = null,Object? deviceCount = null,Object? tripCount = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceCount: null == deviceCount ? _self.deviceCount : deviceCount // ignore: cast_nullable_to_non_nullable
as int,tripCount: null == tripCount ? _self.tripCount : tripCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Account].
extension AccountPatterns on Account {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Account value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Account value)  $default,){
final _that = this;
switch (_that) {
case _Account():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Account value)?  $default,){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String email,  String? displayName,  DateTime createdAt,  int deviceCount,  int tripCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.userId,_that.email,_that.displayName,_that.createdAt,_that.deviceCount,_that.tripCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String email,  String? displayName,  DateTime createdAt,  int deviceCount,  int tripCount)  $default,) {final _that = this;
switch (_that) {
case _Account():
return $default(_that.userId,_that.email,_that.displayName,_that.createdAt,_that.deviceCount,_that.tripCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String email,  String? displayName,  DateTime createdAt,  int deviceCount,  int tripCount)?  $default,) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.userId,_that.email,_that.displayName,_that.createdAt,_that.deviceCount,_that.tripCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Account implements Account {
  const _Account({required this.userId, required this.email, this.displayName, required this.createdAt, this.deviceCount = 0, this.tripCount = 0});
  factory _Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

@override final  int userId;
@override final  String email;
@override final  String? displayName;
@override final  DateTime createdAt;
@override@JsonKey() final  int deviceCount;
@override@JsonKey() final  int tripCount;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountCopyWith<_Account> get copyWith => __$AccountCopyWithImpl<_Account>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Account&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deviceCount, deviceCount) || other.deviceCount == deviceCount)&&(identical(other.tripCount, tripCount) || other.tripCount == tripCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,displayName,createdAt,deviceCount,tripCount);

@override
String toString() {
  return 'Account(userId: $userId, email: $email, displayName: $displayName, createdAt: $createdAt, deviceCount: $deviceCount, tripCount: $tripCount)';
}


}

/// @nodoc
abstract mixin class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) _then) = __$AccountCopyWithImpl;
@override @useResult
$Res call({
 int userId, String email, String? displayName, DateTime createdAt, int deviceCount, int tripCount
});




}
/// @nodoc
class __$AccountCopyWithImpl<$Res>
    implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(this._self, this._then);

  final _Account _self;
  final $Res Function(_Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,Object? displayName = freezed,Object? createdAt = null,Object? deviceCount = null,Object? tripCount = null,}) {
  return _then(_Account(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceCount: null == deviceCount ? _self.deviceCount : deviceCount // ignore: cast_nullable_to_non_nullable
as int,tripCount: null == tripCount ? _self.tripCount : tripCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AccountSession {

 Account get account; String get accessToken; DateTime get expiresAt; int get deviceId;
/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountSessionCopyWith<AccountSession> get copyWith => _$AccountSessionCopyWithImpl<AccountSession>(this as AccountSession, _$identity);

  /// Serializes this AccountSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountSession&&(identical(other.account, account) || other.account == account)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,account,accessToken,expiresAt,deviceId);

@override
String toString() {
  return 'AccountSession(account: $account, accessToken: $accessToken, expiresAt: $expiresAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $AccountSessionCopyWith<$Res>  {
  factory $AccountSessionCopyWith(AccountSession value, $Res Function(AccountSession) _then) = _$AccountSessionCopyWithImpl;
@useResult
$Res call({
 Account account, String accessToken, DateTime expiresAt, int deviceId
});


$AccountCopyWith<$Res> get account;

}
/// @nodoc
class _$AccountSessionCopyWithImpl<$Res>
    implements $AccountSessionCopyWith<$Res> {
  _$AccountSessionCopyWithImpl(this._self, this._then);

  final AccountSession _self;
  final $Res Function(AccountSession) _then;

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? accessToken = null,Object? expiresAt = null,Object? deviceId = null,}) {
  return _then(_self.copyWith(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as Account,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCopyWith<$Res> get account {
  
  return $AccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountSession].
extension AccountSessionPatterns on AccountSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountSession value)  $default,){
final _that = this;
switch (_that) {
case _AccountSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountSession value)?  $default,){
final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Account account,  String accessToken,  DateTime expiresAt,  int deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
return $default(_that.account,_that.accessToken,_that.expiresAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Account account,  String accessToken,  DateTime expiresAt,  int deviceId)  $default,) {final _that = this;
switch (_that) {
case _AccountSession():
return $default(_that.account,_that.accessToken,_that.expiresAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Account account,  String accessToken,  DateTime expiresAt,  int deviceId)?  $default,) {final _that = this;
switch (_that) {
case _AccountSession() when $default != null:
return $default(_that.account,_that.accessToken,_that.expiresAt,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountSession implements AccountSession {
  const _AccountSession({required this.account, required this.accessToken, required this.expiresAt, required this.deviceId});
  factory _AccountSession.fromJson(Map<String, dynamic> json) => _$AccountSessionFromJson(json);

@override final  Account account;
@override final  String accessToken;
@override final  DateTime expiresAt;
@override final  int deviceId;

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountSessionCopyWith<_AccountSession> get copyWith => __$AccountSessionCopyWithImpl<_AccountSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountSession&&(identical(other.account, account) || other.account == account)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,account,accessToken,expiresAt,deviceId);

@override
String toString() {
  return 'AccountSession(account: $account, accessToken: $accessToken, expiresAt: $expiresAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$AccountSessionCopyWith<$Res> implements $AccountSessionCopyWith<$Res> {
  factory _$AccountSessionCopyWith(_AccountSession value, $Res Function(_AccountSession) _then) = __$AccountSessionCopyWithImpl;
@override @useResult
$Res call({
 Account account, String accessToken, DateTime expiresAt, int deviceId
});


@override $AccountCopyWith<$Res> get account;

}
/// @nodoc
class __$AccountSessionCopyWithImpl<$Res>
    implements _$AccountSessionCopyWith<$Res> {
  __$AccountSessionCopyWithImpl(this._self, this._then);

  final _AccountSession _self;
  final $Res Function(_AccountSession) _then;

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? accessToken = null,Object? expiresAt = null,Object? deviceId = null,}) {
  return _then(_AccountSession(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as Account,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of AccountSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCopyWith<$Res> get account {
  
  return $AccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
