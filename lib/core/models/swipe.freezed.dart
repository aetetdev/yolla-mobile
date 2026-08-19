// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SwipeRecord {

 int get placeId; SwipeDirection get direction; SwipeContext get context;@JsonKey(includeToJson: false) DateTime? get swipedAt;
/// Create a copy of SwipeRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwipeRecordCopyWith<SwipeRecord> get copyWith => _$SwipeRecordCopyWithImpl<SwipeRecord>(this as SwipeRecord, _$identity);

  /// Serializes this SwipeRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwipeRecord&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.context, context) || other.context == context)&&(identical(other.swipedAt, swipedAt) || other.swipedAt == swipedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,direction,context,swipedAt);

@override
String toString() {
  return 'SwipeRecord(placeId: $placeId, direction: $direction, context: $context, swipedAt: $swipedAt)';
}


}

/// @nodoc
abstract mixin class $SwipeRecordCopyWith<$Res>  {
  factory $SwipeRecordCopyWith(SwipeRecord value, $Res Function(SwipeRecord) _then) = _$SwipeRecordCopyWithImpl;
@useResult
$Res call({
 int placeId, SwipeDirection direction, SwipeContext context,@JsonKey(includeToJson: false) DateTime? swipedAt
});




}
/// @nodoc
class _$SwipeRecordCopyWithImpl<$Res>
    implements $SwipeRecordCopyWith<$Res> {
  _$SwipeRecordCopyWithImpl(this._self, this._then);

  final SwipeRecord _self;
  final $Res Function(SwipeRecord) _then;

/// Create a copy of SwipeRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? direction = null,Object? context = null,Object? swipedAt = freezed,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as SwipeDirection,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as SwipeContext,swipedAt: freezed == swipedAt ? _self.swipedAt : swipedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SwipeRecord].
extension SwipeRecordPatterns on SwipeRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwipeRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwipeRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwipeRecord value)  $default,){
final _that = this;
switch (_that) {
case _SwipeRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwipeRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SwipeRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int placeId,  SwipeDirection direction,  SwipeContext context, @JsonKey(includeToJson: false)  DateTime? swipedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwipeRecord() when $default != null:
return $default(_that.placeId,_that.direction,_that.context,_that.swipedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int placeId,  SwipeDirection direction,  SwipeContext context, @JsonKey(includeToJson: false)  DateTime? swipedAt)  $default,) {final _that = this;
switch (_that) {
case _SwipeRecord():
return $default(_that.placeId,_that.direction,_that.context,_that.swipedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int placeId,  SwipeDirection direction,  SwipeContext context, @JsonKey(includeToJson: false)  DateTime? swipedAt)?  $default,) {final _that = this;
switch (_that) {
case _SwipeRecord() when $default != null:
return $default(_that.placeId,_that.direction,_that.context,_that.swipedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SwipeRecord implements SwipeRecord {
  const _SwipeRecord({required this.placeId, required this.direction, required this.context, @JsonKey(includeToJson: false) this.swipedAt});
  factory _SwipeRecord.fromJson(Map<String, dynamic> json) => _$SwipeRecordFromJson(json);

@override final  int placeId;
@override final  SwipeDirection direction;
@override final  SwipeContext context;
@override@JsonKey(includeToJson: false) final  DateTime? swipedAt;

/// Create a copy of SwipeRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwipeRecordCopyWith<_SwipeRecord> get copyWith => __$SwipeRecordCopyWithImpl<_SwipeRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SwipeRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwipeRecord&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.context, context) || other.context == context)&&(identical(other.swipedAt, swipedAt) || other.swipedAt == swipedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,direction,context,swipedAt);

@override
String toString() {
  return 'SwipeRecord(placeId: $placeId, direction: $direction, context: $context, swipedAt: $swipedAt)';
}


}

/// @nodoc
abstract mixin class _$SwipeRecordCopyWith<$Res> implements $SwipeRecordCopyWith<$Res> {
  factory _$SwipeRecordCopyWith(_SwipeRecord value, $Res Function(_SwipeRecord) _then) = __$SwipeRecordCopyWithImpl;
@override @useResult
$Res call({
 int placeId, SwipeDirection direction, SwipeContext context,@JsonKey(includeToJson: false) DateTime? swipedAt
});




}
/// @nodoc
class __$SwipeRecordCopyWithImpl<$Res>
    implements _$SwipeRecordCopyWith<$Res> {
  __$SwipeRecordCopyWithImpl(this._self, this._then);

  final _SwipeRecord _self;
  final $Res Function(_SwipeRecord) _then;

/// Create a copy of SwipeRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? direction = null,Object? context = null,Object? swipedAt = freezed,}) {
  return _then(_SwipeRecord(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as SwipeDirection,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as SwipeContext,swipedAt: freezed == swipedAt ? _self.swipedAt : swipedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SwipeResult {

 int get recorded; int get totalLiked;
/// Create a copy of SwipeResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwipeResultCopyWith<SwipeResult> get copyWith => _$SwipeResultCopyWithImpl<SwipeResult>(this as SwipeResult, _$identity);

  /// Serializes this SwipeResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwipeResult&&(identical(other.recorded, recorded) || other.recorded == recorded)&&(identical(other.totalLiked, totalLiked) || other.totalLiked == totalLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recorded,totalLiked);

@override
String toString() {
  return 'SwipeResult(recorded: $recorded, totalLiked: $totalLiked)';
}


}

/// @nodoc
abstract mixin class $SwipeResultCopyWith<$Res>  {
  factory $SwipeResultCopyWith(SwipeResult value, $Res Function(SwipeResult) _then) = _$SwipeResultCopyWithImpl;
@useResult
$Res call({
 int recorded, int totalLiked
});




}
/// @nodoc
class _$SwipeResultCopyWithImpl<$Res>
    implements $SwipeResultCopyWith<$Res> {
  _$SwipeResultCopyWithImpl(this._self, this._then);

  final SwipeResult _self;
  final $Res Function(SwipeResult) _then;

/// Create a copy of SwipeResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recorded = null,Object? totalLiked = null,}) {
  return _then(_self.copyWith(
recorded: null == recorded ? _self.recorded : recorded // ignore: cast_nullable_to_non_nullable
as int,totalLiked: null == totalLiked ? _self.totalLiked : totalLiked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SwipeResult].
extension SwipeResultPatterns on SwipeResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwipeResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwipeResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwipeResult value)  $default,){
final _that = this;
switch (_that) {
case _SwipeResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwipeResult value)?  $default,){
final _that = this;
switch (_that) {
case _SwipeResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int recorded,  int totalLiked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwipeResult() when $default != null:
return $default(_that.recorded,_that.totalLiked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int recorded,  int totalLiked)  $default,) {final _that = this;
switch (_that) {
case _SwipeResult():
return $default(_that.recorded,_that.totalLiked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int recorded,  int totalLiked)?  $default,) {final _that = this;
switch (_that) {
case _SwipeResult() when $default != null:
return $default(_that.recorded,_that.totalLiked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SwipeResult implements SwipeResult {
  const _SwipeResult({required this.recorded, required this.totalLiked});
  factory _SwipeResult.fromJson(Map<String, dynamic> json) => _$SwipeResultFromJson(json);

@override final  int recorded;
@override final  int totalLiked;

/// Create a copy of SwipeResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwipeResultCopyWith<_SwipeResult> get copyWith => __$SwipeResultCopyWithImpl<_SwipeResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SwipeResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwipeResult&&(identical(other.recorded, recorded) || other.recorded == recorded)&&(identical(other.totalLiked, totalLiked) || other.totalLiked == totalLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recorded,totalLiked);

@override
String toString() {
  return 'SwipeResult(recorded: $recorded, totalLiked: $totalLiked)';
}


}

/// @nodoc
abstract mixin class _$SwipeResultCopyWith<$Res> implements $SwipeResultCopyWith<$Res> {
  factory _$SwipeResultCopyWith(_SwipeResult value, $Res Function(_SwipeResult) _then) = __$SwipeResultCopyWithImpl;
@override @useResult
$Res call({
 int recorded, int totalLiked
});




}
/// @nodoc
class __$SwipeResultCopyWithImpl<$Res>
    implements _$SwipeResultCopyWith<$Res> {
  __$SwipeResultCopyWithImpl(this._self, this._then);

  final _SwipeResult _self;
  final $Res Function(_SwipeResult) _then;

/// Create a copy of SwipeResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recorded = null,Object? totalLiked = null,}) {
  return _then(_SwipeResult(
recorded: null == recorded ? _self.recorded : recorded // ignore: cast_nullable_to_non_nullable
as int,totalLiked: null == totalLiked ? _self.totalLiked : totalLiked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SwipeUndoResult {

/// Silinecek bir kayıt bulundu mu? Bulunmaması hata değil.
 bool get removed; int get totalLiked;
/// Create a copy of SwipeUndoResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwipeUndoResultCopyWith<SwipeUndoResult> get copyWith => _$SwipeUndoResultCopyWithImpl<SwipeUndoResult>(this as SwipeUndoResult, _$identity);

  /// Serializes this SwipeUndoResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwipeUndoResult&&(identical(other.removed, removed) || other.removed == removed)&&(identical(other.totalLiked, totalLiked) || other.totalLiked == totalLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,removed,totalLiked);

@override
String toString() {
  return 'SwipeUndoResult(removed: $removed, totalLiked: $totalLiked)';
}


}

/// @nodoc
abstract mixin class $SwipeUndoResultCopyWith<$Res>  {
  factory $SwipeUndoResultCopyWith(SwipeUndoResult value, $Res Function(SwipeUndoResult) _then) = _$SwipeUndoResultCopyWithImpl;
@useResult
$Res call({
 bool removed, int totalLiked
});




}
/// @nodoc
class _$SwipeUndoResultCopyWithImpl<$Res>
    implements $SwipeUndoResultCopyWith<$Res> {
  _$SwipeUndoResultCopyWithImpl(this._self, this._then);

  final SwipeUndoResult _self;
  final $Res Function(SwipeUndoResult) _then;

/// Create a copy of SwipeUndoResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? removed = null,Object? totalLiked = null,}) {
  return _then(_self.copyWith(
removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,totalLiked: null == totalLiked ? _self.totalLiked : totalLiked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SwipeUndoResult].
extension SwipeUndoResultPatterns on SwipeUndoResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwipeUndoResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwipeUndoResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwipeUndoResult value)  $default,){
final _that = this;
switch (_that) {
case _SwipeUndoResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwipeUndoResult value)?  $default,){
final _that = this;
switch (_that) {
case _SwipeUndoResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool removed,  int totalLiked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwipeUndoResult() when $default != null:
return $default(_that.removed,_that.totalLiked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool removed,  int totalLiked)  $default,) {final _that = this;
switch (_that) {
case _SwipeUndoResult():
return $default(_that.removed,_that.totalLiked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool removed,  int totalLiked)?  $default,) {final _that = this;
switch (_that) {
case _SwipeUndoResult() when $default != null:
return $default(_that.removed,_that.totalLiked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SwipeUndoResult implements SwipeUndoResult {
  const _SwipeUndoResult({required this.removed, required this.totalLiked});
  factory _SwipeUndoResult.fromJson(Map<String, dynamic> json) => _$SwipeUndoResultFromJson(json);

/// Silinecek bir kayıt bulundu mu? Bulunmaması hata değil.
@override final  bool removed;
@override final  int totalLiked;

/// Create a copy of SwipeUndoResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwipeUndoResultCopyWith<_SwipeUndoResult> get copyWith => __$SwipeUndoResultCopyWithImpl<_SwipeUndoResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SwipeUndoResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwipeUndoResult&&(identical(other.removed, removed) || other.removed == removed)&&(identical(other.totalLiked, totalLiked) || other.totalLiked == totalLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,removed,totalLiked);

@override
String toString() {
  return 'SwipeUndoResult(removed: $removed, totalLiked: $totalLiked)';
}


}

/// @nodoc
abstract mixin class _$SwipeUndoResultCopyWith<$Res> implements $SwipeUndoResultCopyWith<$Res> {
  factory _$SwipeUndoResultCopyWith(_SwipeUndoResult value, $Res Function(_SwipeUndoResult) _then) = __$SwipeUndoResultCopyWithImpl;
@override @useResult
$Res call({
 bool removed, int totalLiked
});




}
/// @nodoc
class __$SwipeUndoResultCopyWithImpl<$Res>
    implements _$SwipeUndoResultCopyWith<$Res> {
  __$SwipeUndoResultCopyWithImpl(this._self, this._then);

  final _SwipeUndoResult _self;
  final $Res Function(_SwipeUndoResult) _then;

/// Create a copy of SwipeUndoResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? removed = null,Object? totalLiked = null,}) {
  return _then(_SwipeUndoResult(
removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,totalLiked: null == totalLiked ? _self.totalLiked : totalLiked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
