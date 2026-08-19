// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RewardRules {

 int get coinsPerApprovedPhoto; int get coinsForOneMonth; int get coinsForTwoMonths; int get coinsForUnlimited; int get freeMonthlyTripLimit;
/// Create a copy of RewardRules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardRulesCopyWith<RewardRules> get copyWith => _$RewardRulesCopyWithImpl<RewardRules>(this as RewardRules, _$identity);

  /// Serializes this RewardRules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardRules&&(identical(other.coinsPerApprovedPhoto, coinsPerApprovedPhoto) || other.coinsPerApprovedPhoto == coinsPerApprovedPhoto)&&(identical(other.coinsForOneMonth, coinsForOneMonth) || other.coinsForOneMonth == coinsForOneMonth)&&(identical(other.coinsForTwoMonths, coinsForTwoMonths) || other.coinsForTwoMonths == coinsForTwoMonths)&&(identical(other.coinsForUnlimited, coinsForUnlimited) || other.coinsForUnlimited == coinsForUnlimited)&&(identical(other.freeMonthlyTripLimit, freeMonthlyTripLimit) || other.freeMonthlyTripLimit == freeMonthlyTripLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coinsPerApprovedPhoto,coinsForOneMonth,coinsForTwoMonths,coinsForUnlimited,freeMonthlyTripLimit);

@override
String toString() {
  return 'RewardRules(coinsPerApprovedPhoto: $coinsPerApprovedPhoto, coinsForOneMonth: $coinsForOneMonth, coinsForTwoMonths: $coinsForTwoMonths, coinsForUnlimited: $coinsForUnlimited, freeMonthlyTripLimit: $freeMonthlyTripLimit)';
}


}

/// @nodoc
abstract mixin class $RewardRulesCopyWith<$Res>  {
  factory $RewardRulesCopyWith(RewardRules value, $Res Function(RewardRules) _then) = _$RewardRulesCopyWithImpl;
@useResult
$Res call({
 int coinsPerApprovedPhoto, int coinsForOneMonth, int coinsForTwoMonths, int coinsForUnlimited, int freeMonthlyTripLimit
});




}
/// @nodoc
class _$RewardRulesCopyWithImpl<$Res>
    implements $RewardRulesCopyWith<$Res> {
  _$RewardRulesCopyWithImpl(this._self, this._then);

  final RewardRules _self;
  final $Res Function(RewardRules) _then;

/// Create a copy of RewardRules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coinsPerApprovedPhoto = null,Object? coinsForOneMonth = null,Object? coinsForTwoMonths = null,Object? coinsForUnlimited = null,Object? freeMonthlyTripLimit = null,}) {
  return _then(_self.copyWith(
coinsPerApprovedPhoto: null == coinsPerApprovedPhoto ? _self.coinsPerApprovedPhoto : coinsPerApprovedPhoto // ignore: cast_nullable_to_non_nullable
as int,coinsForOneMonth: null == coinsForOneMonth ? _self.coinsForOneMonth : coinsForOneMonth // ignore: cast_nullable_to_non_nullable
as int,coinsForTwoMonths: null == coinsForTwoMonths ? _self.coinsForTwoMonths : coinsForTwoMonths // ignore: cast_nullable_to_non_nullable
as int,coinsForUnlimited: null == coinsForUnlimited ? _self.coinsForUnlimited : coinsForUnlimited // ignore: cast_nullable_to_non_nullable
as int,freeMonthlyTripLimit: null == freeMonthlyTripLimit ? _self.freeMonthlyTripLimit : freeMonthlyTripLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardRules].
extension RewardRulesPatterns on RewardRules {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardRules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardRules() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardRules value)  $default,){
final _that = this;
switch (_that) {
case _RewardRules():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardRules value)?  $default,){
final _that = this;
switch (_that) {
case _RewardRules() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int coinsPerApprovedPhoto,  int coinsForOneMonth,  int coinsForTwoMonths,  int coinsForUnlimited,  int freeMonthlyTripLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardRules() when $default != null:
return $default(_that.coinsPerApprovedPhoto,_that.coinsForOneMonth,_that.coinsForTwoMonths,_that.coinsForUnlimited,_that.freeMonthlyTripLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int coinsPerApprovedPhoto,  int coinsForOneMonth,  int coinsForTwoMonths,  int coinsForUnlimited,  int freeMonthlyTripLimit)  $default,) {final _that = this;
switch (_that) {
case _RewardRules():
return $default(_that.coinsPerApprovedPhoto,_that.coinsForOneMonth,_that.coinsForTwoMonths,_that.coinsForUnlimited,_that.freeMonthlyTripLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int coinsPerApprovedPhoto,  int coinsForOneMonth,  int coinsForTwoMonths,  int coinsForUnlimited,  int freeMonthlyTripLimit)?  $default,) {final _that = this;
switch (_that) {
case _RewardRules() when $default != null:
return $default(_that.coinsPerApprovedPhoto,_that.coinsForOneMonth,_that.coinsForTwoMonths,_that.coinsForUnlimited,_that.freeMonthlyTripLimit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardRules implements RewardRules {
  const _RewardRules({required this.coinsPerApprovedPhoto, required this.coinsForOneMonth, required this.coinsForTwoMonths, required this.coinsForUnlimited, required this.freeMonthlyTripLimit});
  factory _RewardRules.fromJson(Map<String, dynamic> json) => _$RewardRulesFromJson(json);

@override final  int coinsPerApprovedPhoto;
@override final  int coinsForOneMonth;
@override final  int coinsForTwoMonths;
@override final  int coinsForUnlimited;
@override final  int freeMonthlyTripLimit;

/// Create a copy of RewardRules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardRulesCopyWith<_RewardRules> get copyWith => __$RewardRulesCopyWithImpl<_RewardRules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardRulesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardRules&&(identical(other.coinsPerApprovedPhoto, coinsPerApprovedPhoto) || other.coinsPerApprovedPhoto == coinsPerApprovedPhoto)&&(identical(other.coinsForOneMonth, coinsForOneMonth) || other.coinsForOneMonth == coinsForOneMonth)&&(identical(other.coinsForTwoMonths, coinsForTwoMonths) || other.coinsForTwoMonths == coinsForTwoMonths)&&(identical(other.coinsForUnlimited, coinsForUnlimited) || other.coinsForUnlimited == coinsForUnlimited)&&(identical(other.freeMonthlyTripLimit, freeMonthlyTripLimit) || other.freeMonthlyTripLimit == freeMonthlyTripLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coinsPerApprovedPhoto,coinsForOneMonth,coinsForTwoMonths,coinsForUnlimited,freeMonthlyTripLimit);

@override
String toString() {
  return 'RewardRules(coinsPerApprovedPhoto: $coinsPerApprovedPhoto, coinsForOneMonth: $coinsForOneMonth, coinsForTwoMonths: $coinsForTwoMonths, coinsForUnlimited: $coinsForUnlimited, freeMonthlyTripLimit: $freeMonthlyTripLimit)';
}


}

/// @nodoc
abstract mixin class _$RewardRulesCopyWith<$Res> implements $RewardRulesCopyWith<$Res> {
  factory _$RewardRulesCopyWith(_RewardRules value, $Res Function(_RewardRules) _then) = __$RewardRulesCopyWithImpl;
@override @useResult
$Res call({
 int coinsPerApprovedPhoto, int coinsForOneMonth, int coinsForTwoMonths, int coinsForUnlimited, int freeMonthlyTripLimit
});




}
/// @nodoc
class __$RewardRulesCopyWithImpl<$Res>
    implements _$RewardRulesCopyWith<$Res> {
  __$RewardRulesCopyWithImpl(this._self, this._then);

  final _RewardRules _self;
  final $Res Function(_RewardRules) _then;

/// Create a copy of RewardRules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coinsPerApprovedPhoto = null,Object? coinsForOneMonth = null,Object? coinsForTwoMonths = null,Object? coinsForUnlimited = null,Object? freeMonthlyTripLimit = null,}) {
  return _then(_RewardRules(
coinsPerApprovedPhoto: null == coinsPerApprovedPhoto ? _self.coinsPerApprovedPhoto : coinsPerApprovedPhoto // ignore: cast_nullable_to_non_nullable
as int,coinsForOneMonth: null == coinsForOneMonth ? _self.coinsForOneMonth : coinsForOneMonth // ignore: cast_nullable_to_non_nullable
as int,coinsForTwoMonths: null == coinsForTwoMonths ? _self.coinsForTwoMonths : coinsForTwoMonths // ignore: cast_nullable_to_non_nullable
as int,coinsForUnlimited: null == coinsForUnlimited ? _self.coinsForUnlimited : coinsForUnlimited // ignore: cast_nullable_to_non_nullable
as int,freeMonthlyTripLimit: null == freeMonthlyTripLimit ? _self.freeMonthlyTripLimit : freeMonthlyTripLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RewardStatus {

 int get coinBalance; int get pendingSubmissions; int get approvedSubmissions; int get rejectedSubmissions; bool get isPremium; DateTime? get premiumExpiresAt; bool get isPremiumUnlimited; int get tripsThisMonth;/// Ücretsiz hesabın aylık plan kotası. Premium'da **null** — sınırsız.
 int? get monthlyTripLimit;
/// Create a copy of RewardStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardStatusCopyWith<RewardStatus> get copyWith => _$RewardStatusCopyWithImpl<RewardStatus>(this as RewardStatus, _$identity);

  /// Serializes this RewardStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardStatus&&(identical(other.coinBalance, coinBalance) || other.coinBalance == coinBalance)&&(identical(other.pendingSubmissions, pendingSubmissions) || other.pendingSubmissions == pendingSubmissions)&&(identical(other.approvedSubmissions, approvedSubmissions) || other.approvedSubmissions == approvedSubmissions)&&(identical(other.rejectedSubmissions, rejectedSubmissions) || other.rejectedSubmissions == rejectedSubmissions)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.premiumExpiresAt, premiumExpiresAt) || other.premiumExpiresAt == premiumExpiresAt)&&(identical(other.isPremiumUnlimited, isPremiumUnlimited) || other.isPremiumUnlimited == isPremiumUnlimited)&&(identical(other.tripsThisMonth, tripsThisMonth) || other.tripsThisMonth == tripsThisMonth)&&(identical(other.monthlyTripLimit, monthlyTripLimit) || other.monthlyTripLimit == monthlyTripLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coinBalance,pendingSubmissions,approvedSubmissions,rejectedSubmissions,isPremium,premiumExpiresAt,isPremiumUnlimited,tripsThisMonth,monthlyTripLimit);

@override
String toString() {
  return 'RewardStatus(coinBalance: $coinBalance, pendingSubmissions: $pendingSubmissions, approvedSubmissions: $approvedSubmissions, rejectedSubmissions: $rejectedSubmissions, isPremium: $isPremium, premiumExpiresAt: $premiumExpiresAt, isPremiumUnlimited: $isPremiumUnlimited, tripsThisMonth: $tripsThisMonth, monthlyTripLimit: $monthlyTripLimit)';
}


}

/// @nodoc
abstract mixin class $RewardStatusCopyWith<$Res>  {
  factory $RewardStatusCopyWith(RewardStatus value, $Res Function(RewardStatus) _then) = _$RewardStatusCopyWithImpl;
@useResult
$Res call({
 int coinBalance, int pendingSubmissions, int approvedSubmissions, int rejectedSubmissions, bool isPremium, DateTime? premiumExpiresAt, bool isPremiumUnlimited, int tripsThisMonth, int? monthlyTripLimit
});




}
/// @nodoc
class _$RewardStatusCopyWithImpl<$Res>
    implements $RewardStatusCopyWith<$Res> {
  _$RewardStatusCopyWithImpl(this._self, this._then);

  final RewardStatus _self;
  final $Res Function(RewardStatus) _then;

/// Create a copy of RewardStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coinBalance = null,Object? pendingSubmissions = null,Object? approvedSubmissions = null,Object? rejectedSubmissions = null,Object? isPremium = null,Object? premiumExpiresAt = freezed,Object? isPremiumUnlimited = null,Object? tripsThisMonth = null,Object? monthlyTripLimit = freezed,}) {
  return _then(_self.copyWith(
coinBalance: null == coinBalance ? _self.coinBalance : coinBalance // ignore: cast_nullable_to_non_nullable
as int,pendingSubmissions: null == pendingSubmissions ? _self.pendingSubmissions : pendingSubmissions // ignore: cast_nullable_to_non_nullable
as int,approvedSubmissions: null == approvedSubmissions ? _self.approvedSubmissions : approvedSubmissions // ignore: cast_nullable_to_non_nullable
as int,rejectedSubmissions: null == rejectedSubmissions ? _self.rejectedSubmissions : rejectedSubmissions // ignore: cast_nullable_to_non_nullable
as int,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,premiumExpiresAt: freezed == premiumExpiresAt ? _self.premiumExpiresAt : premiumExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPremiumUnlimited: null == isPremiumUnlimited ? _self.isPremiumUnlimited : isPremiumUnlimited // ignore: cast_nullable_to_non_nullable
as bool,tripsThisMonth: null == tripsThisMonth ? _self.tripsThisMonth : tripsThisMonth // ignore: cast_nullable_to_non_nullable
as int,monthlyTripLimit: freezed == monthlyTripLimit ? _self.monthlyTripLimit : monthlyTripLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardStatus].
extension RewardStatusPatterns on RewardStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardStatus value)  $default,){
final _that = this;
switch (_that) {
case _RewardStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardStatus value)?  $default,){
final _that = this;
switch (_that) {
case _RewardStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int coinBalance,  int pendingSubmissions,  int approvedSubmissions,  int rejectedSubmissions,  bool isPremium,  DateTime? premiumExpiresAt,  bool isPremiumUnlimited,  int tripsThisMonth,  int? monthlyTripLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardStatus() when $default != null:
return $default(_that.coinBalance,_that.pendingSubmissions,_that.approvedSubmissions,_that.rejectedSubmissions,_that.isPremium,_that.premiumExpiresAt,_that.isPremiumUnlimited,_that.tripsThisMonth,_that.monthlyTripLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int coinBalance,  int pendingSubmissions,  int approvedSubmissions,  int rejectedSubmissions,  bool isPremium,  DateTime? premiumExpiresAt,  bool isPremiumUnlimited,  int tripsThisMonth,  int? monthlyTripLimit)  $default,) {final _that = this;
switch (_that) {
case _RewardStatus():
return $default(_that.coinBalance,_that.pendingSubmissions,_that.approvedSubmissions,_that.rejectedSubmissions,_that.isPremium,_that.premiumExpiresAt,_that.isPremiumUnlimited,_that.tripsThisMonth,_that.monthlyTripLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int coinBalance,  int pendingSubmissions,  int approvedSubmissions,  int rejectedSubmissions,  bool isPremium,  DateTime? premiumExpiresAt,  bool isPremiumUnlimited,  int tripsThisMonth,  int? monthlyTripLimit)?  $default,) {final _that = this;
switch (_that) {
case _RewardStatus() when $default != null:
return $default(_that.coinBalance,_that.pendingSubmissions,_that.approvedSubmissions,_that.rejectedSubmissions,_that.isPremium,_that.premiumExpiresAt,_that.isPremiumUnlimited,_that.tripsThisMonth,_that.monthlyTripLimit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardStatus extends RewardStatus {
  const _RewardStatus({this.coinBalance = 0, this.pendingSubmissions = 0, this.approvedSubmissions = 0, this.rejectedSubmissions = 0, this.isPremium = false, this.premiumExpiresAt, this.isPremiumUnlimited = false, this.tripsThisMonth = 0, this.monthlyTripLimit}): super._();
  factory _RewardStatus.fromJson(Map<String, dynamic> json) => _$RewardStatusFromJson(json);

@override@JsonKey() final  int coinBalance;
@override@JsonKey() final  int pendingSubmissions;
@override@JsonKey() final  int approvedSubmissions;
@override@JsonKey() final  int rejectedSubmissions;
@override@JsonKey() final  bool isPremium;
@override final  DateTime? premiumExpiresAt;
@override@JsonKey() final  bool isPremiumUnlimited;
@override@JsonKey() final  int tripsThisMonth;
/// Ücretsiz hesabın aylık plan kotası. Premium'da **null** — sınırsız.
@override final  int? monthlyTripLimit;

/// Create a copy of RewardStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardStatusCopyWith<_RewardStatus> get copyWith => __$RewardStatusCopyWithImpl<_RewardStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardStatus&&(identical(other.coinBalance, coinBalance) || other.coinBalance == coinBalance)&&(identical(other.pendingSubmissions, pendingSubmissions) || other.pendingSubmissions == pendingSubmissions)&&(identical(other.approvedSubmissions, approvedSubmissions) || other.approvedSubmissions == approvedSubmissions)&&(identical(other.rejectedSubmissions, rejectedSubmissions) || other.rejectedSubmissions == rejectedSubmissions)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.premiumExpiresAt, premiumExpiresAt) || other.premiumExpiresAt == premiumExpiresAt)&&(identical(other.isPremiumUnlimited, isPremiumUnlimited) || other.isPremiumUnlimited == isPremiumUnlimited)&&(identical(other.tripsThisMonth, tripsThisMonth) || other.tripsThisMonth == tripsThisMonth)&&(identical(other.monthlyTripLimit, monthlyTripLimit) || other.monthlyTripLimit == monthlyTripLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coinBalance,pendingSubmissions,approvedSubmissions,rejectedSubmissions,isPremium,premiumExpiresAt,isPremiumUnlimited,tripsThisMonth,monthlyTripLimit);

@override
String toString() {
  return 'RewardStatus(coinBalance: $coinBalance, pendingSubmissions: $pendingSubmissions, approvedSubmissions: $approvedSubmissions, rejectedSubmissions: $rejectedSubmissions, isPremium: $isPremium, premiumExpiresAt: $premiumExpiresAt, isPremiumUnlimited: $isPremiumUnlimited, tripsThisMonth: $tripsThisMonth, monthlyTripLimit: $monthlyTripLimit)';
}


}

/// @nodoc
abstract mixin class _$RewardStatusCopyWith<$Res> implements $RewardStatusCopyWith<$Res> {
  factory _$RewardStatusCopyWith(_RewardStatus value, $Res Function(_RewardStatus) _then) = __$RewardStatusCopyWithImpl;
@override @useResult
$Res call({
 int coinBalance, int pendingSubmissions, int approvedSubmissions, int rejectedSubmissions, bool isPremium, DateTime? premiumExpiresAt, bool isPremiumUnlimited, int tripsThisMonth, int? monthlyTripLimit
});




}
/// @nodoc
class __$RewardStatusCopyWithImpl<$Res>
    implements _$RewardStatusCopyWith<$Res> {
  __$RewardStatusCopyWithImpl(this._self, this._then);

  final _RewardStatus _self;
  final $Res Function(_RewardStatus) _then;

/// Create a copy of RewardStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coinBalance = null,Object? pendingSubmissions = null,Object? approvedSubmissions = null,Object? rejectedSubmissions = null,Object? isPremium = null,Object? premiumExpiresAt = freezed,Object? isPremiumUnlimited = null,Object? tripsThisMonth = null,Object? monthlyTripLimit = freezed,}) {
  return _then(_RewardStatus(
coinBalance: null == coinBalance ? _self.coinBalance : coinBalance // ignore: cast_nullable_to_non_nullable
as int,pendingSubmissions: null == pendingSubmissions ? _self.pendingSubmissions : pendingSubmissions // ignore: cast_nullable_to_non_nullable
as int,approvedSubmissions: null == approvedSubmissions ? _self.approvedSubmissions : approvedSubmissions // ignore: cast_nullable_to_non_nullable
as int,rejectedSubmissions: null == rejectedSubmissions ? _self.rejectedSubmissions : rejectedSubmissions // ignore: cast_nullable_to_non_nullable
as int,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,premiumExpiresAt: freezed == premiumExpiresAt ? _self.premiumExpiresAt : premiumExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPremiumUnlimited: null == isPremiumUnlimited ? _self.isPremiumUnlimited : isPremiumUnlimited // ignore: cast_nullable_to_non_nullable
as bool,tripsThisMonth: null == tripsThisMonth ? _self.tripsThisMonth : tripsThisMonth // ignore: cast_nullable_to_non_nullable
as int,monthlyTripLimit: freezed == monthlyTripLimit ? _self.monthlyTripLimit : monthlyTripLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PhotoSubmission {

 int get id; int get placeId; String get placeName;/// "Pending" · "Approved" · "Rejected"
 String get status; String get url; String? get rejectionReason; int? get coinsAwarded; DateTime get createdAt; DateTime? get reviewedAt;
/// Create a copy of PhotoSubmission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoSubmissionCopyWith<PhotoSubmission> get copyWith => _$PhotoSubmissionCopyWithImpl<PhotoSubmission>(this as PhotoSubmission, _$identity);

  /// Serializes this PhotoSubmission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoSubmission&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.status, status) || other.status == status)&&(identical(other.url, url) || other.url == url)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.coinsAwarded, coinsAwarded) || other.coinsAwarded == coinsAwarded)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,placeName,status,url,rejectionReason,coinsAwarded,createdAt,reviewedAt);

@override
String toString() {
  return 'PhotoSubmission(id: $id, placeId: $placeId, placeName: $placeName, status: $status, url: $url, rejectionReason: $rejectionReason, coinsAwarded: $coinsAwarded, createdAt: $createdAt, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class $PhotoSubmissionCopyWith<$Res>  {
  factory $PhotoSubmissionCopyWith(PhotoSubmission value, $Res Function(PhotoSubmission) _then) = _$PhotoSubmissionCopyWithImpl;
@useResult
$Res call({
 int id, int placeId, String placeName, String status, String url, String? rejectionReason, int? coinsAwarded, DateTime createdAt, DateTime? reviewedAt
});




}
/// @nodoc
class _$PhotoSubmissionCopyWithImpl<$Res>
    implements $PhotoSubmissionCopyWith<$Res> {
  _$PhotoSubmissionCopyWithImpl(this._self, this._then);

  final PhotoSubmission _self;
  final $Res Function(PhotoSubmission) _then;

/// Create a copy of PhotoSubmission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? placeName = null,Object? status = null,Object? url = null,Object? rejectionReason = freezed,Object? coinsAwarded = freezed,Object? createdAt = null,Object? reviewedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,coinsAwarded: freezed == coinsAwarded ? _self.coinsAwarded : coinsAwarded // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoSubmission].
extension PhotoSubmissionPatterns on PhotoSubmission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoSubmission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoSubmission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoSubmission value)  $default,){
final _that = this;
switch (_that) {
case _PhotoSubmission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoSubmission value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoSubmission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int placeId,  String placeName,  String status,  String url,  String? rejectionReason,  int? coinsAwarded,  DateTime createdAt,  DateTime? reviewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoSubmission() when $default != null:
return $default(_that.id,_that.placeId,_that.placeName,_that.status,_that.url,_that.rejectionReason,_that.coinsAwarded,_that.createdAt,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int placeId,  String placeName,  String status,  String url,  String? rejectionReason,  int? coinsAwarded,  DateTime createdAt,  DateTime? reviewedAt)  $default,) {final _that = this;
switch (_that) {
case _PhotoSubmission():
return $default(_that.id,_that.placeId,_that.placeName,_that.status,_that.url,_that.rejectionReason,_that.coinsAwarded,_that.createdAt,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int placeId,  String placeName,  String status,  String url,  String? rejectionReason,  int? coinsAwarded,  DateTime createdAt,  DateTime? reviewedAt)?  $default,) {final _that = this;
switch (_that) {
case _PhotoSubmission() when $default != null:
return $default(_that.id,_that.placeId,_that.placeName,_that.status,_that.url,_that.rejectionReason,_that.coinsAwarded,_that.createdAt,_that.reviewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoSubmission extends PhotoSubmission {
  const _PhotoSubmission({required this.id, required this.placeId, required this.placeName, required this.status, required this.url, this.rejectionReason, this.coinsAwarded, required this.createdAt, this.reviewedAt}): super._();
  factory _PhotoSubmission.fromJson(Map<String, dynamic> json) => _$PhotoSubmissionFromJson(json);

@override final  int id;
@override final  int placeId;
@override final  String placeName;
/// "Pending" · "Approved" · "Rejected"
@override final  String status;
@override final  String url;
@override final  String? rejectionReason;
@override final  int? coinsAwarded;
@override final  DateTime createdAt;
@override final  DateTime? reviewedAt;

/// Create a copy of PhotoSubmission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoSubmissionCopyWith<_PhotoSubmission> get copyWith => __$PhotoSubmissionCopyWithImpl<_PhotoSubmission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoSubmissionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoSubmission&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.status, status) || other.status == status)&&(identical(other.url, url) || other.url == url)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.coinsAwarded, coinsAwarded) || other.coinsAwarded == coinsAwarded)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,placeName,status,url,rejectionReason,coinsAwarded,createdAt,reviewedAt);

@override
String toString() {
  return 'PhotoSubmission(id: $id, placeId: $placeId, placeName: $placeName, status: $status, url: $url, rejectionReason: $rejectionReason, coinsAwarded: $coinsAwarded, createdAt: $createdAt, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class _$PhotoSubmissionCopyWith<$Res> implements $PhotoSubmissionCopyWith<$Res> {
  factory _$PhotoSubmissionCopyWith(_PhotoSubmission value, $Res Function(_PhotoSubmission) _then) = __$PhotoSubmissionCopyWithImpl;
@override @useResult
$Res call({
 int id, int placeId, String placeName, String status, String url, String? rejectionReason, int? coinsAwarded, DateTime createdAt, DateTime? reviewedAt
});




}
/// @nodoc
class __$PhotoSubmissionCopyWithImpl<$Res>
    implements _$PhotoSubmissionCopyWith<$Res> {
  __$PhotoSubmissionCopyWithImpl(this._self, this._then);

  final _PhotoSubmission _self;
  final $Res Function(_PhotoSubmission) _then;

/// Create a copy of PhotoSubmission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? placeName = null,Object? status = null,Object? url = null,Object? rejectionReason = freezed,Object? coinsAwarded = freezed,Object? createdAt = null,Object? reviewedAt = freezed,}) {
  return _then(_PhotoSubmission(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,coinsAwarded: freezed == coinsAwarded ? _self.coinsAwarded : coinsAwarded // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CoinEntry {

/// Kazanımda artı, harcamada eksi.
 int get amount;/// "PhotoApproved" · "PremiumRedeemed" · "Adjustment"
 String get reason; String? get note; DateTime get createdAt;
/// Create a copy of CoinEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinEntryCopyWith<CoinEntry> get copyWith => _$CoinEntryCopyWithImpl<CoinEntry>(this as CoinEntry, _$identity);

  /// Serializes this CoinEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinEntry&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,reason,note,createdAt);

@override
String toString() {
  return 'CoinEntry(amount: $amount, reason: $reason, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CoinEntryCopyWith<$Res>  {
  factory $CoinEntryCopyWith(CoinEntry value, $Res Function(CoinEntry) _then) = _$CoinEntryCopyWithImpl;
@useResult
$Res call({
 int amount, String reason, String? note, DateTime createdAt
});




}
/// @nodoc
class _$CoinEntryCopyWithImpl<$Res>
    implements $CoinEntryCopyWith<$Res> {
  _$CoinEntryCopyWithImpl(this._self, this._then);

  final CoinEntry _self;
  final $Res Function(CoinEntry) _then;

/// Create a copy of CoinEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? reason = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinEntry].
extension CoinEntryPatterns on CoinEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinEntry value)  $default,){
final _that = this;
switch (_that) {
case _CoinEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CoinEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  String reason,  String? note,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinEntry() when $default != null:
return $default(_that.amount,_that.reason,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  String reason,  String? note,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CoinEntry():
return $default(_that.amount,_that.reason,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  String reason,  String? note,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CoinEntry() when $default != null:
return $default(_that.amount,_that.reason,_that.note,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinEntry implements CoinEntry {
  const _CoinEntry({required this.amount, required this.reason, this.note, required this.createdAt});
  factory _CoinEntry.fromJson(Map<String, dynamic> json) => _$CoinEntryFromJson(json);

/// Kazanımda artı, harcamada eksi.
@override final  int amount;
/// "PhotoApproved" · "PremiumRedeemed" · "Adjustment"
@override final  String reason;
@override final  String? note;
@override final  DateTime createdAt;

/// Create a copy of CoinEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinEntryCopyWith<_CoinEntry> get copyWith => __$CoinEntryCopyWithImpl<_CoinEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinEntry&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,reason,note,createdAt);

@override
String toString() {
  return 'CoinEntry(amount: $amount, reason: $reason, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CoinEntryCopyWith<$Res> implements $CoinEntryCopyWith<$Res> {
  factory _$CoinEntryCopyWith(_CoinEntry value, $Res Function(_CoinEntry) _then) = __$CoinEntryCopyWithImpl;
@override @useResult
$Res call({
 int amount, String reason, String? note, DateTime createdAt
});




}
/// @nodoc
class __$CoinEntryCopyWithImpl<$Res>
    implements _$CoinEntryCopyWith<$Res> {
  __$CoinEntryCopyWithImpl(this._self, this._then);

  final _CoinEntry _self;
  final $Res Function(_CoinEntry) _then;

/// Create a copy of CoinEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? reason = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_CoinEntry(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
