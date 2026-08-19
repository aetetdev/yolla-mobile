import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';

/// Uygulamanın açılış ekranı.
///
/// Sırayla: aşağıdan yukarı çizilen bir rota, üstüne oturan duraklar, sonra
/// alttan süzülen Kapadokya balonları. Flutter'ın varsayılan logosu yerine
/// geçiyor.
///
/// Vektör çizim (`CustomPainter`) tercih edildi: her ekran boyutunda keskin,
/// tema renklerini kullanıyor ve dosya olarak bir ağırlığı yok.
class SplashScreen extends StatefulWidget {
  const SplashScreen({this.onFinished, super.key});

  /// Animasyon bitince çağrılır.
  final VoidCallback? onFinished;

  /// Animasyonun tamamının süresi.
  static const duration = Duration(milliseconds: 2600);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SplashScreen.duration,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward().whenComplete(() => widget.onFinished?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    // Hareketi azaltma açıkken animasyon oynatılmıyor; son kare gösterilip
    // hemen geçiliyor.
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion && _controller.isAnimating) {
      _controller
        ..stop()
        ..value = 1;
      widget.onFinished?.call();
    }

    return ColoredBox(
      color: YollaColors.splashBackground,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => CustomPaint(
                painter: _SplashPainter(_controller.value),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.62),
            child: FadeTransition(
              // Ad, rota çizildikten sonra beliriyor.
              opacity: CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.45, 0.75, curve: Curves.easeOut),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.appName,
                    style: YollaText.wordmark.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: Space.xs),
                  Text(
                    l10n.appTagline,
                    textAlign: TextAlign.center,
                    style: YollaText.slogan.copyWith(
                      // Ada göre bir tık soluk: ikisi aynı ağırlıkta olunca
                      // hangisinin marka olduğu belirsizleşiyor.
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Açılış karesini çizer.
///
/// Zaman çizelgesi:
/// * `0.00 – 0.45` rota aşağıdan yukarı çizilir,
/// * `0.30 – 0.60` duraklar sırayla yukarıdan düşüp yola oturur,
/// * `0.45 – 1.00` balonlar alttan yukarı süzülür.
class _SplashPainter extends CustomPainter {
  _SplashPainter(this.t);

  final double t;

  /// Balon dilimlerinin renkleri.
  ///
  /// Kapadokya balonları tek renk değil, düşey dilimler halinde boyanıyor.
  /// Her desen dört renk taşıyor ve dilimler bunları sırayla tekrarlıyor.
  /// Paletler marka renginden değil gerçek balonlardan geliyor; açılış
  /// ekranının tek renkli ve soluk kalmaması için bilinçli olarak canlı.
  static const _patterns = <List<Color>>[
    [Color(0xFFE84A3F), Color(0xFFF7B32B), Color(0xFF2FA3C7), Color(0xFF1F7A5A)],
    [Color(0xFF8E44AD), Color(0xFFF25C54), Color(0xFFF7B32B), Color(0xFF2FA3C7)],
    [Color(0xFF1F7A5A), Color(0xFFF7E733), Color(0xFFE84A3F), Color(0xFFFFFFFF)],
    [Color(0xFFF25C54), Color(0xFFFFFFFF), Color(0xFF2FA3C7), Color(0xFFF7B32B)],
    [Color(0xFFF7B32B), Color(0xFFE84A3F), Color(0xFF8E44AD), Color(0xFF1F7A5A)],
  ];

  /// Türk bayrağının kırmızısı (TSE 1000'e göre).
  static const _flagRed = Color(0xFFE30A17);

  /// Balonların konumu, duracağı yükseklik, boyu, deseni ve bayraklı olup
  /// olmadığı. Rastgele üretilmiyor: her açılışta aynı görünsün, "bozuk"
  /// izlenimi vermesin.
  ///
  /// [endY] ekran yüksekliğinin oranı: balon animasyonun sonunda burada
  /// duruyor. Balon başına ayrı veriliyor çünkü hepsi aynı yere gidince
  /// ya tek sıra halinde diziliyorlar ya da hep birlikte ekranın üstünden
  /// çıkıp kayboluyorlar — açılışın son karesinde ekran boş kalıyordu.
  ///
  /// Boylar bilinçli olarak birbirinden uzak: fotoğraftaki gibi önde iri,
  /// arkada küçük balonlar olunca derinlik hissi çıkıyor. Hepsi aynı boyda
  /// olduğunda ekran düz bir desene dönüyor.
  static const _balloons =
      <(double x, double endY, double delay, double scale, int pattern, bool flag)>[
        (0.17, 0.30, 0.00, 1.00, 0, false),
        (0.78, 0.20, 0.06, 0.86, 1, false),
        // Bayraklı balon ortada, iri ve en önde: göz önce buraya düşsün.
        (0.47, 0.44, 0.14, 0.96, 0, true),
        (0.90, 0.38, 0.24, 0.52, 2, false),
        (0.05, 0.09, 0.30, 0.60, 3, false),
        (0.66, 0.06, 0.40, 0.44, 4, false),
        (0.30, 0.12, 0.48, 0.38, 1, false),
      ];

  @override
  void paint(Canvas canvas, Size size) {
    // Rota önce: balonlar gökyüzünde, yolun üstünde duruyor. Ters sırada
    // çizgi balonların ortasından geçip onları ikiye bölüyordu.
    _paintRoute(canvas, size);
    _paintBalloons(canvas, size);
  }

  /// Aşağıdan yukarı kıvrılarak çizilen yol.
  void _paintRoute(Canvas canvas, Size size) {
    final path = _routePath(size);
    final metric = path.computeMetrics().firstOrNull;
    if (metric == null) return;

    final progress = Curves.easeInOutCubic.transform(
      (t / 0.45).clamp(0.0, 1.0),
    );

    canvas.drawPath(
      metric.extractPath(0, metric.length * progress),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(size.width * 0.014, 3)
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = YollaColors.brand,
    );

    // Duraklar: yolun belirli noktalarına yukarıdan düşüyorlar.
    const stops = [0.08, 0.34, 0.62, 0.9];
    for (var i = 0; i < stops.length; i++) {
      final at = stops[i];
      if (progress < at) continue;

      final start = 0.30 + i * 0.07;
      final drop = Curves.easeOutBack.transform(
        ((t - start) / 0.18).clamp(0.0, 1.0),
      );
      if (drop <= 0) continue;

      final point = metric.getTangentForOffset(metric.length * at)!.position;
      final radius = math.max(size.width * 0.018, 4.0) * drop;

      // Düşerken yukarıdan geliyor izlenimi için dikey kayma.
      final offset = Offset(point.dx, point.dy - (1 - drop) * size.height * 0.06);

      canvas
        ..drawCircle(offset, radius * 1.7, Paint()..color = Colors.white)
        ..drawCircle(offset, radius, Paint()..color = YollaColors.brand);
    }
  }

  /// Ekranın altından üstüne kıvrılan yol.
  Path _routePath(Size size) {
    Offset p(double x, double y) => Offset(size.width * x, size.height * y);

    return Path()
      ..moveTo(p(0.24, 0.92).dx, p(0.24, 0.92).dy)
      ..cubicTo(
        p(0.10, 0.76).dx, p(0.10, 0.76).dy,
        p(0.84, 0.66).dx, p(0.84, 0.66).dy,
        p(0.62, 0.48).dx, p(0.62, 0.48).dy,
      )
      ..cubicTo(
        p(0.44, 0.34).dx, p(0.44, 0.34).dy,
        p(0.16, 0.32).dx, p(0.16, 0.32).dy,
        p(0.46, 0.14).dx, p(0.46, 0.14).dy,
      );
  }

  /// Alttan süzülen sıcak hava balonları.
  void _paintBalloons(Canvas canvas, Size size) {
    for (final (x, endY, delay, scale, pattern, flag) in _balloons) {
      final local = ((t - 0.45 - delay * 0.35) / 0.55).clamp(0.0, 1.0);
      if (local <= 0) continue;

      final eased = Curves.easeOutSine.transform(local);

      // Ekranın altından başlayıp kendi yüksekliğine süzülüyor; yatayda hafif
      // salınım var.
      final dy = size.height * (1.15 + (endY - 1.15) * eased);
      final sway = math.sin((eased + delay) * math.pi * 2) * size.width * 0.02;
      final center = Offset(size.width * x + sway, dy);

      final radius = size.width * 0.135 * scale;
      final opacity = (eased < 0.15 ? eased / 0.15 : 1.0) * 0.95;

      _drawBalloon(canvas, center, radius, _patterns[pattern], flag, opacity);
    }
  }

  void _drawBalloon(
    Canvas canvas,
    Offset center,
    double radius,
    List<Color> pattern,
    bool flag,
    double opacity,
  ) {
    // Gövde: küre ile aşağı doğru daralan damla birleşimi.
    final body = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..moveTo(center.dx - radius * 0.82, center.dy + radius * 0.55)
      ..quadraticBezierTo(
        center.dx - radius * 0.30,
        center.dy + radius * 1.75,
        center.dx,
        center.dy + radius * 1.9,
      )
      ..quadraticBezierTo(
        center.dx + radius * 0.30,
        center.dy + radius * 1.75,
        center.dx + radius * 0.82,
        center.dy + radius * 0.55,
      )
      ..close();

    // Gövde dilim dilim boyanıyor. Dilimler gövdenin sınırına kırpılıyor:
    // düz dikdörtgenler çiziliyor ama balonun dışına taşmıyorlar, böylece
    // kenarlar kürenin eğrisini koruyor.
    canvas
      ..save()
      ..clipPath(body);

    if (flag) {
      _paintFlag(canvas, center, radius, opacity);
    } else {
      const gores = 8;
      final left = center.dx - radius;
      final width = radius * 2 / gores;

      for (var i = 0; i < gores; i++) {
        canvas.drawRect(
          Rect.fromLTRB(
            left + i * width,
            center.dy - radius,
            // Dilimler yarım piksel bindiriliyor: aradaki tırtıklı boşluk
            // yuvarlama yüzünden çıkıyor ve balonu çizgili gösteriyordu.
            left + (i + 1) * width + 0.5,
            center.dy + radius * 2,
          ),
          Paint()
            ..color = pattern[i % pattern.length].withValues(alpha: opacity),
        );
      }
    }

    // Alt yarıya doğru koyulaşan gölge; balon düz bir daire değil küre gibi
    // dursun.
    canvas
      ..drawPath(
        body,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: opacity * 0.18),
              Colors.transparent,
              Colors.black.withValues(alpha: opacity * 0.22),
            ],
            stops: const [0.0, 0.45, 1.0],
          ).createShader(
            Rect.fromCircle(center: center, radius: radius * 2),
          ),
      )
      ..restore();

    // Sepet.
    final basket = Rect.fromCenter(
      center: Offset(center.dx, center.dy + radius * 2.25),
      width: radius * 0.5,
      height: radius * 0.35,
    );

    canvas
      ..drawLine(
        Offset(center.dx - radius * 0.2, center.dy + radius * 1.85),
        Offset(basket.left + basket.width * 0.15, basket.top),
        Paint()
          ..strokeWidth = math.max(radius * 0.05, 0.8)
          ..color = Colors.white.withValues(alpha: opacity * 0.7),
      )
      ..drawLine(
        Offset(center.dx + radius * 0.2, center.dy + radius * 1.85),
        Offset(basket.right - basket.width * 0.15, basket.top),
        Paint()
          ..strokeWidth = math.max(radius * 0.05, 0.8)
          ..color = Colors.white.withValues(alpha: opacity * 0.7),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(basket, Radius.circular(radius * 0.1)),
        Paint()..color = Colors.white.withValues(alpha: opacity * 0.85),
      );
  }

  /// Bayraklı balon: kırmızı zemin, beyaz ay ve yıldız.
  ///
  /// Çağıran gövdeye kırpmış durumda, o yüzden zemin gövdeyi taşacak kadar
  /// büyük çiziliyor — kenarları kırpma belirliyor.
  void _paintFlag(Canvas canvas, Offset center, double radius, double opacity) {
    canvas.drawRect(
      Rect.fromCircle(center: center, radius: radius * 2.4),
      Paint()..color = _flagRed.withValues(alpha: opacity),
    );

    final white = Paint()..color = Colors.white.withValues(alpha: opacity);

    // Ay: büyük daireden, sağa kaydırılmış küçük daire çıkarılıyor. Açık
    // tarafı sağa bakıyor, bayraktaki gibi.
    final outer = Path()
      ..addOval(
        Rect.fromCircle(
          center: center.translate(-radius * 0.20, 0),
          radius: radius * 0.40,
        ),
      );
    final inner = Path()
      ..addOval(
        Rect.fromCircle(
          center: center.translate(-radius * 0.06, 0),
          radius: radius * 0.32,
        ),
      );

    canvas
      ..drawPath(Path.combine(PathOperation.difference, outer, inner), white)
      // Yıldız ayın açık tarafında, ucuna değmeden duruyor.
      ..drawPath(_star(center.translate(radius * 0.42, 0), radius * 0.18), white);
  }

  /// Beş köşeli yıldız; [radius] dış köşelerin merkeze uzaklığı.
  Path _star(Offset center, double radius) {
    const points = 5;
    final path = Path();

    for (var i = 0; i < points * 2; i++) {
      final r = i.isEven ? radius : radius * 0.42;
      // Çeyrek tur geri alınıyor ki bir köşe yukarı baksın.
      final angle = i * math.pi / points - math.pi / 2;
      final corner = center + Offset(math.cos(angle) * r, math.sin(angle) * r);

      if (i == 0) {
        path.moveTo(corner.dx, corner.dy);
      } else {
        path.lineTo(corner.dx, corner.dy);
      }
    }

    return path..close();
  }

  @override
  bool shouldRepaint(_SplashPainter old) => old.t != t;
}
