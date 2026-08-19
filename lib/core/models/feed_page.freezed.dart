// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedPage {

 List<PlaceCard> get items; String? get nextCursor; bool get hasMore;
/// Create a copy of FeedPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPageCopyWith<FeedPage> get copyWith => _$FeedPageCopyWithImpl<FeedPage>(this as FeedPage, _$identity);

  /// Serializes this FeedPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextCursor,hasMore);

@override
String toString() {
  return 'FeedPage(items: $items, nextCursor: $nextCursor, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $FeedPageCopyWith<$Res>  {
  factory $FeedPageCopyWith(FeedPage value, $Res Function(FeedPage) _then) = _$FeedPageCopyWithImpl;
@useResult
$Res call({
 List<PlaceCard> items, String? nextCursor, bool hasMore
});




}
/// @nodoc
class _$FeedPageCopyWithImpl<$Res>
    implements $FeedPageCopyWith<$Res> {
  _$FeedPageCopyWithImpl(this._self, this._then);

  final FeedPage _self;
  final $Res Function(FeedPage) _then;

/// Create a copy of FeedPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,Object? hasMore = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PlaceCard>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedPage].
extension FeedPagePatterns on FeedPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedPage value)  $default,){
final _that = this;
switch (_that) {
case _FeedPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedPage value)?  $default,){
final _that = this;
switch (_that) {
case _FeedPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlaceCard> items,  String? nextCursor,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedPage() when $default != null:
return $default(_that.items,_that.nextCursor,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlaceCard> items,  String? nextCursor,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _FeedPage():
return $default(_that.items,_that.nextCursor,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlaceCard> items,  String? nextCursor,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _FeedPage() when $default != null:
return $default(_that.items,_that.nextCursor,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedPage implements FeedPage {
  const _FeedPage({final  List<PlaceCard> items = const <PlaceCard>[], this.nextCursor, this.hasMore = false}): _items = items;
  factory _FeedPage.fromJson(Map<String, dynamic> json) => _$FeedPageFromJson(json);

 final  List<PlaceCard> _items;
@override@JsonKey() List<PlaceCard> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;
@override@JsonKey() final  bool hasMore;

/// Create a copy of FeedPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedPageCopyWith<_FeedPage> get copyWith => __$FeedPageCopyWithImpl<_FeedPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedPage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor,hasMore);

@override
String toString() {
  return 'FeedPage(items: $items, nextCursor: $nextCursor, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$FeedPageCopyWith<$Res> implements $FeedPageCopyWith<$Res> {
  factory _$FeedPageCopyWith(_FeedPage value, $Res Function(_FeedPage) _then) = __$FeedPageCopyWithImpl;
@override @useResult
$Res call({
 List<PlaceCard> items, String? nextCursor, bool hasMore
});




}
/// @nodoc
class __$FeedPageCopyWithImpl<$Res>
    implements _$FeedPageCopyWith<$Res> {
  __$FeedPageCopyWithImpl(this._self, this._then);

  final _FeedPage _self;
  final $Res Function(_FeedPage) _then;

/// Create a copy of FeedPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,Object? hasMore = null,}) {
  return _then(_FeedPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PlaceCard>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CorridorResult {

 FeedPage get cards;// Sunucu ondalıklı döndürebiliyor; `int` çözümlemeyi patlatır.
 double get routeDistanceMeters; double get routeDurationSeconds;/// Kodlanmış polyline (precision 5). Haritada çizmeden önce çözülmeli.
 String? get routeGeometry;
/// Create a copy of CorridorResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CorridorResultCopyWith<CorridorResult> get copyWith => _$CorridorResultCopyWithImpl<CorridorResult>(this as CorridorResult, _$identity);

  /// Serializes this CorridorResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CorridorResult&&(identical(other.cards, cards) || other.cards == cards)&&(identical(other.routeDistanceMeters, routeDistanceMeters) || other.routeDistanceMeters == routeDistanceMeters)&&(identical(other.routeDurationSeconds, routeDurationSeconds) || other.routeDurationSeconds == routeDurationSeconds)&&(identical(other.routeGeometry, routeGeometry) || other.routeGeometry == routeGeometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cards,routeDistanceMeters,routeDurationSeconds,routeGeometry);

@override
String toString() {
  return 'CorridorResult(cards: $cards, routeDistanceMeters: $routeDistanceMeters, routeDurationSeconds: $routeDurationSeconds, routeGeometry: $routeGeometry)';
}


}

/// @nodoc
abstract mixin class $CorridorResultCopyWith<$Res>  {
  factory $CorridorResultCopyWith(CorridorResult value, $Res Function(CorridorResult) _then) = _$CorridorResultCopyWithImpl;
@useResult
$Res call({
 FeedPage cards, double routeDistanceMeters, double routeDurationSeconds, String? routeGeometry
});


$FeedPageCopyWith<$Res> get cards;

}
/// @nodoc
class _$CorridorResultCopyWithImpl<$Res>
    implements $CorridorResultCopyWith<$Res> {
  _$CorridorResultCopyWithImpl(this._self, this._then);

  final CorridorResult _self;
  final $Res Function(CorridorResult) _then;

/// Create a copy of CorridorResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cards = null,Object? routeDistanceMeters = null,Object? routeDurationSeconds = null,Object? routeGeometry = freezed,}) {
  return _then(_self.copyWith(
cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as FeedPage,routeDistanceMeters: null == routeDistanceMeters ? _self.routeDistanceMeters : routeDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,routeDurationSeconds: null == routeDurationSeconds ? _self.routeDurationSeconds : routeDurationSeconds // ignore: cast_nullable_to_non_nullable
as double,routeGeometry: freezed == routeGeometry ? _self.routeGeometry : routeGeometry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CorridorResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedPageCopyWith<$Res> get cards {
  
  return $FeedPageCopyWith<$Res>(_self.cards, (value) {
    return _then(_self.copyWith(cards: value));
  });
}
}


/// Adds pattern-matching-related methods to [CorridorResult].
extension CorridorResultPatterns on CorridorResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CorridorResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CorridorResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CorridorResult value)  $default,){
final _that = this;
switch (_that) {
case _CorridorResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CorridorResult value)?  $default,){
final _that = this;
switch (_that) {
case _CorridorResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeedPage cards,  double routeDistanceMeters,  double routeDurationSeconds,  String? routeGeometry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CorridorResult() when $default != null:
return $default(_that.cards,_that.routeDistanceMeters,_that.routeDurationSeconds,_that.routeGeometry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeedPage cards,  double routeDistanceMeters,  double routeDurationSeconds,  String? routeGeometry)  $default,) {final _that = this;
switch (_that) {
case _CorridorResult():
return $default(_that.cards,_that.routeDistanceMeters,_that.routeDurationSeconds,_that.routeGeometry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeedPage cards,  double routeDistanceMeters,  double routeDurationSeconds,  String? routeGeometry)?  $default,) {final _that = this;
switch (_that) {
case _CorridorResult() when $default != null:
return $default(_that.cards,_that.routeDistanceMeters,_that.routeDurationSeconds,_that.routeGeometry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CorridorResult implements CorridorResult {
  const _CorridorResult({required this.cards, required this.routeDistanceMeters, required this.routeDurationSeconds, this.routeGeometry});
  factory _CorridorResult.fromJson(Map<String, dynamic> json) => _$CorridorResultFromJson(json);

@override final  FeedPage cards;
// Sunucu ondalıklı döndürebiliyor; `int` çözümlemeyi patlatır.
@override final  double routeDistanceMeters;
@override final  double routeDurationSeconds;
/// Kodlanmış polyline (precision 5). Haritada çizmeden önce çözülmeli.
@override final  String? routeGeometry;

/// Create a copy of CorridorResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CorridorResultCopyWith<_CorridorResult> get copyWith => __$CorridorResultCopyWithImpl<_CorridorResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CorridorResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CorridorResult&&(identical(other.cards, cards) || other.cards == cards)&&(identical(other.routeDistanceMeters, routeDistanceMeters) || other.routeDistanceMeters == routeDistanceMeters)&&(identical(other.routeDurationSeconds, routeDurationSeconds) || other.routeDurationSeconds == routeDurationSeconds)&&(identical(other.routeGeometry, routeGeometry) || other.routeGeometry == routeGeometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cards,routeDistanceMeters,routeDurationSeconds,routeGeometry);

@override
String toString() {
  return 'CorridorResult(cards: $cards, routeDistanceMeters: $routeDistanceMeters, routeDurationSeconds: $routeDurationSeconds, routeGeometry: $routeGeometry)';
}


}

/// @nodoc
abstract mixin class _$CorridorResultCopyWith<$Res> implements $CorridorResultCopyWith<$Res> {
  factory _$CorridorResultCopyWith(_CorridorResult value, $Res Function(_CorridorResult) _then) = __$CorridorResultCopyWithImpl;
@override @useResult
$Res call({
 FeedPage cards, double routeDistanceMeters, double routeDurationSeconds, String? routeGeometry
});


@override $FeedPageCopyWith<$Res> get cards;

}
/// @nodoc
class __$CorridorResultCopyWithImpl<$Res>
    implements _$CorridorResultCopyWith<$Res> {
  __$CorridorResultCopyWithImpl(this._self, this._then);

  final _CorridorResult _self;
  final $Res Function(_CorridorResult) _then;

/// Create a copy of CorridorResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,Object? routeDistanceMeters = null,Object? routeDurationSeconds = null,Object? routeGeometry = freezed,}) {
  return _then(_CorridorResult(
cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as FeedPage,routeDistanceMeters: null == routeDistanceMeters ? _self.routeDistanceMeters : routeDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,routeDurationSeconds: null == routeDurationSeconds ? _self.routeDurationSeconds : routeDurationSeconds // ignore: cast_nullable_to_non_nullable
as double,routeGeometry: freezed == routeGeometry ? _self.routeGeometry : routeGeometry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CorridorResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedPageCopyWith<$Res> get cards {
  
  return $FeedPageCopyWith<$Res>(_self.cards, (value) {
    return _then(_self.copyWith(cards: value));
  });
}
}


/// @nodoc
mixin _$CorridorCity {

 int get cityId; String get name;/// Bu şehirde koridora giren yer sayısı.
 int get placeCount;/// Şehrin yol üzerindeki yeri (0 = başlangıç, 1 = varış).
 double get progress;
/// Create a copy of CorridorCity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CorridorCityCopyWith<CorridorCity> get copyWith => _$CorridorCityCopyWithImpl<CorridorCity>(this as CorridorCity, _$identity);

  /// Serializes this CorridorCity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CorridorCity&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.name, name) || other.name == name)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.progress, progress) || other.progress == progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cityId,name,placeCount,progress);

@override
String toString() {
  return 'CorridorCity(cityId: $cityId, name: $name, placeCount: $placeCount, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $CorridorCityCopyWith<$Res>  {
  factory $CorridorCityCopyWith(CorridorCity value, $Res Function(CorridorCity) _then) = _$CorridorCityCopyWithImpl;
@useResult
$Res call({
 int cityId, String name, int placeCount, double progress
});




}
/// @nodoc
class _$CorridorCityCopyWithImpl<$Res>
    implements $CorridorCityCopyWith<$Res> {
  _$CorridorCityCopyWithImpl(this._self, this._then);

  final CorridorCity _self;
  final $Res Function(CorridorCity) _then;

/// Create a copy of CorridorCity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cityId = null,Object? name = null,Object? placeCount = null,Object? progress = null,}) {
  return _then(_self.copyWith(
cityId: null == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CorridorCity].
extension CorridorCityPatterns on CorridorCity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CorridorCity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CorridorCity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CorridorCity value)  $default,){
final _that = this;
switch (_that) {
case _CorridorCity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CorridorCity value)?  $default,){
final _that = this;
switch (_that) {
case _CorridorCity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cityId,  String name,  int placeCount,  double progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CorridorCity() when $default != null:
return $default(_that.cityId,_that.name,_that.placeCount,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cityId,  String name,  int placeCount,  double progress)  $default,) {final _that = this;
switch (_that) {
case _CorridorCity():
return $default(_that.cityId,_that.name,_that.placeCount,_that.progress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cityId,  String name,  int placeCount,  double progress)?  $default,) {final _that = this;
switch (_that) {
case _CorridorCity() when $default != null:
return $default(_that.cityId,_that.name,_that.placeCount,_that.progress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CorridorCity implements CorridorCity {
  const _CorridorCity({required this.cityId, required this.name, required this.placeCount, required this.progress});
  factory _CorridorCity.fromJson(Map<String, dynamic> json) => _$CorridorCityFromJson(json);

@override final  int cityId;
@override final  String name;
/// Bu şehirde koridora giren yer sayısı.
@override final  int placeCount;
/// Şehrin yol üzerindeki yeri (0 = başlangıç, 1 = varış).
@override final  double progress;

/// Create a copy of CorridorCity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CorridorCityCopyWith<_CorridorCity> get copyWith => __$CorridorCityCopyWithImpl<_CorridorCity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CorridorCityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CorridorCity&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.name, name) || other.name == name)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.progress, progress) || other.progress == progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cityId,name,placeCount,progress);

@override
String toString() {
  return 'CorridorCity(cityId: $cityId, name: $name, placeCount: $placeCount, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$CorridorCityCopyWith<$Res> implements $CorridorCityCopyWith<$Res> {
  factory _$CorridorCityCopyWith(_CorridorCity value, $Res Function(_CorridorCity) _then) = __$CorridorCityCopyWithImpl;
@override @useResult
$Res call({
 int cityId, String name, int placeCount, double progress
});




}
/// @nodoc
class __$CorridorCityCopyWithImpl<$Res>
    implements _$CorridorCityCopyWith<$Res> {
  __$CorridorCityCopyWithImpl(this._self, this._then);

  final _CorridorCity _self;
  final $Res Function(_CorridorCity) _then;

/// Create a copy of CorridorCity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cityId = null,Object? name = null,Object? placeCount = null,Object? progress = null,}) {
  return _then(_CorridorCity(
cityId: null == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CorridorCities {

 List<CorridorCity> get cities; double get routeDistanceMeters; double get routeDurationSeconds; String? get routeGeometry;
/// Create a copy of CorridorCities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CorridorCitiesCopyWith<CorridorCities> get copyWith => _$CorridorCitiesCopyWithImpl<CorridorCities>(this as CorridorCities, _$identity);

  /// Serializes this CorridorCities to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CorridorCities&&const DeepCollectionEquality().equals(other.cities, cities)&&(identical(other.routeDistanceMeters, routeDistanceMeters) || other.routeDistanceMeters == routeDistanceMeters)&&(identical(other.routeDurationSeconds, routeDurationSeconds) || other.routeDurationSeconds == routeDurationSeconds)&&(identical(other.routeGeometry, routeGeometry) || other.routeGeometry == routeGeometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cities),routeDistanceMeters,routeDurationSeconds,routeGeometry);

@override
String toString() {
  return 'CorridorCities(cities: $cities, routeDistanceMeters: $routeDistanceMeters, routeDurationSeconds: $routeDurationSeconds, routeGeometry: $routeGeometry)';
}


}

/// @nodoc
abstract mixin class $CorridorCitiesCopyWith<$Res>  {
  factory $CorridorCitiesCopyWith(CorridorCities value, $Res Function(CorridorCities) _then) = _$CorridorCitiesCopyWithImpl;
@useResult
$Res call({
 List<CorridorCity> cities, double routeDistanceMeters, double routeDurationSeconds, String? routeGeometry
});




}
/// @nodoc
class _$CorridorCitiesCopyWithImpl<$Res>
    implements $CorridorCitiesCopyWith<$Res> {
  _$CorridorCitiesCopyWithImpl(this._self, this._then);

  final CorridorCities _self;
  final $Res Function(CorridorCities) _then;

/// Create a copy of CorridorCities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cities = null,Object? routeDistanceMeters = null,Object? routeDurationSeconds = null,Object? routeGeometry = freezed,}) {
  return _then(_self.copyWith(
cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<CorridorCity>,routeDistanceMeters: null == routeDistanceMeters ? _self.routeDistanceMeters : routeDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,routeDurationSeconds: null == routeDurationSeconds ? _self.routeDurationSeconds : routeDurationSeconds // ignore: cast_nullable_to_non_nullable
as double,routeGeometry: freezed == routeGeometry ? _self.routeGeometry : routeGeometry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CorridorCities].
extension CorridorCitiesPatterns on CorridorCities {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CorridorCities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CorridorCities() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CorridorCities value)  $default,){
final _that = this;
switch (_that) {
case _CorridorCities():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CorridorCities value)?  $default,){
final _that = this;
switch (_that) {
case _CorridorCities() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CorridorCity> cities,  double routeDistanceMeters,  double routeDurationSeconds,  String? routeGeometry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CorridorCities() when $default != null:
return $default(_that.cities,_that.routeDistanceMeters,_that.routeDurationSeconds,_that.routeGeometry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CorridorCity> cities,  double routeDistanceMeters,  double routeDurationSeconds,  String? routeGeometry)  $default,) {final _that = this;
switch (_that) {
case _CorridorCities():
return $default(_that.cities,_that.routeDistanceMeters,_that.routeDurationSeconds,_that.routeGeometry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CorridorCity> cities,  double routeDistanceMeters,  double routeDurationSeconds,  String? routeGeometry)?  $default,) {final _that = this;
switch (_that) {
case _CorridorCities() when $default != null:
return $default(_that.cities,_that.routeDistanceMeters,_that.routeDurationSeconds,_that.routeGeometry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CorridorCities implements CorridorCities {
  const _CorridorCities({final  List<CorridorCity> cities = const <CorridorCity>[], required this.routeDistanceMeters, required this.routeDurationSeconds, this.routeGeometry}): _cities = cities;
  factory _CorridorCities.fromJson(Map<String, dynamic> json) => _$CorridorCitiesFromJson(json);

 final  List<CorridorCity> _cities;
@override@JsonKey() List<CorridorCity> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}

@override final  double routeDistanceMeters;
@override final  double routeDurationSeconds;
@override final  String? routeGeometry;

/// Create a copy of CorridorCities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CorridorCitiesCopyWith<_CorridorCities> get copyWith => __$CorridorCitiesCopyWithImpl<_CorridorCities>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CorridorCitiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CorridorCities&&const DeepCollectionEquality().equals(other._cities, _cities)&&(identical(other.routeDistanceMeters, routeDistanceMeters) || other.routeDistanceMeters == routeDistanceMeters)&&(identical(other.routeDurationSeconds, routeDurationSeconds) || other.routeDurationSeconds == routeDurationSeconds)&&(identical(other.routeGeometry, routeGeometry) || other.routeGeometry == routeGeometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cities),routeDistanceMeters,routeDurationSeconds,routeGeometry);

@override
String toString() {
  return 'CorridorCities(cities: $cities, routeDistanceMeters: $routeDistanceMeters, routeDurationSeconds: $routeDurationSeconds, routeGeometry: $routeGeometry)';
}


}

/// @nodoc
abstract mixin class _$CorridorCitiesCopyWith<$Res> implements $CorridorCitiesCopyWith<$Res> {
  factory _$CorridorCitiesCopyWith(_CorridorCities value, $Res Function(_CorridorCities) _then) = __$CorridorCitiesCopyWithImpl;
@override @useResult
$Res call({
 List<CorridorCity> cities, double routeDistanceMeters, double routeDurationSeconds, String? routeGeometry
});




}
/// @nodoc
class __$CorridorCitiesCopyWithImpl<$Res>
    implements _$CorridorCitiesCopyWith<$Res> {
  __$CorridorCitiesCopyWithImpl(this._self, this._then);

  final _CorridorCities _self;
  final $Res Function(_CorridorCities) _then;

/// Create a copy of CorridorCities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cities = null,Object? routeDistanceMeters = null,Object? routeDurationSeconds = null,Object? routeGeometry = freezed,}) {
  return _then(_CorridorCities(
cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<CorridorCity>,routeDistanceMeters: null == routeDistanceMeters ? _self.routeDistanceMeters : routeDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,routeDurationSeconds: null == routeDurationSeconds ? _self.routeDurationSeconds : routeDurationSeconds // ignore: cast_nullable_to_non_nullable
as double,routeGeometry: freezed == routeGeometry ? _self.routeGeometry : routeGeometry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
