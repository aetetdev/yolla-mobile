// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuggestionCategory {

/// İstekte gönderilen anahtar ("museum", "viewpoint").
 String get key; String get name; String? get icon;
/// Create a copy of SuggestionCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuggestionCategoryCopyWith<SuggestionCategory> get copyWith => _$SuggestionCategoryCopyWithImpl<SuggestionCategory>(this as SuggestionCategory, _$identity);

  /// Serializes this SuggestionCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuggestionCategory&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,icon);

@override
String toString() {
  return 'SuggestionCategory(key: $key, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $SuggestionCategoryCopyWith<$Res>  {
  factory $SuggestionCategoryCopyWith(SuggestionCategory value, $Res Function(SuggestionCategory) _then) = _$SuggestionCategoryCopyWithImpl;
@useResult
$Res call({
 String key, String name, String? icon
});




}
/// @nodoc
class _$SuggestionCategoryCopyWithImpl<$Res>
    implements $SuggestionCategoryCopyWith<$Res> {
  _$SuggestionCategoryCopyWithImpl(this._self, this._then);

  final SuggestionCategory _self;
  final $Res Function(SuggestionCategory) _then;

/// Create a copy of SuggestionCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuggestionCategory].
extension SuggestionCategoryPatterns on SuggestionCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuggestionCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuggestionCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuggestionCategory value)  $default,){
final _that = this;
switch (_that) {
case _SuggestionCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuggestionCategory value)?  $default,){
final _that = this;
switch (_that) {
case _SuggestionCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuggestionCategory() when $default != null:
return $default(_that.key,_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _SuggestionCategory():
return $default(_that.key,_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _SuggestionCategory() when $default != null:
return $default(_that.key,_that.name,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuggestionCategory implements SuggestionCategory {
  const _SuggestionCategory({required this.key, required this.name, this.icon});
  factory _SuggestionCategory.fromJson(Map<String, dynamic> json) => _$SuggestionCategoryFromJson(json);

/// İstekte gönderilen anahtar ("museum", "viewpoint").
@override final  String key;
@override final  String name;
@override final  String? icon;

/// Create a copy of SuggestionCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuggestionCategoryCopyWith<_SuggestionCategory> get copyWith => __$SuggestionCategoryCopyWithImpl<_SuggestionCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuggestionCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuggestionCategory&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,icon);

@override
String toString() {
  return 'SuggestionCategory(key: $key, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$SuggestionCategoryCopyWith<$Res> implements $SuggestionCategoryCopyWith<$Res> {
  factory _$SuggestionCategoryCopyWith(_SuggestionCategory value, $Res Function(_SuggestionCategory) _then) = __$SuggestionCategoryCopyWithImpl;
@override @useResult
$Res call({
 String key, String name, String? icon
});




}
/// @nodoc
class __$SuggestionCategoryCopyWithImpl<$Res>
    implements _$SuggestionCategoryCopyWith<$Res> {
  __$SuggestionCategoryCopyWithImpl(this._self, this._then);

  final _SuggestionCategory _self;
  final $Res Function(_SuggestionCategory) _then;

/// Create a copy of SuggestionCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? icon = freezed,}) {
  return _then(_SuggestionCategory(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlaceSuggestion {

 int get id; String get name; String get categoryName; String get cityName; double get latitude; double get longitude; String? get description;/// "Pending" · "Approved" · "Rejected"
 String get status; String? get rejectionReason;/// Onaylandıysa kataloğa giren yerin kimliği.
 int? get placeId; int? get coinsAwarded; DateTime get createdAt; DateTime? get reviewedAt;
/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSuggestionCopyWith<PlaceSuggestion> get copyWith => _$PlaceSuggestionCopyWithImpl<PlaceSuggestion>(this as PlaceSuggestion, _$identity);

  /// Serializes this PlaceSuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSuggestion&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.coinsAwarded, coinsAwarded) || other.coinsAwarded == coinsAwarded)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName,cityName,latitude,longitude,description,status,rejectionReason,placeId,coinsAwarded,createdAt,reviewedAt);

@override
String toString() {
  return 'PlaceSuggestion(id: $id, name: $name, categoryName: $categoryName, cityName: $cityName, latitude: $latitude, longitude: $longitude, description: $description, status: $status, rejectionReason: $rejectionReason, placeId: $placeId, coinsAwarded: $coinsAwarded, createdAt: $createdAt, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class $PlaceSuggestionCopyWith<$Res>  {
  factory $PlaceSuggestionCopyWith(PlaceSuggestion value, $Res Function(PlaceSuggestion) _then) = _$PlaceSuggestionCopyWithImpl;
@useResult
$Res call({
 int id, String name, String categoryName, String cityName, double latitude, double longitude, String? description, String status, String? rejectionReason, int? placeId, int? coinsAwarded, DateTime createdAt, DateTime? reviewedAt
});




}
/// @nodoc
class _$PlaceSuggestionCopyWithImpl<$Res>
    implements $PlaceSuggestionCopyWith<$Res> {
  _$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final PlaceSuggestion _self;
  final $Res Function(PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categoryName = null,Object? cityName = null,Object? latitude = null,Object? longitude = null,Object? description = freezed,Object? status = null,Object? rejectionReason = freezed,Object? placeId = freezed,Object? coinsAwarded = freezed,Object? createdAt = null,Object? reviewedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,cityName: null == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int?,coinsAwarded: freezed == coinsAwarded ? _self.coinsAwarded : coinsAwarded // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSuggestion].
extension PlaceSuggestionPatterns on PlaceSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String categoryName,  String cityName,  double latitude,  double longitude,  String? description,  String status,  String? rejectionReason,  int? placeId,  int? coinsAwarded,  DateTime createdAt,  DateTime? reviewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.id,_that.name,_that.categoryName,_that.cityName,_that.latitude,_that.longitude,_that.description,_that.status,_that.rejectionReason,_that.placeId,_that.coinsAwarded,_that.createdAt,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String categoryName,  String cityName,  double latitude,  double longitude,  String? description,  String status,  String? rejectionReason,  int? placeId,  int? coinsAwarded,  DateTime createdAt,  DateTime? reviewedAt)  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion():
return $default(_that.id,_that.name,_that.categoryName,_that.cityName,_that.latitude,_that.longitude,_that.description,_that.status,_that.rejectionReason,_that.placeId,_that.coinsAwarded,_that.createdAt,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String categoryName,  String cityName,  double latitude,  double longitude,  String? description,  String status,  String? rejectionReason,  int? placeId,  int? coinsAwarded,  DateTime createdAt,  DateTime? reviewedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.id,_that.name,_that.categoryName,_that.cityName,_that.latitude,_that.longitude,_that.description,_that.status,_that.rejectionReason,_that.placeId,_that.coinsAwarded,_that.createdAt,_that.reviewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceSuggestion extends PlaceSuggestion {
  const _PlaceSuggestion({required this.id, required this.name, required this.categoryName, required this.cityName, required this.latitude, required this.longitude, this.description, required this.status, this.rejectionReason, this.placeId, this.coinsAwarded, required this.createdAt, this.reviewedAt}): super._();
  factory _PlaceSuggestion.fromJson(Map<String, dynamic> json) => _$PlaceSuggestionFromJson(json);

@override final  int id;
@override final  String name;
@override final  String categoryName;
@override final  String cityName;
@override final  double latitude;
@override final  double longitude;
@override final  String? description;
/// "Pending" · "Approved" · "Rejected"
@override final  String status;
@override final  String? rejectionReason;
/// Onaylandıysa kataloğa giren yerin kimliği.
@override final  int? placeId;
@override final  int? coinsAwarded;
@override final  DateTime createdAt;
@override final  DateTime? reviewedAt;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSuggestionCopyWith<_PlaceSuggestion> get copyWith => __$PlaceSuggestionCopyWithImpl<_PlaceSuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceSuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSuggestion&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.coinsAwarded, coinsAwarded) || other.coinsAwarded == coinsAwarded)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName,cityName,latitude,longitude,description,status,rejectionReason,placeId,coinsAwarded,createdAt,reviewedAt);

@override
String toString() {
  return 'PlaceSuggestion(id: $id, name: $name, categoryName: $categoryName, cityName: $cityName, latitude: $latitude, longitude: $longitude, description: $description, status: $status, rejectionReason: $rejectionReason, placeId: $placeId, coinsAwarded: $coinsAwarded, createdAt: $createdAt, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class _$PlaceSuggestionCopyWith<$Res> implements $PlaceSuggestionCopyWith<$Res> {
  factory _$PlaceSuggestionCopyWith(_PlaceSuggestion value, $Res Function(_PlaceSuggestion) _then) = __$PlaceSuggestionCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String categoryName, String cityName, double latitude, double longitude, String? description, String status, String? rejectionReason, int? placeId, int? coinsAwarded, DateTime createdAt, DateTime? reviewedAt
});




}
/// @nodoc
class __$PlaceSuggestionCopyWithImpl<$Res>
    implements _$PlaceSuggestionCopyWith<$Res> {
  __$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final _PlaceSuggestion _self;
  final $Res Function(_PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categoryName = null,Object? cityName = null,Object? latitude = null,Object? longitude = null,Object? description = freezed,Object? status = null,Object? rejectionReason = freezed,Object? placeId = freezed,Object? coinsAwarded = freezed,Object? createdAt = null,Object? reviewedAt = freezed,}) {
  return _then(_PlaceSuggestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,cityName: null == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int?,coinsAwarded: freezed == coinsAwarded ? _self.coinsAwarded : coinsAwarded // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
