import 'package:json_annotation/json_annotation.dart';

/// Sözleşmede enum'lar **metin** olarak taşınır (`"Like"`, `"Foot"`), sayı değil.
/// `@JsonValue` değerleri backend'in yazımıyla birebir aynı olmalı.

enum SwipeDirection {
  /// Sağa — plana ekle.
  @JsonValue('Like')
  like,

  /// Sola — ilgilenmiyorum.
  @JsonValue('Pass')
  pass,

  /// Aşağı — sonra bakarım.
  @JsonValue('Later')
  later;

  String get wireValue => switch (this) {
    SwipeDirection.like => 'Like',
    SwipeDirection.pass => 'Pass',
    SwipeDirection.later => 'Later',
  };
}

/// Kaydırmanın hangi modda yapıldığı. Öneri motoru bunu ayrı değerlendiriyor:
/// yol üstünde "geçilen" bir yer, şehir içinde beğenilebilir.
enum SwipeContext {
  @JsonValue('City')
  city,

  @JsonValue('Route')
  route;

  String get wireValue => this == SwipeContext.city ? 'City' : 'Route';
}

/// Gezi planının modu.
enum TripMode {
  @JsonValue('City')
  city,

  @JsonValue('Route')
  route;

  String get wireValue => this == TripMode.city ? 'City' : 'Route';
}

/// Ulaşım tipi — OSRM profilini belirler.
enum TravelMode {
  @JsonValue('Foot')
  foot,

  @JsonValue('Car')
  car;

  String get wireValue => this == TravelMode.foot ? 'Foot' : 'Car';
}
