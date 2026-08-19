// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Trip {

 int get id; String get name; TripMode get mode; TravelMode get travelMode; String? get cityName; int? get cityId; GeoPoint? get startPoint; GeoPoint? get endPoint; List<TripPlace> get places;// Sunucu bu üçünü ondalıklı döndürüyor (ör. 39660.5); `int` olarak
// modellenirse çözümleme patlar.
 double? get distanceMeters; double? get durationSeconds; int? get visitDurationMinutes;/// Kodlanmış polyline (precision 5). Haritada çizmeden önce çözülmeli.
 String? get routeGeometry; DateTime get createdAt;
/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCopyWith<Trip> get copyWith => _$TripCopyWithImpl<Trip>(this as Trip, _$identity);

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trip&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.startPoint, startPoint) || other.startPoint == startPoint)&&(identical(other.endPoint, endPoint) || other.endPoint == endPoint)&&const DeepCollectionEquality().equals(other.places, places)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.visitDurationMinutes, visitDurationMinutes) || other.visitDurationMinutes == visitDurationMinutes)&&(identical(other.routeGeometry, routeGeometry) || other.routeGeometry == routeGeometry)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mode,travelMode,cityName,cityId,startPoint,endPoint,const DeepCollectionEquality().hash(places),distanceMeters,durationSeconds,visitDurationMinutes,routeGeometry,createdAt);

@override
String toString() {
  return 'Trip(id: $id, name: $name, mode: $mode, travelMode: $travelMode, cityName: $cityName, cityId: $cityId, startPoint: $startPoint, endPoint: $endPoint, places: $places, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, visitDurationMinutes: $visitDurationMinutes, routeGeometry: $routeGeometry, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TripCopyWith<$Res>  {
  factory $TripCopyWith(Trip value, $Res Function(Trip) _then) = _$TripCopyWithImpl;
@useResult
$Res call({
 int id, String name, TripMode mode, TravelMode travelMode, String? cityName, int? cityId, GeoPoint? startPoint, GeoPoint? endPoint, List<TripPlace> places, double? distanceMeters, double? durationSeconds, int? visitDurationMinutes, String? routeGeometry, DateTime createdAt
});


$GeoPointCopyWith<$Res>? get startPoint;$GeoPointCopyWith<$Res>? get endPoint;

}
/// @nodoc
class _$TripCopyWithImpl<$Res>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._self, this._then);

  final Trip _self;
  final $Res Function(Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? mode = null,Object? travelMode = null,Object? cityName = freezed,Object? cityId = freezed,Object? startPoint = freezed,Object? endPoint = freezed,Object? places = null,Object? distanceMeters = freezed,Object? durationSeconds = freezed,Object? visitDurationMinutes = freezed,Object? routeGeometry = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TripMode,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as TravelMode,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,startPoint: freezed == startPoint ? _self.startPoint : startPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,endPoint: freezed == endPoint ? _self.endPoint : endPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<TripPlace>,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double?,visitDurationMinutes: freezed == visitDurationMinutes ? _self.visitDurationMinutes : visitDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,routeGeometry: freezed == routeGeometry ? _self.routeGeometry : routeGeometry // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get startPoint {
    if (_self.startPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.startPoint!, (value) {
    return _then(_self.copyWith(startPoint: value));
  });
}/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get endPoint {
    if (_self.endPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.endPoint!, (value) {
    return _then(_self.copyWith(endPoint: value));
  });
}
}


/// Adds pattern-matching-related methods to [Trip].
extension TripPatterns on Trip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trip value)  $default,){
final _that = this;
switch (_that) {
case _Trip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trip value)?  $default,){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  TripMode mode,  TravelMode travelMode,  String? cityName,  int? cityId,  GeoPoint? startPoint,  GeoPoint? endPoint,  List<TripPlace> places,  double? distanceMeters,  double? durationSeconds,  int? visitDurationMinutes,  String? routeGeometry,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.name,_that.mode,_that.travelMode,_that.cityName,_that.cityId,_that.startPoint,_that.endPoint,_that.places,_that.distanceMeters,_that.durationSeconds,_that.visitDurationMinutes,_that.routeGeometry,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  TripMode mode,  TravelMode travelMode,  String? cityName,  int? cityId,  GeoPoint? startPoint,  GeoPoint? endPoint,  List<TripPlace> places,  double? distanceMeters,  double? durationSeconds,  int? visitDurationMinutes,  String? routeGeometry,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Trip():
return $default(_that.id,_that.name,_that.mode,_that.travelMode,_that.cityName,_that.cityId,_that.startPoint,_that.endPoint,_that.places,_that.distanceMeters,_that.durationSeconds,_that.visitDurationMinutes,_that.routeGeometry,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  TripMode mode,  TravelMode travelMode,  String? cityName,  int? cityId,  GeoPoint? startPoint,  GeoPoint? endPoint,  List<TripPlace> places,  double? distanceMeters,  double? durationSeconds,  int? visitDurationMinutes,  String? routeGeometry,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.name,_that.mode,_that.travelMode,_that.cityName,_that.cityId,_that.startPoint,_that.endPoint,_that.places,_that.distanceMeters,_that.durationSeconds,_that.visitDurationMinutes,_that.routeGeometry,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Trip extends Trip {
  const _Trip({required this.id, required this.name, required this.mode, required this.travelMode, this.cityName, this.cityId, this.startPoint, this.endPoint, final  List<TripPlace> places = const <TripPlace>[], this.distanceMeters, this.durationSeconds, this.visitDurationMinutes, this.routeGeometry, required this.createdAt}): _places = places,super._();
  factory _Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

@override final  int id;
@override final  String name;
@override final  TripMode mode;
@override final  TravelMode travelMode;
@override final  String? cityName;
@override final  int? cityId;
@override final  GeoPoint? startPoint;
@override final  GeoPoint? endPoint;
 final  List<TripPlace> _places;
@override@JsonKey() List<TripPlace> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}

// Sunucu bu üçünü ondalıklı döndürüyor (ör. 39660.5); `int` olarak
// modellenirse çözümleme patlar.
@override final  double? distanceMeters;
@override final  double? durationSeconds;
@override final  int? visitDurationMinutes;
/// Kodlanmış polyline (precision 5). Haritada çizmeden önce çözülmeli.
@override final  String? routeGeometry;
@override final  DateTime createdAt;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCopyWith<_Trip> get copyWith => __$TripCopyWithImpl<_Trip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trip&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.startPoint, startPoint) || other.startPoint == startPoint)&&(identical(other.endPoint, endPoint) || other.endPoint == endPoint)&&const DeepCollectionEquality().equals(other._places, _places)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.visitDurationMinutes, visitDurationMinutes) || other.visitDurationMinutes == visitDurationMinutes)&&(identical(other.routeGeometry, routeGeometry) || other.routeGeometry == routeGeometry)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mode,travelMode,cityName,cityId,startPoint,endPoint,const DeepCollectionEquality().hash(_places),distanceMeters,durationSeconds,visitDurationMinutes,routeGeometry,createdAt);

@override
String toString() {
  return 'Trip(id: $id, name: $name, mode: $mode, travelMode: $travelMode, cityName: $cityName, cityId: $cityId, startPoint: $startPoint, endPoint: $endPoint, places: $places, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, visitDurationMinutes: $visitDurationMinutes, routeGeometry: $routeGeometry, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TripCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$TripCopyWith(_Trip value, $Res Function(_Trip) _then) = __$TripCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, TripMode mode, TravelMode travelMode, String? cityName, int? cityId, GeoPoint? startPoint, GeoPoint? endPoint, List<TripPlace> places, double? distanceMeters, double? durationSeconds, int? visitDurationMinutes, String? routeGeometry, DateTime createdAt
});


@override $GeoPointCopyWith<$Res>? get startPoint;@override $GeoPointCopyWith<$Res>? get endPoint;

}
/// @nodoc
class __$TripCopyWithImpl<$Res>
    implements _$TripCopyWith<$Res> {
  __$TripCopyWithImpl(this._self, this._then);

  final _Trip _self;
  final $Res Function(_Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? mode = null,Object? travelMode = null,Object? cityName = freezed,Object? cityId = freezed,Object? startPoint = freezed,Object? endPoint = freezed,Object? places = null,Object? distanceMeters = freezed,Object? durationSeconds = freezed,Object? visitDurationMinutes = freezed,Object? routeGeometry = freezed,Object? createdAt = null,}) {
  return _then(_Trip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TripMode,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as TravelMode,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,startPoint: freezed == startPoint ? _self.startPoint : startPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,endPoint: freezed == endPoint ? _self.endPoint : endPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<TripPlace>,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double?,visitDurationMinutes: freezed == visitDurationMinutes ? _self.visitDurationMinutes : visitDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,routeGeometry: freezed == routeGeometry ? _self.routeGeometry : routeGeometry // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get startPoint {
    if (_self.startPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.startPoint!, (value) {
    return _then(_self.copyWith(startPoint: value));
  });
}/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get endPoint {
    if (_self.endPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.endPoint!, (value) {
    return _then(_self.copyWith(endPoint: value));
  });
}
}


/// @nodoc
mixin _$TripSummary {

 int get id; String get name; TripMode get mode; TravelMode get travelMode; String? get cityName; int get placeCount; double? get distanceMeters; String? get coverPhotoUrl; String? get coverPhotoThumbUrl;/// Kapak görselinin yanında gösterilmesi zorunlu atıf satırı (CC BY-SA).
/// Boşsa kapak gösterilemez.
 String? get coverPhotoAttribution; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of TripSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripSummaryCopyWith<TripSummary> get copyWith => _$TripSummaryCopyWithImpl<TripSummary>(this as TripSummary, _$identity);

  /// Serializes this TripSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.coverPhotoThumbUrl, coverPhotoThumbUrl) || other.coverPhotoThumbUrl == coverPhotoThumbUrl)&&(identical(other.coverPhotoAttribution, coverPhotoAttribution) || other.coverPhotoAttribution == coverPhotoAttribution)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mode,travelMode,cityName,placeCount,distanceMeters,coverPhotoUrl,coverPhotoThumbUrl,coverPhotoAttribution,createdAt,updatedAt);

@override
String toString() {
  return 'TripSummary(id: $id, name: $name, mode: $mode, travelMode: $travelMode, cityName: $cityName, placeCount: $placeCount, distanceMeters: $distanceMeters, coverPhotoUrl: $coverPhotoUrl, coverPhotoThumbUrl: $coverPhotoThumbUrl, coverPhotoAttribution: $coverPhotoAttribution, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TripSummaryCopyWith<$Res>  {
  factory $TripSummaryCopyWith(TripSummary value, $Res Function(TripSummary) _then) = _$TripSummaryCopyWithImpl;
@useResult
$Res call({
 int id, String name, TripMode mode, TravelMode travelMode, String? cityName, int placeCount, double? distanceMeters, String? coverPhotoUrl, String? coverPhotoThumbUrl, String? coverPhotoAttribution, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$TripSummaryCopyWithImpl<$Res>
    implements $TripSummaryCopyWith<$Res> {
  _$TripSummaryCopyWithImpl(this._self, this._then);

  final TripSummary _self;
  final $Res Function(TripSummary) _then;

/// Create a copy of TripSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? mode = null,Object? travelMode = null,Object? cityName = freezed,Object? placeCount = null,Object? distanceMeters = freezed,Object? coverPhotoUrl = freezed,Object? coverPhotoThumbUrl = freezed,Object? coverPhotoAttribution = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TripMode,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as TravelMode,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverPhotoThumbUrl: freezed == coverPhotoThumbUrl ? _self.coverPhotoThumbUrl : coverPhotoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,coverPhotoAttribution: freezed == coverPhotoAttribution ? _self.coverPhotoAttribution : coverPhotoAttribution // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripSummary].
extension TripSummaryPatterns on TripSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripSummary value)  $default,){
final _that = this;
switch (_that) {
case _TripSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TripSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  TripMode mode,  TravelMode travelMode,  String? cityName,  int placeCount,  double? distanceMeters,  String? coverPhotoUrl,  String? coverPhotoThumbUrl,  String? coverPhotoAttribution,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripSummary() when $default != null:
return $default(_that.id,_that.name,_that.mode,_that.travelMode,_that.cityName,_that.placeCount,_that.distanceMeters,_that.coverPhotoUrl,_that.coverPhotoThumbUrl,_that.coverPhotoAttribution,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  TripMode mode,  TravelMode travelMode,  String? cityName,  int placeCount,  double? distanceMeters,  String? coverPhotoUrl,  String? coverPhotoThumbUrl,  String? coverPhotoAttribution,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TripSummary():
return $default(_that.id,_that.name,_that.mode,_that.travelMode,_that.cityName,_that.placeCount,_that.distanceMeters,_that.coverPhotoUrl,_that.coverPhotoThumbUrl,_that.coverPhotoAttribution,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  TripMode mode,  TravelMode travelMode,  String? cityName,  int placeCount,  double? distanceMeters,  String? coverPhotoUrl,  String? coverPhotoThumbUrl,  String? coverPhotoAttribution,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TripSummary() when $default != null:
return $default(_that.id,_that.name,_that.mode,_that.travelMode,_that.cityName,_that.placeCount,_that.distanceMeters,_that.coverPhotoUrl,_that.coverPhotoThumbUrl,_that.coverPhotoAttribution,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripSummary extends TripSummary {
  const _TripSummary({required this.id, required this.name, required this.mode, required this.travelMode, this.cityName, this.placeCount = 0, this.distanceMeters, this.coverPhotoUrl, this.coverPhotoThumbUrl, this.coverPhotoAttribution, required this.createdAt, this.updatedAt}): super._();
  factory _TripSummary.fromJson(Map<String, dynamic> json) => _$TripSummaryFromJson(json);

@override final  int id;
@override final  String name;
@override final  TripMode mode;
@override final  TravelMode travelMode;
@override final  String? cityName;
@override@JsonKey() final  int placeCount;
@override final  double? distanceMeters;
@override final  String? coverPhotoUrl;
@override final  String? coverPhotoThumbUrl;
/// Kapak görselinin yanında gösterilmesi zorunlu atıf satırı (CC BY-SA).
/// Boşsa kapak gösterilemez.
@override final  String? coverPhotoAttribution;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of TripSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripSummaryCopyWith<_TripSummary> get copyWith => __$TripSummaryCopyWithImpl<_TripSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.coverPhotoThumbUrl, coverPhotoThumbUrl) || other.coverPhotoThumbUrl == coverPhotoThumbUrl)&&(identical(other.coverPhotoAttribution, coverPhotoAttribution) || other.coverPhotoAttribution == coverPhotoAttribution)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mode,travelMode,cityName,placeCount,distanceMeters,coverPhotoUrl,coverPhotoThumbUrl,coverPhotoAttribution,createdAt,updatedAt);

@override
String toString() {
  return 'TripSummary(id: $id, name: $name, mode: $mode, travelMode: $travelMode, cityName: $cityName, placeCount: $placeCount, distanceMeters: $distanceMeters, coverPhotoUrl: $coverPhotoUrl, coverPhotoThumbUrl: $coverPhotoThumbUrl, coverPhotoAttribution: $coverPhotoAttribution, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TripSummaryCopyWith<$Res> implements $TripSummaryCopyWith<$Res> {
  factory _$TripSummaryCopyWith(_TripSummary value, $Res Function(_TripSummary) _then) = __$TripSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, TripMode mode, TravelMode travelMode, String? cityName, int placeCount, double? distanceMeters, String? coverPhotoUrl, String? coverPhotoThumbUrl, String? coverPhotoAttribution, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$TripSummaryCopyWithImpl<$Res>
    implements _$TripSummaryCopyWith<$Res> {
  __$TripSummaryCopyWithImpl(this._self, this._then);

  final _TripSummary _self;
  final $Res Function(_TripSummary) _then;

/// Create a copy of TripSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? mode = null,Object? travelMode = null,Object? cityName = freezed,Object? placeCount = null,Object? distanceMeters = freezed,Object? coverPhotoUrl = freezed,Object? coverPhotoThumbUrl = freezed,Object? coverPhotoAttribution = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_TripSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TripMode,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as TravelMode,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverPhotoThumbUrl: freezed == coverPhotoThumbUrl ? _self.coverPhotoThumbUrl : coverPhotoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,coverPhotoAttribution: freezed == coverPhotoAttribution ? _self.coverPhotoAttribution : coverPhotoAttribution // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TripPlace {

/// Uğrama sırası (1'den başlar).
 int get order;/// Çok günlük planlarda gün numarası. Bölme mantığı henüz sunucuda yok.
 int get dayIndex; bool get isVisited; String? get note; PlaceCard get place;
/// Create a copy of TripPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripPlaceCopyWith<TripPlace> get copyWith => _$TripPlaceCopyWithImpl<TripPlace>(this as TripPlace, _$identity);

  /// Serializes this TripPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripPlace&&(identical(other.order, order) || other.order == order)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.isVisited, isVisited) || other.isVisited == isVisited)&&(identical(other.note, note) || other.note == note)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,dayIndex,isVisited,note,place);

@override
String toString() {
  return 'TripPlace(order: $order, dayIndex: $dayIndex, isVisited: $isVisited, note: $note, place: $place)';
}


}

/// @nodoc
abstract mixin class $TripPlaceCopyWith<$Res>  {
  factory $TripPlaceCopyWith(TripPlace value, $Res Function(TripPlace) _then) = _$TripPlaceCopyWithImpl;
@useResult
$Res call({
 int order, int dayIndex, bool isVisited, String? note, PlaceCard place
});


$PlaceCardCopyWith<$Res> get place;

}
/// @nodoc
class _$TripPlaceCopyWithImpl<$Res>
    implements $TripPlaceCopyWith<$Res> {
  _$TripPlaceCopyWithImpl(this._self, this._then);

  final TripPlace _self;
  final $Res Function(TripPlace) _then;

/// Create a copy of TripPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? dayIndex = null,Object? isVisited = null,Object? note = freezed,Object? place = null,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,dayIndex: null == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int,isVisited: null == isVisited ? _self.isVisited : isVisited // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceCard,
  ));
}
/// Create a copy of TripPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCardCopyWith<$Res> get place {
  
  return $PlaceCardCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripPlace].
extension TripPlacePatterns on TripPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripPlace value)  $default,){
final _that = this;
switch (_that) {
case _TripPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripPlace value)?  $default,){
final _that = this;
switch (_that) {
case _TripPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int order,  int dayIndex,  bool isVisited,  String? note,  PlaceCard place)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripPlace() when $default != null:
return $default(_that.order,_that.dayIndex,_that.isVisited,_that.note,_that.place);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int order,  int dayIndex,  bool isVisited,  String? note,  PlaceCard place)  $default,) {final _that = this;
switch (_that) {
case _TripPlace():
return $default(_that.order,_that.dayIndex,_that.isVisited,_that.note,_that.place);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int order,  int dayIndex,  bool isVisited,  String? note,  PlaceCard place)?  $default,) {final _that = this;
switch (_that) {
case _TripPlace() when $default != null:
return $default(_that.order,_that.dayIndex,_that.isVisited,_that.note,_that.place);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripPlace implements TripPlace {
  const _TripPlace({required this.order, this.dayIndex = 0, this.isVisited = false, this.note, required this.place});
  factory _TripPlace.fromJson(Map<String, dynamic> json) => _$TripPlaceFromJson(json);

/// Uğrama sırası (1'den başlar).
@override final  int order;
/// Çok günlük planlarda gün numarası. Bölme mantığı henüz sunucuda yok.
@override@JsonKey() final  int dayIndex;
@override@JsonKey() final  bool isVisited;
@override final  String? note;
@override final  PlaceCard place;

/// Create a copy of TripPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripPlaceCopyWith<_TripPlace> get copyWith => __$TripPlaceCopyWithImpl<_TripPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripPlace&&(identical(other.order, order) || other.order == order)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.isVisited, isVisited) || other.isVisited == isVisited)&&(identical(other.note, note) || other.note == note)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,dayIndex,isVisited,note,place);

@override
String toString() {
  return 'TripPlace(order: $order, dayIndex: $dayIndex, isVisited: $isVisited, note: $note, place: $place)';
}


}

/// @nodoc
abstract mixin class _$TripPlaceCopyWith<$Res> implements $TripPlaceCopyWith<$Res> {
  factory _$TripPlaceCopyWith(_TripPlace value, $Res Function(_TripPlace) _then) = __$TripPlaceCopyWithImpl;
@override @useResult
$Res call({
 int order, int dayIndex, bool isVisited, String? note, PlaceCard place
});


@override $PlaceCardCopyWith<$Res> get place;

}
/// @nodoc
class __$TripPlaceCopyWithImpl<$Res>
    implements _$TripPlaceCopyWith<$Res> {
  __$TripPlaceCopyWithImpl(this._self, this._then);

  final _TripPlace _self;
  final $Res Function(_TripPlace) _then;

/// Create a copy of TripPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? dayIndex = null,Object? isVisited = null,Object? note = freezed,Object? place = null,}) {
  return _then(_TripPlace(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,dayIndex: null == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int,isVisited: null == isVisited ? _self.isVisited : isVisited // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceCard,
  ));
}

/// Create a copy of TripPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCardCopyWith<$Res> get place {
  
  return $PlaceCardCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}

// dart format on
