// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceDetail {

 int get id; String get name; String? get nameEn; String get slug; String get categoryKey; String get categoryName; String? get categoryIcon; String? get description;/// Fotoğrafsız yerlerde **null**.
///
/// Harita fotoğrafsız yerleri de gösteriyor (kullanıcıdan fotoğraf
/// istemenin yeri orası), yani detay ekranı bu durumu karşılamak zorunda.
/// Eskiden zorunluydu ve haritadan fotoğrafsız bir yere dokunmak
/// "type 'Null' is not a subtype of type 'String'" ile çöküyordu.
 String? get photoUrl; String? get photoThumbUrl; String? get photoLargeUrl;/// Fotoğrafın yanında gösterilmesi zorunlu atıf. Fotoğraf yoksa null;
/// **atıf yoksa fotoğraf gösterilemez** (bkz. [PlaceImage.canDisplay]).
 String? get photoAttribution; String? get photoSource; double get latitude; double get longitude; String? get cityName; String? get citySlug; String? get districtName; String? get address; String? get website; String? get openingHours; String? get wikipediaUrl; int? get averageVisitMinutes; int get qualityScore;/// Harita uygulamasında yol tarifi açar.
 String? get directionsUrl; List<NearbyPlace> get nearby;
/// Create a copy of PlaceDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDetailCopyWith<PlaceDetail> get copyWith => _$PlaceDetailCopyWithImpl<PlaceDetail>(this as PlaceDetail, _$identity);

  /// Serializes this PlaceDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.photoThumbUrl, photoThumbUrl) || other.photoThumbUrl == photoThumbUrl)&&(identical(other.photoLargeUrl, photoLargeUrl) || other.photoLargeUrl == photoLargeUrl)&&(identical(other.photoAttribution, photoAttribution) || other.photoAttribution == photoAttribution)&&(identical(other.photoSource, photoSource) || other.photoSource == photoSource)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.citySlug, citySlug) || other.citySlug == citySlug)&&(identical(other.districtName, districtName) || other.districtName == districtName)&&(identical(other.address, address) || other.address == address)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.wikipediaUrl, wikipediaUrl) || other.wikipediaUrl == wikipediaUrl)&&(identical(other.averageVisitMinutes, averageVisitMinutes) || other.averageVisitMinutes == averageVisitMinutes)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&(identical(other.directionsUrl, directionsUrl) || other.directionsUrl == directionsUrl)&&const DeepCollectionEquality().equals(other.nearby, nearby));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,nameEn,slug,categoryKey,categoryName,categoryIcon,description,photoUrl,photoThumbUrl,photoLargeUrl,photoAttribution,photoSource,latitude,longitude,cityName,citySlug,districtName,address,website,openingHours,wikipediaUrl,averageVisitMinutes,qualityScore,directionsUrl,const DeepCollectionEquality().hash(nearby)]);

@override
String toString() {
  return 'PlaceDetail(id: $id, name: $name, nameEn: $nameEn, slug: $slug, categoryKey: $categoryKey, categoryName: $categoryName, categoryIcon: $categoryIcon, description: $description, photoUrl: $photoUrl, photoThumbUrl: $photoThumbUrl, photoLargeUrl: $photoLargeUrl, photoAttribution: $photoAttribution, photoSource: $photoSource, latitude: $latitude, longitude: $longitude, cityName: $cityName, citySlug: $citySlug, districtName: $districtName, address: $address, website: $website, openingHours: $openingHours, wikipediaUrl: $wikipediaUrl, averageVisitMinutes: $averageVisitMinutes, qualityScore: $qualityScore, directionsUrl: $directionsUrl, nearby: $nearby)';
}


}

/// @nodoc
abstract mixin class $PlaceDetailCopyWith<$Res>  {
  factory $PlaceDetailCopyWith(PlaceDetail value, $Res Function(PlaceDetail) _then) = _$PlaceDetailCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? nameEn, String slug, String categoryKey, String categoryName, String? categoryIcon, String? description, String? photoUrl, String? photoThumbUrl, String? photoLargeUrl, String? photoAttribution, String? photoSource, double latitude, double longitude, String? cityName, String? citySlug, String? districtName, String? address, String? website, String? openingHours, String? wikipediaUrl, int? averageVisitMinutes, int qualityScore, String? directionsUrl, List<NearbyPlace> nearby
});




}
/// @nodoc
class _$PlaceDetailCopyWithImpl<$Res>
    implements $PlaceDetailCopyWith<$Res> {
  _$PlaceDetailCopyWithImpl(this._self, this._then);

  final PlaceDetail _self;
  final $Res Function(PlaceDetail) _then;

/// Create a copy of PlaceDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? nameEn = freezed,Object? slug = null,Object? categoryKey = null,Object? categoryName = null,Object? categoryIcon = freezed,Object? description = freezed,Object? photoUrl = freezed,Object? photoThumbUrl = freezed,Object? photoLargeUrl = freezed,Object? photoAttribution = freezed,Object? photoSource = freezed,Object? latitude = null,Object? longitude = null,Object? cityName = freezed,Object? citySlug = freezed,Object? districtName = freezed,Object? address = freezed,Object? website = freezed,Object? openingHours = freezed,Object? wikipediaUrl = freezed,Object? averageVisitMinutes = freezed,Object? qualityScore = null,Object? directionsUrl = freezed,Object? nearby = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoThumbUrl: freezed == photoThumbUrl ? _self.photoThumbUrl : photoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,photoLargeUrl: freezed == photoLargeUrl ? _self.photoLargeUrl : photoLargeUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAttribution: freezed == photoAttribution ? _self.photoAttribution : photoAttribution // ignore: cast_nullable_to_non_nullable
as String?,photoSource: freezed == photoSource ? _self.photoSource : photoSource // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,citySlug: freezed == citySlug ? _self.citySlug : citySlug // ignore: cast_nullable_to_non_nullable
as String?,districtName: freezed == districtName ? _self.districtName : districtName // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,wikipediaUrl: freezed == wikipediaUrl ? _self.wikipediaUrl : wikipediaUrl // ignore: cast_nullable_to_non_nullable
as String?,averageVisitMinutes: freezed == averageVisitMinutes ? _self.averageVisitMinutes : averageVisitMinutes // ignore: cast_nullable_to_non_nullable
as int?,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,directionsUrl: freezed == directionsUrl ? _self.directionsUrl : directionsUrl // ignore: cast_nullable_to_non_nullable
as String?,nearby: null == nearby ? _self.nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceDetail].
extension PlaceDetailPatterns on PlaceDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDetail value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? nameEn,  String slug,  String categoryKey,  String categoryName,  String? categoryIcon,  String? description,  String? photoUrl,  String? photoThumbUrl,  String? photoLargeUrl,  String? photoAttribution,  String? photoSource,  double latitude,  double longitude,  String? cityName,  String? citySlug,  String? districtName,  String? address,  String? website,  String? openingHours,  String? wikipediaUrl,  int? averageVisitMinutes,  int qualityScore,  String? directionsUrl,  List<NearbyPlace> nearby)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDetail() when $default != null:
return $default(_that.id,_that.name,_that.nameEn,_that.slug,_that.categoryKey,_that.categoryName,_that.categoryIcon,_that.description,_that.photoUrl,_that.photoThumbUrl,_that.photoLargeUrl,_that.photoAttribution,_that.photoSource,_that.latitude,_that.longitude,_that.cityName,_that.citySlug,_that.districtName,_that.address,_that.website,_that.openingHours,_that.wikipediaUrl,_that.averageVisitMinutes,_that.qualityScore,_that.directionsUrl,_that.nearby);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? nameEn,  String slug,  String categoryKey,  String categoryName,  String? categoryIcon,  String? description,  String? photoUrl,  String? photoThumbUrl,  String? photoLargeUrl,  String? photoAttribution,  String? photoSource,  double latitude,  double longitude,  String? cityName,  String? citySlug,  String? districtName,  String? address,  String? website,  String? openingHours,  String? wikipediaUrl,  int? averageVisitMinutes,  int qualityScore,  String? directionsUrl,  List<NearbyPlace> nearby)  $default,) {final _that = this;
switch (_that) {
case _PlaceDetail():
return $default(_that.id,_that.name,_that.nameEn,_that.slug,_that.categoryKey,_that.categoryName,_that.categoryIcon,_that.description,_that.photoUrl,_that.photoThumbUrl,_that.photoLargeUrl,_that.photoAttribution,_that.photoSource,_that.latitude,_that.longitude,_that.cityName,_that.citySlug,_that.districtName,_that.address,_that.website,_that.openingHours,_that.wikipediaUrl,_that.averageVisitMinutes,_that.qualityScore,_that.directionsUrl,_that.nearby);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? nameEn,  String slug,  String categoryKey,  String categoryName,  String? categoryIcon,  String? description,  String? photoUrl,  String? photoThumbUrl,  String? photoLargeUrl,  String? photoAttribution,  String? photoSource,  double latitude,  double longitude,  String? cityName,  String? citySlug,  String? districtName,  String? address,  String? website,  String? openingHours,  String? wikipediaUrl,  int? averageVisitMinutes,  int qualityScore,  String? directionsUrl,  List<NearbyPlace> nearby)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDetail() when $default != null:
return $default(_that.id,_that.name,_that.nameEn,_that.slug,_that.categoryKey,_that.categoryName,_that.categoryIcon,_that.description,_that.photoUrl,_that.photoThumbUrl,_that.photoLargeUrl,_that.photoAttribution,_that.photoSource,_that.latitude,_that.longitude,_that.cityName,_that.citySlug,_that.districtName,_that.address,_that.website,_that.openingHours,_that.wikipediaUrl,_that.averageVisitMinutes,_that.qualityScore,_that.directionsUrl,_that.nearby);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDetail extends PlaceDetail {
  const _PlaceDetail({required this.id, required this.name, this.nameEn, required this.slug, required this.categoryKey, required this.categoryName, this.categoryIcon, this.description, this.photoUrl, this.photoThumbUrl, this.photoLargeUrl, this.photoAttribution, this.photoSource, required this.latitude, required this.longitude, this.cityName, this.citySlug, this.districtName, this.address, this.website, this.openingHours, this.wikipediaUrl, this.averageVisitMinutes, required this.qualityScore, this.directionsUrl, final  List<NearbyPlace> nearby = const <NearbyPlace>[]}): _nearby = nearby,super._();
  factory _PlaceDetail.fromJson(Map<String, dynamic> json) => _$PlaceDetailFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? nameEn;
@override final  String slug;
@override final  String categoryKey;
@override final  String categoryName;
@override final  String? categoryIcon;
@override final  String? description;
/// Fotoğrafsız yerlerde **null**.
///
/// Harita fotoğrafsız yerleri de gösteriyor (kullanıcıdan fotoğraf
/// istemenin yeri orası), yani detay ekranı bu durumu karşılamak zorunda.
/// Eskiden zorunluydu ve haritadan fotoğrafsız bir yere dokunmak
/// "type 'Null' is not a subtype of type 'String'" ile çöküyordu.
@override final  String? photoUrl;
@override final  String? photoThumbUrl;
@override final  String? photoLargeUrl;
/// Fotoğrafın yanında gösterilmesi zorunlu atıf. Fotoğraf yoksa null;
/// **atıf yoksa fotoğraf gösterilemez** (bkz. [PlaceImage.canDisplay]).
@override final  String? photoAttribution;
@override final  String? photoSource;
@override final  double latitude;
@override final  double longitude;
@override final  String? cityName;
@override final  String? citySlug;
@override final  String? districtName;
@override final  String? address;
@override final  String? website;
@override final  String? openingHours;
@override final  String? wikipediaUrl;
@override final  int? averageVisitMinutes;
@override final  int qualityScore;
/// Harita uygulamasında yol tarifi açar.
@override final  String? directionsUrl;
 final  List<NearbyPlace> _nearby;
@override@JsonKey() List<NearbyPlace> get nearby {
  if (_nearby is EqualUnmodifiableListView) return _nearby;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearby);
}


/// Create a copy of PlaceDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDetailCopyWith<_PlaceDetail> get copyWith => __$PlaceDetailCopyWithImpl<_PlaceDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.photoThumbUrl, photoThumbUrl) || other.photoThumbUrl == photoThumbUrl)&&(identical(other.photoLargeUrl, photoLargeUrl) || other.photoLargeUrl == photoLargeUrl)&&(identical(other.photoAttribution, photoAttribution) || other.photoAttribution == photoAttribution)&&(identical(other.photoSource, photoSource) || other.photoSource == photoSource)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.citySlug, citySlug) || other.citySlug == citySlug)&&(identical(other.districtName, districtName) || other.districtName == districtName)&&(identical(other.address, address) || other.address == address)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.wikipediaUrl, wikipediaUrl) || other.wikipediaUrl == wikipediaUrl)&&(identical(other.averageVisitMinutes, averageVisitMinutes) || other.averageVisitMinutes == averageVisitMinutes)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&(identical(other.directionsUrl, directionsUrl) || other.directionsUrl == directionsUrl)&&const DeepCollectionEquality().equals(other._nearby, _nearby));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,nameEn,slug,categoryKey,categoryName,categoryIcon,description,photoUrl,photoThumbUrl,photoLargeUrl,photoAttribution,photoSource,latitude,longitude,cityName,citySlug,districtName,address,website,openingHours,wikipediaUrl,averageVisitMinutes,qualityScore,directionsUrl,const DeepCollectionEquality().hash(_nearby)]);

@override
String toString() {
  return 'PlaceDetail(id: $id, name: $name, nameEn: $nameEn, slug: $slug, categoryKey: $categoryKey, categoryName: $categoryName, categoryIcon: $categoryIcon, description: $description, photoUrl: $photoUrl, photoThumbUrl: $photoThumbUrl, photoLargeUrl: $photoLargeUrl, photoAttribution: $photoAttribution, photoSource: $photoSource, latitude: $latitude, longitude: $longitude, cityName: $cityName, citySlug: $citySlug, districtName: $districtName, address: $address, website: $website, openingHours: $openingHours, wikipediaUrl: $wikipediaUrl, averageVisitMinutes: $averageVisitMinutes, qualityScore: $qualityScore, directionsUrl: $directionsUrl, nearby: $nearby)';
}


}

/// @nodoc
abstract mixin class _$PlaceDetailCopyWith<$Res> implements $PlaceDetailCopyWith<$Res> {
  factory _$PlaceDetailCopyWith(_PlaceDetail value, $Res Function(_PlaceDetail) _then) = __$PlaceDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? nameEn, String slug, String categoryKey, String categoryName, String? categoryIcon, String? description, String? photoUrl, String? photoThumbUrl, String? photoLargeUrl, String? photoAttribution, String? photoSource, double latitude, double longitude, String? cityName, String? citySlug, String? districtName, String? address, String? website, String? openingHours, String? wikipediaUrl, int? averageVisitMinutes, int qualityScore, String? directionsUrl, List<NearbyPlace> nearby
});




}
/// @nodoc
class __$PlaceDetailCopyWithImpl<$Res>
    implements _$PlaceDetailCopyWith<$Res> {
  __$PlaceDetailCopyWithImpl(this._self, this._then);

  final _PlaceDetail _self;
  final $Res Function(_PlaceDetail) _then;

/// Create a copy of PlaceDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? nameEn = freezed,Object? slug = null,Object? categoryKey = null,Object? categoryName = null,Object? categoryIcon = freezed,Object? description = freezed,Object? photoUrl = freezed,Object? photoThumbUrl = freezed,Object? photoLargeUrl = freezed,Object? photoAttribution = freezed,Object? photoSource = freezed,Object? latitude = null,Object? longitude = null,Object? cityName = freezed,Object? citySlug = freezed,Object? districtName = freezed,Object? address = freezed,Object? website = freezed,Object? openingHours = freezed,Object? wikipediaUrl = freezed,Object? averageVisitMinutes = freezed,Object? qualityScore = null,Object? directionsUrl = freezed,Object? nearby = null,}) {
  return _then(_PlaceDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoThumbUrl: freezed == photoThumbUrl ? _self.photoThumbUrl : photoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,photoLargeUrl: freezed == photoLargeUrl ? _self.photoLargeUrl : photoLargeUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAttribution: freezed == photoAttribution ? _self.photoAttribution : photoAttribution // ignore: cast_nullable_to_non_nullable
as String?,photoSource: freezed == photoSource ? _self.photoSource : photoSource // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,citySlug: freezed == citySlug ? _self.citySlug : citySlug // ignore: cast_nullable_to_non_nullable
as String?,districtName: freezed == districtName ? _self.districtName : districtName // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,wikipediaUrl: freezed == wikipediaUrl ? _self.wikipediaUrl : wikipediaUrl // ignore: cast_nullable_to_non_nullable
as String?,averageVisitMinutes: freezed == averageVisitMinutes ? _self.averageVisitMinutes : averageVisitMinutes // ignore: cast_nullable_to_non_nullable
as int?,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,directionsUrl: freezed == directionsUrl ? _self.directionsUrl : directionsUrl // ignore: cast_nullable_to_non_nullable
as String?,nearby: null == nearby ? _self._nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,
  ));
}


}


/// @nodoc
mixin _$NearbyPlace {

 int get id; String get name; String get slug; String? get categoryName; String? get photoUrl; String? get photoThumbUrl;/// Görselin yanında gösterilmesi zorunlu atıf satırı (CC BY-SA).
 String? get photoAttribution; int get distanceMeters;
/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyPlaceCopyWith<NearbyPlace> get copyWith => _$NearbyPlaceCopyWithImpl<NearbyPlace>(this as NearbyPlace, _$identity);

  /// Serializes this NearbyPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.photoThumbUrl, photoThumbUrl) || other.photoThumbUrl == photoThumbUrl)&&(identical(other.photoAttribution, photoAttribution) || other.photoAttribution == photoAttribution)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,categoryName,photoUrl,photoThumbUrl,photoAttribution,distanceMeters);

@override
String toString() {
  return 'NearbyPlace(id: $id, name: $name, slug: $slug, categoryName: $categoryName, photoUrl: $photoUrl, photoThumbUrl: $photoThumbUrl, photoAttribution: $photoAttribution, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class $NearbyPlaceCopyWith<$Res>  {
  factory $NearbyPlaceCopyWith(NearbyPlace value, $Res Function(NearbyPlace) _then) = _$NearbyPlaceCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String? categoryName, String? photoUrl, String? photoThumbUrl, String? photoAttribution, int distanceMeters
});




}
/// @nodoc
class _$NearbyPlaceCopyWithImpl<$Res>
    implements $NearbyPlaceCopyWith<$Res> {
  _$NearbyPlaceCopyWithImpl(this._self, this._then);

  final NearbyPlace _self;
  final $Res Function(NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? categoryName = freezed,Object? photoUrl = freezed,Object? photoThumbUrl = freezed,Object? photoAttribution = freezed,Object? distanceMeters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoThumbUrl: freezed == photoThumbUrl ? _self.photoThumbUrl : photoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAttribution: freezed == photoAttribution ? _self.photoAttribution : photoAttribution // ignore: cast_nullable_to_non_nullable
as String?,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbyPlace].
extension NearbyPlacePatterns on NearbyPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyPlace value)  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyPlace value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? categoryName,  String? photoUrl,  String? photoThumbUrl,  String? photoAttribution,  int distanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.categoryName,_that.photoUrl,_that.photoThumbUrl,_that.photoAttribution,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? categoryName,  String? photoUrl,  String? photoThumbUrl,  String? photoAttribution,  int distanceMeters)  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace():
return $default(_that.id,_that.name,_that.slug,_that.categoryName,_that.photoUrl,_that.photoThumbUrl,_that.photoAttribution,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String? categoryName,  String? photoUrl,  String? photoThumbUrl,  String? photoAttribution,  int distanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.categoryName,_that.photoUrl,_that.photoThumbUrl,_that.photoAttribution,_that.distanceMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyPlace extends NearbyPlace {
  const _NearbyPlace({required this.id, required this.name, required this.slug, this.categoryName, this.photoUrl, this.photoThumbUrl, this.photoAttribution, required this.distanceMeters}): super._();
  factory _NearbyPlace.fromJson(Map<String, dynamic> json) => _$NearbyPlaceFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  String? categoryName;
@override final  String? photoUrl;
@override final  String? photoThumbUrl;
/// Görselin yanında gösterilmesi zorunlu atıf satırı (CC BY-SA).
@override final  String? photoAttribution;
@override final  int distanceMeters;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyPlaceCopyWith<_NearbyPlace> get copyWith => __$NearbyPlaceCopyWithImpl<_NearbyPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.photoThumbUrl, photoThumbUrl) || other.photoThumbUrl == photoThumbUrl)&&(identical(other.photoAttribution, photoAttribution) || other.photoAttribution == photoAttribution)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,categoryName,photoUrl,photoThumbUrl,photoAttribution,distanceMeters);

@override
String toString() {
  return 'NearbyPlace(id: $id, name: $name, slug: $slug, categoryName: $categoryName, photoUrl: $photoUrl, photoThumbUrl: $photoThumbUrl, photoAttribution: $photoAttribution, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class _$NearbyPlaceCopyWith<$Res> implements $NearbyPlaceCopyWith<$Res> {
  factory _$NearbyPlaceCopyWith(_NearbyPlace value, $Res Function(_NearbyPlace) _then) = __$NearbyPlaceCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String? categoryName, String? photoUrl, String? photoThumbUrl, String? photoAttribution, int distanceMeters
});




}
/// @nodoc
class __$NearbyPlaceCopyWithImpl<$Res>
    implements _$NearbyPlaceCopyWith<$Res> {
  __$NearbyPlaceCopyWithImpl(this._self, this._then);

  final _NearbyPlace _self;
  final $Res Function(_NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? categoryName = freezed,Object? photoUrl = freezed,Object? photoThumbUrl = freezed,Object? photoAttribution = freezed,Object? distanceMeters = null,}) {
  return _then(_NearbyPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoThumbUrl: freezed == photoThumbUrl ? _self.photoThumbUrl : photoThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAttribution: freezed == photoAttribution ? _self.photoAttribution : photoAttribution // ignore: cast_nullable_to_non_nullable
as String?,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
