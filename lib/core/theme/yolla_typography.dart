import 'package:flutter/material.dart';

/// Tipografi ölçeği.
///
/// Özel yazı tipi henüz eklenmedi; platform varsayılanı kullanılıyor
/// (iOS'ta SF Pro, Android'de Roboto). Marka yazı tipi assets/fonts altına
/// konup burada `fontFamily` verilerek tek noktadan devreye alınabilir.
///
/// Ölçek altı kademeyle sınırlı tutuldu — ekranlarda serbest `fontSize`
/// kullanılmaz, hepsi buradan gelir.
abstract final class YollaText {
  static const _tight = -0.4;

  /// Açılış ekranındaki marka yazı tipi (Outfit).
  ///
  /// **Yalnızca açılış ekranında** kullanılıyor: uygulamanın geri kalanı —
  /// giriş/kayıt ekranı dahil — bilinçli olarak platform yazı tipinde kalıyor.
  /// Tek bir ekranda marka duruşu, geri kalanında sistemin okunaklılığı.
  static const brandFamily = 'Outfit';

  /// Değişken fontta kalınlık `fontWeight` ile seçilmiyor.
  ///
  /// Outfit tek dosyada bütün kalınlıkları `wght` ekseninde taşıyor;
  /// `fontWeight` tek başına verildiğinde fontun varsayılan örneği
  /// çiziliyor ve bütün kalınlıklar aynı görünüyor.
  static List<FontVariation> _weight(double value) => [
    FontVariation('wght', value),
  ];

  /// Açılıştaki "Yolla" yazısı.
  static final wordmark = TextStyle(
    fontFamily: brandFamily,
    fontVariations: _weight(600),
    fontSize: 46,
    height: 1.1,
    letterSpacing: 1.5,
  );

  /// Açılıştaki slogan.
  static final slogan = TextStyle(
    fontFamily: brandFamily,
    fontVariations: _weight(400),
    fontSize: 16,
    height: 1.3,
    letterSpacing: 0.2,
  );

  /// Ekran başlığı. Sayfa başına en fazla bir tane.
  static const display = TextStyle(
    fontSize: 32,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: _tight,
  );

  /// Kart üzerindeki yer adı.
  static const title = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: _tight,
  );

  /// Liste öğesi başlığı, bölüm başlığı.
  static const subtitle = TextStyle(
    fontSize: 17,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );

  /// Gövde metni, açıklamalar.
  static const body = TextStyle(
    fontSize: 15,
    height: 1.45,
    fontWeight: FontWeight.w400,
  );

  /// Yardımcı metin, mesafe, kategori.
  static const caption = TextStyle(
    fontSize: 13,
    height: 1.35,
    fontWeight: FontWeight.w500,
  );

  /// Atıf satırı ve rozetler. Yasal atıf bu boyutun altına inmemeli.
  static const micro = TextStyle(
    fontSize: 11,
    height: 1.3,
    fontWeight: FontWeight.w500,
  );

  /// Kaydırma sırasında beliren "PLANA EKLE" tipi damgalar.
  static const stamp = TextStyle(
    fontSize: 26,
    height: 1.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 2.0,
  );
}
