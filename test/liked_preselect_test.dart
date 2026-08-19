import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/app/routes.dart';

/// Haritada beğenilen yerler beğenilenler ekranına adres üzerinden taşınıyor:
/// `Routes.likedFor` kimlikleri yazıyor, `Routes.preselectOf` geri okuyor.
/// İkisi ayrışırsa hata sessiz oluyor — ekran açılıyor ama hiçbir yer işaretli
/// gelmiyor ve kullanıcı haritada topladıklarını elle yeniden seçiyor. Bu
/// yüzden gidiş dönüş burada sabitleniyor.
void main() {
  group('Routes.likedFor', () {
    test('seçim yokken sade adres döner', () {
      expect(Routes.likedFor(null), Routes.liked);
    });

    test('boş seçim parametre eklemez', () {
      expect(Routes.likedFor(null, preselect: const <int>{}), Routes.liked);
    });

    test('şehir ve seçim birlikte taşınır', () {
      final url = Uri.parse(Routes.likedFor(34, preselect: const [7, 9]));

      expect(url.queryParameters['sehir'], '34');
      expect(url.queryParameters['secili'], '7,9');
    });
  });

  group('Routes.preselectOf', () {
    test('yazılan kimlikler geri okunur', () {
      final url = Uri.parse(Routes.likedFor(null, preselect: const {4, 8, 15}));

      expect(Routes.preselectOf(url.queryParameters['secili']), {4, 8, 15});
    });

    test('parametre yokken null döner — ekran hepsini seçili açsın', () {
      expect(Routes.preselectOf(null), isNull);
      expect(Routes.preselectOf(''), isNull);
    });

    test('bozuk değer tümüyle atılmaz, çözülebilenler alınır', () {
      expect(Routes.preselectOf('12,abc,30'), {12, 30});
    });

    test('hiçbiri çözülemezse null döner', () {
      expect(Routes.preselectOf('abc,def'), isNull);
    });
  });
}
