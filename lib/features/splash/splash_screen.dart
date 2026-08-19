import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/yolla_colors.dart';
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
              child: Text(
                l10n.appName,
                style: YollaText.display.copyWith(
                  color: Colors.white,
                  fontSize: 40,
                ),
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

  /// Balonların konumu, boyu ve rengi. Rastgele üretilmiyor: her açılışta
  /// aynı görünsün, "bozuk" izlenimi vermesin.
  static const _balloons = <(double x, double delay, double scale, bool warm)>[
    (0.16, 0.00, 1.00, true),
    (0.78, 0.08, 0.78, false),
    (0.34, 0.18, 0.55, false),
    (0.62, 0.26, 0.92, true),
    (0.88, 0.36, 0.48, true),
    (0.08, 0.44, 0.66, false),
    (0.48, 0.52, 0.42, true),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    _paintBalloons(canvas, size);
    _paintRoute(canvas, size);
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
    for (final (x, delay, scale, warm) in _balloons) {
      final local = ((t - 0.45 - delay * 0.35) / 0.55).clamp(0.0, 1.0);
      if (local <= 0) continue;

      final eased = Curves.easeOutSine.transform(local);

      // Aşağıdan yukarı süzülüyor; yatayda hafif salınım var.
      final dy = size.height * (1.15 - eased * 1.25);
      final sway = math.sin((eased + delay) * math.pi * 2) * size.width * 0.02;
      final center = Offset(size.width * x + sway, dy);

      final radius = size.width * 0.075 * scale;
      final opacity = (eased < 0.15 ? eased / 0.15 : 1.0) * 0.9;

      _drawBalloon(canvas, center, radius, warm, opacity);
    }
  }

  void _drawBalloon(
    Canvas canvas,
    Offset center,
    double radius,
    bool warm,
    double opacity,
  ) {
    final color = (warm ? YollaColors.brand : YollaColors.balloonCool)
        .withValues(alpha: opacity);

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

    canvas.drawPath(body, Paint()..color = color);

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

  @override
  bool shouldRepaint(_SplashPainter old) => old.t != t;
}
