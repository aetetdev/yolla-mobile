import 'package:flutter/services.dart' show rootBundle;

import '../../app/env.dart';

/// Harita stilini varlıklardan okuyup karo adresini yerine koyar.
///
/// Adres derleme zamanında belli değil (öykünücü `10.0.2.2`, gerçek cihaz
/// `localhost`, üretim kendi alan adı), bu yüzden stilde `{TILE_BASE}` yer
/// tutucusu bırakıldı.
///
/// Sonuç **bir kez** okunup saklanıyor: hem keşif haritası hem plan haritası
/// aynı stili kullanıyor ve dosya yüz kilobayt mertebesinde.
abstract final class YollaMapStyle {
  static String? _cached;
  static Future<String>? _pending;

  static Future<String> load() {
    if (_cached case final style?) return Future.value(style);
    return _pending ??= _read();
  }

  static Future<String> _read() async {
    final raw = await rootBundle.loadString('assets/map/yolla_light.json');
    return _cached = raw.replaceAll('{TILE_BASE}', Env.tileBaseUrl);
  }
}
