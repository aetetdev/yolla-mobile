// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_pin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlacePin {

 int get id; String get name; String get slug; double get latitude; double get longitude; String get categoryKey; String? get categoryIcon;/// Yayınlanabilir fotoğrafı var mı?
///
/// Fotoğrafsız yerler haritada bilerek gösteriliyor — kullanıcıdan
/// fotoğraf istemenin doğal yeri burası. İşaret farklı çiziliyor.
 bool get hasPhoto; int get qualityScore;
/// Create a copy of PlacePin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePinCopyWith<PlacePin> get copyWith => _$PlacePinCopyWithImpl<PlacePin>(this as PlacePin, _$identity);

  /// Serializes this PlacePin to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePin&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.hasPhoto, hasPhoto) || other.hasPhoto == hasPhoto)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,latitude,longitude,categoryKey,categoryIcon,hasPhoto,qualityScore);

@override
String toString() {
  return 'PlacePin(id: $id, name: $name, slug: $slug, latitude: $latitude, longitude: $longitude, categoryKey: $categoryKey, categoryIcon: $categoryIcon, hasPhoto: $hasPhoto, qualityScore: $qualityScore)';
}


}

/// @nodoc
abstract mixin class $PlacePinCopyWith<$Res>  {
  factory $PlacePinCopyWith(PlacePin value, $Res Function(PlacePin) _then) = _$PlacePinCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, double latitude, double longitude, String categoryKey, String? categoryIcon, bool hasPhoto, int qualityScore
});




}
/// @nodoc
class _$PlacePinCopyWithImpl<$Res>
    implements $PlacePinCopyWith<$Res> {
  _$PlacePinCopyWithImpl(this._self, this._then);

  final PlacePin _self;
  final $Res Function(PlacePin) _then;

/// Create a copy of PlacePin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? latitude = null,Object? longitude = null,Object? categoryKey = null,Object? categoryIcon = freezed,Object? hasPhoto = null,Object? qualityScore = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,hasPhoto: null == hasPhoto ? _self.hasPhoto : hasPhoto // ignore: cast_nullable_to_non_nullable
as bool,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacePin].
extension PlacePinPatterns on PlacePin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacePin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacePin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacePin value)  $default,){
final _that = this;
switch (_that) {
case _PlacePin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacePin value)?  $default,){
final _that = this;
switch (_that) {
case _PlacePin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  double latitude,  double longitude,  String categoryKey,  String? categoryIcon,  bool hasPhoto,  int qualityScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacePin() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.latitude,_that.longitude,_that.categoryKey,_that.categoryIcon,_that.hasPhoto,_that.qualityScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  double latitude,  double longitude,  String categoryKey,  String? categoryIcon,  bool hasPhoto,  int qualityScore)  $default,) {final _that = this;
switch (_that) {
case _PlacePin():
return $default(_that.id,_that.name,_that.slug,_that.latitude,_that.longitude,_that.categoryKey,_that.categoryIcon,_that.hasPhoto,_that.qualityScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  double latitude,  double longitude,  String categoryKey,  String? categoryIcon,  bool hasPhoto,  int qualityScore)?  $default,) {final _that = this;
switch (_that) {
case _PlacePin() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.latitude,_that.longitude,_that.categoryKey,_that.categoryIcon,_that.hasPhoto,_that.qualityScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacePin implements PlacePin {
  const _PlacePin({required this.id, required this.name, required this.slug, required this.latitude, required this.longitude, required this.categoryKey, this.categoryIcon, this.hasPhoto = false, this.qualityScore = 0});
  factory _PlacePin.fromJson(Map<String, dynamic> json) => _$PlacePinFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  double latitude;
@override final  double longitude;
@override final  String categoryKey;
@override final  String? categoryIcon;
/// Yayınlanabilir fotoğrafı var mı?
///
/// Fotoğrafsız yerler haritada bilerek gösteriliyor — kullanıcıdan
/// fotoğraf istemenin doğal yeri burası. İşaret farklı çiziliyor.
@override@JsonKey() final  bool hasPhoto;
@override@JsonKey() final  int qualityScore;

/// Create a copy of PlacePin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacePinCopyWith<_PlacePin> get copyWith => __$PlacePinCopyWithImpl<_PlacePin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacePinToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacePin&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.hasPhoto, hasPhoto) || other.hasPhoto == hasPhoto)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,latitude,longitude,categoryKey,categoryIcon,hasPhoto,qualityScore);

@override
String toString() {
  return 'PlacePin(id: $id, name: $name, slug: $slug, latitude: $latitude, longitude: $longitude, categoryKey: $categoryKey, categoryIcon: $categoryIcon, hasPhoto: $hasPhoto, qualityScore: $qualityScore)';
}


}

/// @nodoc
abstract mixin class _$PlacePinCopyWith<$Res> implements $PlacePinCopyWith<$Res> {
  factory _$PlacePinCopyWith(_PlacePin value, $Res Function(_PlacePin) _then) = __$PlacePinCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, double latitude, double longitude, String categoryKey, String? categoryIcon, bool hasPhoto, int qualityScore
});




}
/// @nodoc
class __$PlacePinCopyWithImpl<$Res>
    implements _$PlacePinCopyWith<$Res> {
  __$PlacePinCopyWithImpl(this._self, this._then);

  final _PlacePin _self;
  final $Res Function(_PlacePin) _then;

/// Create a copy of PlacePin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? latitude = null,Object? longitude = null,Object? categoryKey = null,Object? categoryIcon = freezed,Object? hasPhoto = null,Object? qualityScore = null,}) {
  return _then(_PlacePin(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,hasPhoto: null == hasPhoto ? _self.hasPhoto : hasPhoto // ignore: cast_nullable_to_non_nullable
as bool,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
