// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceCard {

 int get id; String get name; String get slug; String get categoryKey; String get categoryName; String? get categoryIcon;/// Commons **orijinali** — ortalama ~1 MB, doğrudan gösterilmez.
///
/// Deste yalnızca fotoğraflı yerleri döndürüyor ama bu sunucu tarafında
/// bir kural; istemci buna bağlanmıyor. Ayrıca yer detayı bu tipe
/// dönüştürülüyor ([PlaceDetail.asCard]) ve orada fotoğraf olmayabiliyor.
 String? get photoUrl;/// Sunucunun hazırladığı küçük görsel (500px). Liste ve küçük alanlar için.
 String? get photoThumbUrl;/// Sunucunun hazırladığı büyük görsel (960px). Kart destesi için.
 String? get photoLargeUrl;/// "Fotoğraf: Brocken Inaglory (CC BY-SA 3.0)" — fotoğrafın yanında
/// gösterilmesi zorunlu. Fotoğraf yoksa null.
 String? get photoAttribution;/// Commons dosya sayfası; atıfa dokunulduğunda açılır.
 String? get photoSource; String? get description;/// Bulunduğu şehrin kimliği — beğenilenlerden doğrudan plan kurmak için.
 int? get cityId; String? get cityName; String? get districtName; double get latitude; double get longitude; int? get averageVisitMinutes; int get qualityScore;/// Yolun neresinde (0-1). Yalnızca koridor modunda dolu.
 double? get routeProgress;/// Ana yoldan sapma mesafesi (metre). Yalnızca koridor modunda dolu.
 double? get detourMeters;
/// Create a copy of PlaceCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCardCopyWith<PlaceCard> get copyWith => _$PlaceCardCopyWithImpl<PlaceCard>(this as PlaceCard, _$identity);

  /// Serializes this PlaceCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.photoThumbUrl, photoThumbUrl) || other.photoThumbUrl == photoThumbUrl)&&(identical(other.photoLargeUrl, photoLargeUrl) || other.photoLargeUrl == photoLargeUrl)&&(identical(other.photoAttribution, photoAttribution) || other.photoAttribution == photoAttribution)&&(identical(other.photoSource, photoSource) || other.photoSource == photoSource)&&(identical(other.description, description) || other.description == description)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.districtName, districtName) || other.districtName == districtName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.averageVisitMinutes, averageVisitMinutes) || other.averageVisitMinutes == averageVisitMinutes)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&(identical(other.routeProgress, routeProgress) || other.routeProgress == routeProgress)&&(identical(other.detourMeters, detourMeters) || other.detourMeters == detourMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,slug,categoryKey,categoryName,categoryIcon,photoUrl,photoThumbUrl,photoLargeUrl,photoAttribution,photoSource,description,cityId,cityName,districtName,latitude,longitude,averageVisitMinutes,qualityScore,routeProgress,detourMeters]);

@override
String toString() {
  return 'PlaceCard(id: $id, name: $name, slug: $slug, categoryKey: $categoryKey, categoryName: $categoryName, categoryIcon: $categoryIcon, photoUrl: $photoUrl, photoThumbUrl: $photoThumbUrl, photoLargeUrl: $photoLargeUrl, photoAttribution: $photoAttribution, photoSource: $photoSource, description: $description, cityId: $cityId, cityName: $cityName, districtName: $districtName, latitude: $latitude, longitude: $longitude, averageVisitMinutes: $averageVisitMinutes, qualityScore: $qualityScore, routeProgress: $routeProgress, detourMeters: $detourMeters)';
}


}

/// @nodoc
abstract mixin class $PlaceCardCopyWith<$Res>  {
  factory $PlaceCardCopyWith(PlaceCard value, $Res Function(PlaceCard) _then) = _$PlaceCardCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String categoryKey, String categoryName, String? categoryIcon, String? photoUrl, String? photoThumbUrl, String? photoLargeUrl, String? photoAttribution, String? photoSource, String? description, int? cityId, String? cityName, String? districtName, double latitude, double longitude, int? averageVisitMinutes, int qualityScore, double? routeProgress, double? detourMeters
});




}
/// @nodoc
class _$PlaceCardCopyWithImpl<$Res>
    implements $PlaceCardCopyWith<$Res> {
  _$PlaceCardCopyWithImpl(this._self, this._then);

  final PlaceCard _self;
  final $Res Function(PlaceCard) _then;

/// Create a copy of PlaceCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? categoryKey = null,Object? categoryName = null,Object? categoryIcon = freezed,Object? photoUrl = freezed,Object? photoThumbUrl = freezed,Object? photoLargeUrl = freezed,Object? photoAttribution = freezed,Object? photoSource = freezed,Object? description = freezed,Object? cityId = freezed,Object? cityName = freezed,Object? districtName = freezed,Object? latitude = null,Object? longitude = null,Object? averageVisitMinutes = freezed,Object? qualityScore = null,Object? routeProgress = freezed,Object? detourMeters = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoThumbUrl: freezed == photoThumbUrl ? _self.photoThumbUrl : photoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,photoLargeUrl: freezed == photoLargeUrl ? _self.photoLargeUrl : photoLargeUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAttribution: freezed == photoAttribution ? _self.photoAttribution : photoAttribution // ignore: cast_nullable_to_non_nullable
as String?,photoSource: freezed == photoSource ? _self.photoSource : photoSource // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,districtName: freezed == districtName ? _self.districtName : districtName // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,averageVisitMinutes: freezed == averageVisitMinutes ? _self.averageVisitMinutes : averageVisitMinutes // ignore: cast_nullable_to_non_nullable
as int?,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,routeProgress: freezed == routeProgress ? _self.routeProgress : routeProgress // ignore: cast_nullable_to_non_nullable
as double?,detourMeters: freezed == detourMeters ? _self.detourMeters : detourMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceCard].
extension PlaceCardPatterns on PlaceCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceCard value)  $default,){
final _that = this;
switch (_that) {
case _PlaceCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceCard value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String categoryKey,  String categoryName,  String? categoryIcon,  String? photoUrl,  String? photoThumbUrl,  String? photoLargeUrl,  String? photoAttribution,  String? photoSource,  String? description,  int? cityId,  String? cityName,  String? districtName,  double latitude,  double longitude,  int? averageVisitMinutes,  int qualityScore,  double? routeProgress,  double? detourMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceCard() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.categoryKey,_that.categoryName,_that.categoryIcon,_that.photoUrl,_that.photoThumbUrl,_that.photoLargeUrl,_that.photoAttribution,_that.photoSource,_that.description,_that.cityId,_that.cityName,_that.districtName,_that.latitude,_that.longitude,_that.averageVisitMinutes,_that.qualityScore,_that.routeProgress,_that.detourMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String categoryKey,  String categoryName,  String? categoryIcon,  String? photoUrl,  String? photoThumbUrl,  String? photoLargeUrl,  String? photoAttribution,  String? photoSource,  String? description,  int? cityId,  String? cityName,  String? districtName,  double latitude,  double longitude,  int? averageVisitMinutes,  int qualityScore,  double? routeProgress,  double? detourMeters)  $default,) {final _that = this;
switch (_that) {
case _PlaceCard():
return $default(_that.id,_that.name,_that.slug,_that.categoryKey,_that.categoryName,_that.categoryIcon,_that.photoUrl,_that.photoThumbUrl,_that.photoLargeUrl,_that.photoAttribution,_that.photoSource,_that.description,_that.cityId,_that.cityName,_that.districtName,_that.latitude,_that.longitude,_that.averageVisitMinutes,_that.qualityScore,_that.routeProgress,_that.detourMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String categoryKey,  String categoryName,  String? categoryIcon,  String? photoUrl,  String? photoThumbUrl,  String? photoLargeUrl,  String? photoAttribution,  String? photoSource,  String? description,  int? cityId,  String? cityName,  String? districtName,  double latitude,  double longitude,  int? averageVisitMinutes,  int qualityScore,  double? routeProgress,  double? detourMeters)?  $default,) {final _that = this;
switch (_that) {
case _PlaceCard() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.categoryKey,_that.categoryName,_that.categoryIcon,_that.photoUrl,_that.photoThumbUrl,_that.photoLargeUrl,_that.photoAttribution,_that.photoSource,_that.description,_that.cityId,_that.cityName,_that.districtName,_that.latitude,_that.longitude,_that.averageVisitMinutes,_that.qualityScore,_that.routeProgress,_that.detourMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceCard extends PlaceCard {
  const _PlaceCard({required this.id, required this.name, required this.slug, required this.categoryKey, required this.categoryName, this.categoryIcon, this.photoUrl, this.photoThumbUrl, this.photoLargeUrl, this.photoAttribution, this.photoSource, this.description, this.cityId, this.cityName, this.districtName, required this.latitude, required this.longitude, this.averageVisitMinutes, required this.qualityScore, this.routeProgress, this.detourMeters}): super._();
  factory _PlaceCard.fromJson(Map<String, dynamic> json) => _$PlaceCardFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  String categoryKey;
@override final  String categoryName;
@override final  String? categoryIcon;
/// Commons **orijinali** — ortalama ~1 MB, doğrudan gösterilmez.
///
/// Deste yalnızca fotoğraflı yerleri döndürüyor ama bu sunucu tarafında
/// bir kural; istemci buna bağlanmıyor. Ayrıca yer detayı bu tipe
/// dönüştürülüyor ([PlaceDetail.asCard]) ve orada fotoğraf olmayabiliyor.
@override final  String? photoUrl;
/// Sunucunun hazırladığı küçük görsel (500px). Liste ve küçük alanlar için.
@override final  String? photoThumbUrl;
/// Sunucunun hazırladığı büyük görsel (960px). Kart destesi için.
@override final  String? photoLargeUrl;
/// "Fotoğraf: Brocken Inaglory (CC BY-SA 3.0)" — fotoğrafın yanında
/// gösterilmesi zorunlu. Fotoğraf yoksa null.
@override final  String? photoAttribution;
/// Commons dosya sayfası; atıfa dokunulduğunda açılır.
@override final  String? photoSource;
@override final  String? description;
/// Bulunduğu şehrin kimliği — beğenilenlerden doğrudan plan kurmak için.
@override final  int? cityId;
@override final  String? cityName;
@override final  String? districtName;
@override final  double latitude;
@override final  double longitude;
@override final  int? averageVisitMinutes;
@override final  int qualityScore;
/// Yolun neresinde (0-1). Yalnızca koridor modunda dolu.
@override final  double? routeProgress;
/// Ana yoldan sapma mesafesi (metre). Yalnızca koridor modunda dolu.
@override final  double? detourMeters;

/// Create a copy of PlaceCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCardCopyWith<_PlaceCard> get copyWith => __$PlaceCardCopyWithImpl<_PlaceCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.photoThumbUrl, photoThumbUrl) || other.photoThumbUrl == photoThumbUrl)&&(identical(other.photoLargeUrl, photoLargeUrl) || other.photoLargeUrl == photoLargeUrl)&&(identical(other.photoAttribution, photoAttribution) || other.photoAttribution == photoAttribution)&&(identical(other.photoSource, photoSource) || other.photoSource == photoSource)&&(identical(other.description, description) || other.description == description)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.districtName, districtName) || other.districtName == districtName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.averageVisitMinutes, averageVisitMinutes) || other.averageVisitMinutes == averageVisitMinutes)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&(identical(other.routeProgress, routeProgress) || other.routeProgress == routeProgress)&&(identical(other.detourMeters, detourMeters) || other.detourMeters == detourMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,slug,categoryKey,categoryName,categoryIcon,photoUrl,photoThumbUrl,photoLargeUrl,photoAttribution,photoSource,description,cityId,cityName,districtName,latitude,longitude,averageVisitMinutes,qualityScore,routeProgress,detourMeters]);

@override
String toString() {
  return 'PlaceCard(id: $id, name: $name, slug: $slug, categoryKey: $categoryKey, categoryName: $categoryName, categoryIcon: $categoryIcon, photoUrl: $photoUrl, photoThumbUrl: $photoThumbUrl, photoLargeUrl: $photoLargeUrl, photoAttribution: $photoAttribution, photoSource: $photoSource, description: $description, cityId: $cityId, cityName: $cityName, districtName: $districtName, latitude: $latitude, longitude: $longitude, averageVisitMinutes: $averageVisitMinutes, qualityScore: $qualityScore, routeProgress: $routeProgress, detourMeters: $detourMeters)';
}


}

/// @nodoc
abstract mixin class _$PlaceCardCopyWith<$Res> implements $PlaceCardCopyWith<$Res> {
  factory _$PlaceCardCopyWith(_PlaceCard value, $Res Function(_PlaceCard) _then) = __$PlaceCardCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String categoryKey, String categoryName, String? categoryIcon, String? photoUrl, String? photoThumbUrl, String? photoLargeUrl, String? photoAttribution, String? photoSource, String? description, int? cityId, String? cityName, String? districtName, double latitude, double longitude, int? averageVisitMinutes, int qualityScore, double? routeProgress, double? detourMeters
});




}
/// @nodoc
class __$PlaceCardCopyWithImpl<$Res>
    implements _$PlaceCardCopyWith<$Res> {
  __$PlaceCardCopyWithImpl(this._self, this._then);

  final _PlaceCard _self;
  final $Res Function(_PlaceCard) _then;

/// Create a copy of PlaceCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? categoryKey = null,Object? categoryName = null,Object? categoryIcon = freezed,Object? photoUrl = freezed,Object? photoThumbUrl = freezed,Object? photoLargeUrl = freezed,Object? photoAttribution = freezed,Object? photoSource = freezed,Object? description = freezed,Object? cityId = freezed,Object? cityName = freezed,Object? districtName = freezed,Object? latitude = null,Object? longitude = null,Object? averageVisitMinutes = freezed,Object? qualityScore = null,Object? routeProgress = freezed,Object? detourMeters = freezed,}) {
  return _then(_PlaceCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoThumbUrl: freezed == photoThumbUrl ? _self.photoThumbUrl : photoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,photoLargeUrl: freezed == photoLargeUrl ? _self.photoLargeUrl : photoLargeUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAttribution: freezed == photoAttribution ? _self.photoAttribution : photoAttribution // ignore: cast_nullable_to_non_nullable
as String?,photoSource: freezed == photoSource ? _self.photoSource : photoSource // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,districtName: freezed == districtName ? _self.districtName : districtName // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,averageVisitMinutes: freezed == averageVisitMinutes ? _self.averageVisitMinutes : averageVisitMinutes // ignore: cast_nullable_to_non_nullable
as int?,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,routeProgress: freezed == routeProgress ? _self.routeProgress : routeProgress // ignore: cast_nullable_to_non_nullable
as double?,detourMeters: freezed == detourMeters ? _self.detourMeters : detourMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
