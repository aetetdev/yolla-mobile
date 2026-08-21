import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bildirimin telefona iletilmesi Firebase'e bağlı. Kurulum başarısız olursa
  // (iOS'ta `GoogleService-Info.plist` henüz yok) uygulama bildirimsiz
  // çalışmaya devam ediyor: sonuçlar yine uygulama içindeki listede görünüyor.
  try {
    await Firebase.initializeApp();
  } on Object catch (error) {
    debugPrint('Firebase kurulamadı, bildirim iletimi kapalı: $error');
  }

  // Harita platform görünümünü melez kompozisyonla göm.
  //
  // Varsayılan kipte haritanın üstüne çizilen Flutter içeriği ekrana
  // çıkmıyordu. Eklentinin 0.26.1 sürümü bunu düzeltti: melez kompozisyon
  // açıkken Android tarafı `textureMode`'u da doğru kuruyor
  // (maplibre/flutter-maplibre-gl#816 — "hybrid composition now correctly
  // enables textureMode when necessary, preventing crashes and rendering
  // issues with platform views").
  //
  // Bu bayrak 0.22.0'da da denenmişti ama o sürümde Android tarafına hiç
  // geçmiyordu, bu yüzden hiçbir şey değiştirmemişti. `runApp`'ten **önce**
  // ayarlanması gerekiyor.
  MapLibreMap.useHybridComposition = true;

  runApp(const ProviderScope(child: YollaApp()));
}
