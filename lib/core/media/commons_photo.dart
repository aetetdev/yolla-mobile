/// Wikimedia Commons görsel adresi yardımcıları.
///
/// Backend `photoUrl` alanında Commons **orijinalini** veriyor
/// (`upload.wikimedia.org/wikipedia/commons/f/f0/Ad.jpg`). Ölçtüğümüzde
/// ortalama ~1 MB çıktı; kart destesi 3-5 kartı önden yüklediği için bu
/// haliyle mobil veride kullanılamaz.
///
/// Commons, adresin içine `thumb/` ekleyip sonuna `<genişlik>px-<ad>` ekleyerek
/// sunucu tarafında küçültülmüş sürüm veriyor:
///
/// ```
/// .../commons/f/f0/Ad.jpg
/// .../commons/thumb/f/f0/Ad.jpg/800px-Ad.jpg
/// ```
///
/// Dönüşüm tamamen belirlenimci olduğu için istemcide yapılabiliyor ve
/// backend'i beklemeye gerek kalmıyor.
///
/// > Bu geçici bir çözüm. Kalıcı yeri backend DTO'su: sunucu `photoUrl` ile
/// > birlikte hazır `photoThumbUrl` döndürürse istemci bu mantığı taşımaz ve
/// > web istemcisi de aynı işi tekrar yazmaz.
abstract final class CommonsPhoto {
  static const _host = 'upload.wikimedia.org';

  /// Wikimedia'nın kabul ettiği **standart** genişlikler.
  ///
  /// Bu liste keyfi değil: Wikimedia doğrudan bağlantıda (hotlink) standart
  /// dışı genişlikleri `400 Bad Request` ile reddediyor — `800px` istendiğinde
  /// "Use thumbnail sizes listed on ..." hatası dönüyor. Liste
  /// <https://www.mediawiki.org/wiki/Common_thumbnail_sizes> adresinden alındı.
  ///
  /// Yuvarlamanın ikinci faydası önbellek: farklı ekran genişliğindeki
  /// cihazlar aynı dosyayı paylaşır.
  static const _buckets = <int>[
    20,
    40,
    60,
    120,
    250,
    330,
    500,
    960,
    1280,
    1920,
    3840,
  ];

  /// [originalUrl] için verilen genişlikte küçük görsel adresi üretir.
  ///
  /// Adres Commons deseniyle uyuşmuyorsa (başka bir kaynak, zaten küçültülmüş
  /// bir adres ya da SVG) girdi olduğu gibi döner — hiçbir durumda görsel
  /// kaybolmaz.
  static String thumbnail(String originalUrl, {required int width}) {
    final uri = Uri.tryParse(originalUrl);
    if (uri == null || uri.host != _host) return originalUrl;

    // Yol **ham** haliyle işlenir. `Uri.pathSegments` yüzde kodlamasını çözer;
    // yeniden kurarken Dart bazı karakterleri (örneğin virgülü) tekrar
    // kodlamadığı için adres sessizce değişirdi. Dosya adına hiç dokunmamak
    // tek güvenli yol.
    final segments = uri.path.split('/');

    // Beklenen: ['', 'wikipedia', 'commons', '<a>', '<ab>', '<dosya>']
    if (segments.length != 6) return originalUrl;
    if (segments[1] != 'wikipedia' || segments[2] != 'commons') {
      return originalUrl;
    }
    // "thumb" zaten varsa adres küçültülmüş demektir, dokunma.
    if (segments[3] == 'thumb') return originalUrl;

    final fileName = segments[5];
    if (fileName.isEmpty) return originalUrl;

    // SVG'nin küçültülmüşü PNG olarak döner, uzantı değişir. Kapsam dışı
    // bırakmak, yanlış adres üretmekten iyi.
    if (fileName.toLowerCase().endsWith('.svg')) return originalUrl;

    final target = _bucketFor(width);
    final path =
        '/wikipedia/commons/thumb/${segments[3]}/${segments[4]}/'
        '$fileName/${target}px-$fileName';

    return '${uri.scheme}://${uri.host}$path';
  }

  /// Kart destesi için önerilen genişlik.
  ///
  /// Kart ekranın neredeyse tamamını kapladığı için mantıksal genişlik
  /// cihazın piksel oranıyla çarpılır, sonra kovaya yuvarlanır.
  static String card(
    String originalUrl, {
    required double logicalWidth,
    required double devicePixelRatio,
  }) {
    return thumbnail(
      originalUrl,
      width: (logicalWidth * devicePixelRatio).round(),
    );
  }

  static int _bucketFor(int width) {
    for (final bucket in _buckets) {
      if (width <= bucket) return bucket;
    }
    return _buckets.last;
  }
}
