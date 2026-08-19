import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/device_session.dart';

/// Cihaz kimliğini ve oturum jetonunu kalıcı olarak saklar.
///
/// UUID **kaybolmamalı**: kullanıcının bütün kaydırma geçmişi ve gezi planları
/// ona bağlı. Uygulama silinip yeniden kurulursa geçmiş kaybolur — hesap
/// özelliği tam olarak bunu çözmek için yazılıyor.
class SessionStore {
  SessionStore({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            // Cihaz açılmadan (ilk kilit açma öncesi) arka planda okuma
            // yapmıyoruz; bu erişilebilirlik düzeyi yedeklemeden de dönmez.
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock,
            ),
          );

  final FlutterSecureStorage _storage;

  static const _deviceUuidKey = 'yolla.device_uuid';
  static const _sessionKey = 'yolla.session';

  /// Cihaz UUID'sini döndürür, yoksa üretip saklar.
  Future<String> deviceUuid() async {
    final existing = await _storage.read(key: _deviceUuidKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final created = const Uuid().v4();
    await _storage.write(key: _deviceUuidKey, value: created);
    return created;
  }

  Future<DeviceSession?> readSession() async {
    final raw = await _storage.read(key: _sessionKey);
    if (raw == null || raw.isEmpty) return null;

    try {
      return DeviceSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on FormatException {
      // Biçim değişmiş ya da kayıt bozulmuş: sessizce at, yeniden kaydolunur.
      await _storage.delete(key: _sessionKey);
      return null;
    }
  }

  Future<void> writeSession(DeviceSession session) =>
      _storage.write(key: _sessionKey, value: jsonEncode(session.toJson()));

  Future<void> clearSession() => _storage.delete(key: _sessionKey);
}
