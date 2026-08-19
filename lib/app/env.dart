import 'package:flutter/foundation.dart';

/// Ortam ayarları.
///
/// Derleme sırasında değiştirilebilir:
/// `flutter run --dart-define=YOLLA_API_BASE_URL=https://api.yolla.app/api/v1`
abstract final class Env {
  static const _override = String.fromEnvironment('YOLLA_API_BASE_URL');

  /// API kök adresi.
  ///
  /// Varsayılan geliştirme adresi platforma göre değişir: Android öykünücüsü
  /// ana makineye `localhost` ile ulaşamaz, `10.0.2.2` kullanması gerekir.
  static String get apiBaseUrl {
    if (_override.isNotEmpty) return _override;

    final host = switch (defaultTargetPlatform) {
      TargetPlatform.android when !kIsWeb => '10.0.2.2',
      _ => 'localhost',
    };
    return 'http://$host:5088/api/v1';
  }

  static const _tileOverride = String.fromEnvironment('YOLLA_TILE_BASE_URL');

  /// Harita karolarının kök adresi.
  ///
  /// Protomaps karo sunucusu (`docker compose up -d tiles`) 8080'de duruyor.
  /// Karo adresi: `<kök>/turkiye/{z}/{x}/{y}.mvt`
  ///
  /// [apiBaseUrl] ile aynı ana makine kuralına uyuyor: öykünücü `10.0.2.2`
  /// kullanmak zorunda, gerçek cihaz `adb reverse` ile `localhost`.
  static String get tileBaseUrl {
    if (_tileOverride.isNotEmpty) return _tileOverride;

    final host = switch (defaultTargetPlatform) {
      TargetPlatform.android when !kIsWeb => '10.0.2.2',
      _ => 'localhost',
    };
    return 'http://$host:8080';
  }

  /// Bu sürümün adı — `devices/register` çağrısında gönderilir.
  static const appVersion = '1.0.0';

  /// Wikimedia'ya giden görsel isteklerinin kimliği.
  ///
  /// Commons'ın kullanım politikası tanımlayıcı bir `User-Agent` şart koşuyor;
  /// Dart'ın varsayılanı (`Dart/3.x (dart:io)`) gibi genel değerler
  /// sınırlanabiliyor ya da engellenebiliyor.
  ///
  /// TODO: Yayına çıkmadan önce gerçek iletişim adresi yazılmalı — politika
  /// sorun durumunda ulaşılabilecek bir adres istiyor.
  static const imageUserAgent = 'Yolla/$appVersion (+https://yolla.app)';

  /// İstek zaman aşımları. Rota uçları OSRM'e gittiği için daha uzun sürebilir.
  static const connectTimeout = Duration(seconds: 10);
  static const receiveTimeout = Duration(seconds: 30);
}
