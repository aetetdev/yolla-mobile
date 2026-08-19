import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';

/// Uygulamanın açılış ekranı.
///
/// Sırayla: alttan yükselip ekranı geçen Kapadokya balonları, ardından
/// aşağıdan yukarı çizilen rota ve üstüne oturan duraklar, en sonunda soldan
/// sağa açılan ad ve slogan. Flutter'ın varsayılan logosu yerine geçiyor.
///
/// Vektör çizim (`CustomPainter`) tercih edildi: her ekran boyutunda keskin,
/// tema renklerini kullanıyor ve dosya olarak bir ağırlığı yok.
class SplashScreen extends StatefulWidget {
  const SplashScreen({this.onFinished, super.key});

  /// Animasyon bitince çağrılır.
  final VoidCallback? onFinished;

  /// Animasyonun tamamının süresi.
  static const duration = Duration(milliseconds: 3800);

  /// Animasyon bittikten sonra ekranın durduğu süre.
  ///
  /// Son kare marka karesi: ad ve slogan okunuyor. Bekleme olmadan o kare
  /// belirir belirmez kayboluyor ve kullanıcı açılış ekranını göremiyor.
  static const hold = Duration(milliseconds: 900);

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
    unawaited(_run());
  }

  Future<void> _run() async {
    // Animasyon ilk kare ekrana çizilene kadar **başlamıyor**.
    //
    // Android uygulama açılırken kendi açılış penceresini gösteriyor ve onu
    // ancak Flutter ilk kareyi bildirince kaldırıyor. Denetleyici `initState`
    // içinde başlatılınca animasyon o pencerenin arkasında akıyor; kullanıcı
    // ekranı gördüğünde balonlar çoktan geçmiş oluyordu.
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;

    await _controller.forward();
    await Future<void>.delayed(SplashScreen.hold);
    if (mounted) widget.onFinished?.call();
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

    // `Material`, `ColoredBox` değil: açılış yönlendiricinin üstüne ayrı bir
    // katman olarak biniyor ve arada Material ağacı yok. Metin böyle bir
    // ağaçta çizilince Flutter hata ayıklama derlemelerinde altına sarı çift
    // çizgi koyuyor — ad ve slogan çizgili görünüyordu.
    return Material(
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
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => _LeftToRightReveal(
                progress: _SplashPainter.textProgress(_controller.value),
                child: child!,
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

/// İçeriği soldan sağa doğru açar.
///
/// Yumuşak bir kenarla ilerleyen maske: harfler sırayla, silinip yazılıyormuş
/// gibi beliriyor. Tek parça `FadeTransition` ile hepsi aynı anda geliyordu ve
/// hareketin yönü okunmuyordu.
class _LeftToRightReveal extends StatelessWidget {
  const _LeftToRightReveal({required this.progress, required this.child});

  /// 0 tamamen gizli, 1 tamamen görünür.
  final double progress;

  final Widget child;

  /// Maskenin yumuşak kenarının genişliği (içeriğin oranı olarak).
  static const _feather = 0.22;

  @override
  Widget build(BuildContext context) {
    if (progress >= 1) return child;

    // Kenar soldan sağa süpürüyor. Başlarken tamamen solda (hiçbir şey
    // görünmüyor), biterken tamamen sağda (her şey görünüyor).
    final edge = -_feather + progress * (1 + 2 * _feather);
    final start = (edge - _feather).clamp(0.0, 1.0);

    // Bitiş başlangıçtan **kesinlikle** büyük olmalı; eşit olduğunda gradyan
    // tanımsız kalıyor.
    final end = math.min(1.0, math.max(edge, start + 0.001));

    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: const [Colors.white, Colors.transparent],
        stops: [start, end],
      ).createShader(bounds),
      child: child,
    );
  }
}

/// Açılış karesini çizer.
///
/// Zaman çizelgesi:
/// * `0.00 – 0.45` balonlar alttan yükselip ekranı geçer,
/// * `0.45 – 0.76` rota aşağıdan yukarı çizilir,
/// * `0.58 – 0.84` duraklar sırayla yukarıdan düşüp yola oturur,
/// * `0.76 – 1.00` ad ve slogan soldan sağa açılır.
class _SplashPainter extends CustomPainter {
  _SplashPainter(this.t);

  final double t;

  /// Yazının açılma oranı; ekran widget'ı da buradan okuyor ki çizelge tek
  /// yerde dursun.
  static double textProgress(double t) =>
      Curves.easeOut.transform(((t - 0.76) / 0.24).clamp(0.0, 1.0));

  /// Balon dilimlerinin renkleri.
  ///
  /// Balonlar tek renk değil, düşey dilimler halinde boyanıyor ve dilimler
  /// bu renkleri sırayla tekrarlıyor. Paletler marka renginden değil gerçek
  /// balonlardan geliyor; açılış ekranının soluk kalmaması için canlı.
  static const _patterns = <List<Color>>[
    [Color(0xFFE03131), Color(0xFFFFD43B)],
    [Color(0xFF7048E8), Color(0xFFFF922B), Color(0xFFFFD43B), Color(0xFF22B8CF)],
    [Color(0xFF0CA678), Color(0xFFFFE066), Color(0xFFE03131), Color(0xFFFFFFFF)],
    [Color(0xFFFF6B6B), Color(0xFFFFFFFF), Color(0xFF228BE6), Color(0xFFFFD43B)],
    [Color(0xFFFFA94D), Color(0xFFE03131), Color(0xFF7048E8), Color(0xFF0CA678)],
  ];

  /// Referans balondaki açık mavi yatay bantlar.
  static const _bandColor = Color(0xFFD7ECF5);

  /// Sepetin ve boyun bandının renkleri.
  static const _collarColor = Color(0xFF2B4EA2);
  static const _basketColor = Color(0xFFD97A1E);

  /// Türk bayrağının kırmızısı (TSE 1000'e göre).
  static const _flagRed = Color(0xFFE30A17);

  /// Balonların yatay konumu, gecikmesi, boyu, deseni ve bayraklı olup
  /// olmadığı. Rastgele üretilmiyor: her açılışta aynı görünsün, "bozuk"
  /// izlenimi vermesin.
  ///
  /// Boylar bilinçli olarak birbirinden uzak: önde iri, arkada küçük balon
  /// olunca derinlik hissi çıkıyor. Hepsi aynı boyda olduğunda ekran düz bir
  /// desene dönüyor.
  static const _balloons =
      <(double x, double delay, double scale, int pattern, bool flag)>[
        (0.17, 0.000, 1.00, 0, false),
        (0.72, 0.020, 0.90, 1, false),
        // Bayraklı balon ortada ve en iri: göz önce buraya düşsün.
        (0.45, 0.055, 1.12, 0, true),
        (0.00, 0.070, 0.66, 3, false),
        (0.95, 0.085, 0.72, 2, false),
        (0.30, 0.100, 0.54, 4, false),
        (0.63, 0.095, 0.48, 1, false),
      ];

  @override
  void paint(Canvas canvas, Size size) {
    // Rota önce: balonlar gökyüzünde, yolun üstünde. Ters sırada çizgi
    // balonların ortasından geçip onları ikiye bölüyordu.
    _paintRoute(canvas, size);
    _paintBalloons(canvas, size);
  }

  /// Aşağıdan yukarı kıvrılarak çizilen yol.
  ///
  /// Balonlar geçtikten sonra başlıyor: ikisi aynı anda oynayınca ekranda ne
  /// olduğu okunmuyordu.
  void _paintRoute(Canvas canvas, Size size) {
    final path = _routePath(size);
    final metric = path.computeMetrics().firstOrNull;
    if (metric == null) return;

    final progress = Curves.easeInOutCubic.transform(
      ((t - 0.45) / 0.31).clamp(0.0, 1.0),
    );
    if (progress <= 0) return;

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

      final start = 0.58 + i * 0.06;
      final drop = Curves.easeOutBack.transform(
        ((t - start) / 0.16).clamp(0.0, 1.0),
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

  /// Alttan yükselip ekranı geçen sıcak hava balonları.
  void _paintBalloons(Canvas canvas, Size size) {
    for (final (x, delay, scale, pattern, flag) in _balloons) {
      final local = ((t - delay) / 0.35).clamp(0.0, 1.0);
      if (local <= 0) continue;

      final eased = Curves.easeInOutSine.transform(local);

      // Ekranın altından başlayıp üstünden çıkıyor; yatayda hafif salınım var.
      final dy = size.height * (1.35 - eased * 2.10);
      final sway = math.sin((eased + delay) * math.pi * 2) * size.width * 0.02;
      final center = Offset(size.width * x + sway, dy);

      final radius = size.width * 0.26 * scale;

      // Girişte sert belirmesin; çıkışta zaten kadraj dışına taşıyor.
      final opacity = (local < 0.10 ? local / 0.10 : 1.0);

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
    // Gövde tek parça: geniş yuvarlak üst, aşağı doğru daralan boyun.
    //
    // Eskiden bir daire ile ayrı bir alt yol üst üste konuyordu; birleştikleri
    // yerde dairenin alt yayı içeride kalıyor ve balonun ortasında yay
    // biçiminde bir kesik görünüyordu.
    final neckY = center.dy + radius * 1.26;
    final neckHalf = radius * 0.30;

    // Üst yarı tam çember, alt yarı boyna doğru daralıyor — referans balonun
    // oranı bu. Daha dar kontrol noktalarıyla gövde yumurtaya benziyordu.
    final envelope = Path()
      ..moveTo(center.dx - radius, center.dy)
      ..arcToPoint(
        Offset(center.dx + radius, center.dy),
        radius: Radius.circular(radius),
        clockwise: true,
      )
      ..cubicTo(
        center.dx + radius, center.dy + radius * 0.62,
        center.dx + neckHalf * 1.9, center.dy + radius * 0.98,
        center.dx + neckHalf, neckY,
      )
      ..lineTo(center.dx - neckHalf, neckY)
      ..cubicTo(
        center.dx - neckHalf * 1.9, center.dy + radius * 0.98,
        center.dx - radius, center.dy + radius * 0.62,
        center.dx - radius, center.dy,
      )
      ..close();

    canvas
      ..save()
      ..clipPath(envelope);

    if (flag) {
      _paintFlag(canvas, center, radius, opacity);
    } else {
      _paintGores(canvas, center, radius, neckY, neckHalf, pattern, opacity);
      _paintBands(canvas, center, radius, opacity);
    }

    // Parlama: sol üstte yumuşak bir ışık. Balonu düz bir lekeden çıkarıyor.
    canvas
      ..drawOval(
        Rect.fromCenter(
          center: center.translate(-radius * 0.38, -radius * 0.34),
          width: radius * 0.52,
          height: radius * 0.86,
        ),
        Paint()
          ..color = Colors.white.withValues(alpha: opacity * 0.28)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.10),
      )
      // Alt yarıya doğru koyulaşan gölge; balon düz bir daire değil küre gibi
      // dursun.
      ..drawPath(
        envelope,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: opacity * 0.20),
            ],
            stops: const [0.55, 1.0],
          ).createShader(
            Rect.fromCircle(center: center, radius: radius * 1.6),
          ),
      )
      ..restore();

    final ink = Colors.black.withValues(alpha: opacity * 0.85);
    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(radius * 0.035, 1.4)
      ..strokeJoin = StrokeJoin.round
      ..color = ink;

    canvas.drawPath(envelope, outline);

    _paintRigging(canvas, center, radius, neckY, neckHalf, outline, opacity);
  }

  /// Düşey dilimler ve aralarındaki dikişler.
  void _paintGores(
    Canvas canvas,
    Offset center,
    double radius,
    double neckY,
    double neckHalf,
    List<Color> pattern,
    double opacity,
  ) {
    const count = 8;
    final left = center.dx - radius;
    final band = radius * 2 / count;

    for (var i = 0; i < count; i++) {
      canvas.drawRect(
        Rect.fromLTRB(
          left + i * band,
          center.dy - radius * 1.1,
          // Dilimler yarım piksel bindiriliyor: aradaki tırtıklı boşluk
          // yuvarlamadan çıkıyor ve balonu çizgili gösteriyordu.
          left + (i + 1) * band + 0.5,
          neckY + 1,
        ),
        Paint()..color = pattern[i % pattern.length].withValues(alpha: opacity),
      );
    }

    // Dikişler tepe noktasından boyna iniyor; düz çizgi değil, balonun
    // yüzeyini saran mercek eğrisi.
    final seam = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(radius * 0.018, 1)
      ..color = Colors.black.withValues(alpha: opacity * 0.30);

    for (var i = 1; i < count; i++) {
      final f = i / count * 2 - 1;

      canvas.drawPath(
        Path()
          ..moveTo(center.dx, center.dy - radius)
          ..cubicTo(
            center.dx + f * radius * 1.05,
            center.dy - radius * 0.30,
            center.dx + f * radius * 1.05,
            center.dy + radius * 0.70,
            center.dx + f * neckHalf,
            neckY,
          ),
        seam,
      );
    }
  }

  /// Referans balondaki açık mavi yatay bantlar.
  void _paintBands(Canvas canvas, Offset center, double radius, double opacity) {
    for (final at in const [-0.34, 0.30]) {
      final y = center.dy + radius * at;

      canvas.drawRect(
        Rect.fromLTRB(
          center.dx - radius * 1.2,
          y - radius * 0.075,
          center.dx + radius * 1.2,
          y + radius * 0.075,
        ),
        Paint()..color = _bandColor.withValues(alpha: opacity),
      );
    }
  }

  /// Boyun bandı, halatlar ve sepet.
  void _paintRigging(
    Canvas canvas,
    Offset center,
    double radius,
    double neckY,
    double neckHalf,
    Paint outline,
    double opacity,
  ) {
    final collar = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, neckY + radius * 0.09),
        width: neckHalf * 2.2,
        height: radius * 0.20,
      ),
      Radius.circular(radius * 0.03),
    );

    final basket = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, neckY + radius * 0.60),
        width: neckHalf * 1.8,
        height: radius * 0.26,
      ),
      Radius.circular(radius * 0.05),
    );

    final rope = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(radius * 0.022, 1)
      ..color = Colors.black.withValues(alpha: opacity * 0.7);

    canvas
      ..drawLine(
        Offset(collar.left + collar.width * 0.18, collar.bottom),
        Offset(basket.left + basket.width * 0.12, basket.top),
        rope,
      )
      ..drawLine(
        Offset(collar.right - collar.width * 0.18, collar.bottom),
        Offset(basket.right - basket.width * 0.12, basket.top),
        rope,
      )
      ..drawRRect(collar, Paint()..color = _collarColor.withValues(alpha: opacity))
      ..drawRRect(collar, outline)
      ..drawRRect(basket, Paint()..color = _basketColor.withValues(alpha: opacity))
      ..drawRRect(basket, outline);
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
