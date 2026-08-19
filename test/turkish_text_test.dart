import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/shared/turkish_text.dart';

void main() {
  group('TurkishText.contains', () {
    test('Türkçe harf kullanılmadan yazılan arama eşleşir', () {
      expect(TurkishText.contains('Nevşehir', 'Nevsehir'), isTrue);
      expect(TurkishText.contains('İstanbul', 'istanbul'), isTrue);
      expect(TurkishText.contains('Çanakkale', 'canakkale'), isTrue);
      expect(TurkishText.contains('Muğla', 'mugla'), isTrue);
      expect(TurkishText.contains('Kırıkkale', 'kirikkale'), isTrue);
      expect(TurkishText.contains('Şanlıurfa', 'sanliurfa'), isTrue);
    });

    test('büyük I ile başlayan arama İ ile eşleşir', () {
      // `toLowerCase` bu durumda başarısız olurdu: 'İ' → 'i' + U+0307.
      expect(TurkishText.contains('İzmir', 'IZMIR'), isTrue);
      expect(TurkishText.contains('İzmir', 'Izmir'), isTrue);
    });

    test('parça eşleşmesi çalışır', () {
      expect(TurkishText.contains('Afyonkarahisar', 'karahisar'), isTrue);
      expect(TurkishText.contains('Nevşehir', 'sehir'), isTrue);
    });

    test('ilgisiz metin eşleşmez', () {
      expect(TurkishText.contains('Ankara', 'izmir'), isFalse);
      expect(TurkishText.contains('Bursa', 'xyz'), isFalse);
    });

    test('boş arama her şeyle eşleşir', () {
      expect(TurkishText.contains('Ankara', ''), isTrue);
    });

    test('normalize edilen metin beklenen biçimde', () {
      expect(TurkishText.normalize('İstanbul'), 'istanbul');
      expect(TurkishText.normalize('ÇANAKKALE'), 'canakkale');
      expect(TurkishText.normalize('Iğdır'), 'igdir');
    });
  });
}
