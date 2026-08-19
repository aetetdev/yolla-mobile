import 'package:flutter/material.dart';

/// Yolla renk paleti.
///
/// Ürün fotoğraf odaklı: kartın kendisi neredeyse tamamen görsel, arayüz
/// nötr kalır. Bu yüzden renkler iki gruba ayrılır:
///
/// * **Yüzey ve mürekkep** — sıcak, düşük doygunluklu; fotoğrafın önüne geçmez.
/// * **Aksiyon renkleri** — yalnızca kaydırma geri bildiriminde ve birincil
///   düğmelerde kullanılır. Bunlar dışında ekranda güçlü renk olmaz.
abstract final class YollaColors {
  // --- Marka ---

  /// Anadolu toprağı / gün batımı. Birincil marka rengi.
  static const brand = Color(0xFFD9542B);
  static const brandDark = Color(0xFFB23F1C);
  static const brandSoft = Color(0xFFFBEAE3);

  /// İkincil: çini mavisi. Harita ve rota çizgilerinde kullanılır.
  static const accent = Color(0xFF0F5257);

  /// Açılış ekranının zemini. Android'in ilk karesiyle (colors.xml) ve
  /// uygulama ikonunun zeminiyle aynı — geçişte renk sıçraması olmasın.
  static const splashBackground = Color(0xFF0F585E);

  static const accentSoft = Color(0xFFDDEDEC);

  // --- Kaydırma aksiyonları ---
  //
  // Marka rengi sıcak olduğu için "geç" (pass) rengi kırmızı seçilmedi;
  // kullanıcı iki turuncuyu ayırt edemezdi. Geç = nötr kömür.

  /// Sağa kaydır — plana ekle.
  static const like = Color(0xFF1F9D74);

  /// Sola kaydır — ilgilenmiyorum.
  static const pass = Color(0xFF5A5350);

  /// Aşağı kaydır — sonra bakarım.
  static const later = Color(0xFFE0A32E);

  // --- Yüzeyler (açık tema) ---

  /// Kağıt tonu: saf beyaz değil, fotoğrafların yanında daha yumuşak durur.
  static const background = Color(0xFFF7F5F2);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFEFEBE6);
  static const border = Color(0xFFE2DCD5);

  // --- Yüzeyler (koyu tema) ---

  static const backgroundDark = Color(0xFF12100F);
  static const surfaceDark = Color(0xFF1C1917);
  static const surfaceMutedDark = Color(0xFF272220);
  static const borderDark = Color(0xFF37302C);

  // --- Mürekkep ---

  /// Sıcak siyah. Saf siyah fotoğrafın yanında sert kalıyor.
  static const ink = Color(0xFF17110E);
  static const inkMuted = Color(0xFF6B615B);
  static const inkFaint = Color(0xFF9C918A);

  static const inkDark = Color(0xFFF5F1EE);
  static const inkMutedDark = Color(0xFFA9A09A);
  static const inkFaintDark = Color(0xFF756D68);

  // --- Durum ---

  static const danger = Color(0xFFC0392B);
  static const warning = Color(0xFFE0A32E);
  static const success = Color(0xFF1F9D74);

  /// Kart fotoğrafının üstündeki metnin okunması için kullanılan karartma.
  /// Fotoğraf açık renkliyse beyaz metin kaybolur, bu yüzden her kartta var.
  static const scrim = <Color>[
    Color(0x00000000),
    Color(0x33000000),
    Color(0xD9000000),
  ];
  static const scrimStops = <double>[0.35, 0.58, 1.0];
}
