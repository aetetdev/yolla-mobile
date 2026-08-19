/// Türkçe metin karşılaştırması.
///
/// `String.toLowerCase()` Türkçe için yanlış çalışıyor: `İ` küçültüldüğünde
/// `i` + birleşik nokta (U+0307) üretiyor, `I` ise `i` oluyor — yani
/// "İstanbul" yazan kullanıcı "istanbul" araması yaptığında eşleşme kaçabiliyor.
/// Ayrıca kullanıcılar sıklıkla Türkçe harf kullanmadan yazıyor ("Nevsehir").
///
/// Bu yüzden karşılaştırma öncesi metin sadeleştiriliyor: Türkçe harfler
/// ASCII karşılıklarına indiriliyor ve küçük harfe çevriliyor.
///
/// Sunucu tarafı da aynı işi yapıyor (`name_normalized`); bu yardımcı yalnızca
/// istemcide **yerel** filtreleme yapılan yerler için.
abstract final class TurkishText {
  static const _map = {
    'ı': 'i',
    'İ': 'i',
    'I': 'i',
    'i': 'i',
    'ş': 's',
    'Ş': 's',
    'ğ': 'g',
    'Ğ': 'g',
    'ü': 'u',
    'Ü': 'u',
    'ö': 'o',
    'Ö': 'o',
    'ç': 'c',
    'Ç': 'c',
    'â': 'a',
    'Â': 'a',
    'î': 'i',
    'Î': 'i',
    'û': 'u',
    'Û': 'u',
  };

  /// Karşılaştırılabilir biçime indirger.
  ///
  /// Kod birimi başına geziliyor: eşlenen harflerin tamamı BMP'de ve tek kod
  /// birimi, dolayısıyla emoji gibi çift birimli karakterler bozulmuyor —
  /// onlar `toLowerCase` dalına düşüp olduğu gibi kalıyor.
  static String normalize(String value) {
    final buffer = StringBuffer();
    for (final rune in value.runes) {
      final char = String.fromCharCode(rune);
      buffer.write(_map[char] ?? char.toLowerCase());
    }
    return buffer.toString();
  }

  /// [haystack], [needle] ifadesini içeriyor mu? Türkçe harf farkı gözetmez.
  static bool contains(String haystack, String needle) {
    if (needle.isEmpty) return true;
    return normalize(haystack).contains(normalize(needle));
  }
}
