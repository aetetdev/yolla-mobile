/// Aralık, köşe yarıçapı ve hareket süreleri.
///
/// Tek bir 4 px ölçeğine bağlı kalınır; ekranlarda serbest sayı kullanılmaz.
abstract final class Space {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const xxxl = 48.0;
}

abstract final class Radii {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 20.0;

  /// Kart destesindeki kartların yarıçapı. Fotoğrafın kırpılma hissini
  /// yumuşatacak kadar büyük, kartı "buton" gibi göstermeyecek kadar küçük.
  static const card = 28.0;

  static const pill = 999.0;
}

abstract final class Motion {
  /// Basma geri bildirimi, rozet belirmesi.
  static const fast = Duration(milliseconds: 140);

  /// Kartın parmağın altından çıkışı, ekran geçişleri.
  static const normal = Duration(milliseconds: 260);

  /// Kartın eski yerine yaylanarak dönmesi.
  static const slow = Duration(milliseconds: 420);
}
