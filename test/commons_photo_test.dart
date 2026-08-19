import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/core/media/commons_photo.dart';

void main() {
  group('CommonsPhoto.thumbnail', () {
    const original =
        'https://upload.wikimedia.org/wikipedia/commons/f/f0/Kuzucubelen_Castle.jpg';

    test('orijinal adresi küçültülmüş adrese çevirir', () {
      expect(
        CommonsPhoto.thumbnail(original, width: 960),
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/'
        'Kuzucubelen_Castle.jpg/960px-Kuzucubelen_Castle.jpg',
      );
    });

    test('istenen genişliği standart boyuta yuvarlar', () {
      // Wikimedia standart dışı genişlikleri 400 ile reddediyor; her istek
      // listedeki bir değere yuvarlanmak zorunda.
      expect(CommonsPhoto.thumbnail(original, width: 700), contains('/960px-'));
      expect(CommonsPhoto.thumbnail(original, width: 960), contains('/960px-'));
      expect(CommonsPhoto.thumbnail(original, width: 961), contains('/1280px-'));
      expect(CommonsPhoto.thumbnail(original, width: 100), contains('/120px-'));
    });

    test('yalnızca standart genişlik üretir', () {
      const allowed = {20, 40, 60, 120, 250, 330, 500, 960, 1280, 1920, 3840};

      for (var width = 1; width <= 4000; width += 7) {
        final url = CommonsPhoto.thumbnail(original, width: width);
        final produced = int.parse(
          RegExp(r'/(\d+)px-').firstMatch(url)!.group(1)!,
        );
        expect(
          allowed,
          contains(produced),
          reason: '$width px istendiğinde standart dışı $produced px üretildi',
        );
      }
    });

    test('en büyük boyutun üstünde son değerde kalır', () {
      expect(
        CommonsPhoto.thumbnail(original, width: 9000),
        contains('/3840px-'),
      );
    });

    test('yüzde kodlu dosya adını bozmaz', () {
      const encoded =
          'https://upload.wikimedia.org/wikipedia/commons/f/f0/'
          'Atat%C3%BCrk%2C_Yalova.jpg';

      final result = CommonsPhoto.thumbnail(encoded, width: 500);

      expect(result, contains('/thumb/f/f0/'));
      expect(result, endsWith('/500px-Atat%C3%BCrk%2C_Yalova.jpg'));
      // Kodlama tek seferlik kalmalı: %25 görünürse çift kodlanmıştır.
      expect(result, isNot(contains('%25')));
    });

    test('zaten küçültülmüş adrese dokunmaz', () {
      const thumb =
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/A.jpg/320px-A.jpg';
      expect(CommonsPhoto.thumbnail(thumb, width: 800), thumb);
    });

    test('SVG dosyalarını olduğu gibi bırakır', () {
      const svg =
          'https://upload.wikimedia.org/wikipedia/commons/1/12/Logo.svg';
      expect(CommonsPhoto.thumbnail(svg, width: 800), svg);
    });

    test('Commons dışı adresleri değiştirmez', () {
      const other = 'https://example.com/photo.jpg';
      expect(CommonsPhoto.thumbnail(other, width: 800), other);
    });

    test('geçersiz adreste çökmez', () {
      expect(CommonsPhoto.thumbnail('', width: 800), '');
      expect(CommonsPhoto.thumbnail('not a url', width: 800), 'not a url');
    });
  });

  group('CommonsPhoto.card', () {
    test('mantıksal genişliği piksel oranıyla çarpar', () {
      const original =
          'https://upload.wikimedia.org/wikipedia/commons/f/f0/A.jpg';

      // 390 dp × 3 = 1170 → 1280
      expect(
        CommonsPhoto.card(original, logicalWidth: 390, devicePixelRatio: 3),
        contains('/1280px-'),
      );
      // Aynı kart, 1x ekranda çok daha küçük dosya ister.
      expect(
        CommonsPhoto.card(original, logicalWidth: 390, devicePixelRatio: 1),
        contains('/500px-'),
      );
    });
  });
}
