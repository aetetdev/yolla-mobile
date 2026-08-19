import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/yolla_colors.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';

/// Yolla'nın yükleniyor göstergesi: kart destesi ve üstünde kendini çizen rota.
///
/// Marka ikonunun hareketli hali. GIF yerine `CustomPainter` tercih edildi;
/// GIF'in 256 renk paleti marka turuncusunun geçişlerini bantlıyor, alfa kanalı
/// tek bit olduğu için kağıt zeminde kenarları tırtıklı çıkıyor ve sabit piksel
/// boyutu yüksek yoğunluklu ekranlarda bulanıklaşıyordu. Vektör çizim her
/// boyutta keskin kalıyor, tema renklerini alıyor ve yeni bağımlılık istemiyor.
///
/// Rotanın kendini çizmesi [ui.PathMetric.extractPath] ile yapılıyor: yolun
/// tamamı bir kere kurulup her karede baştan `uzunluk * t` kadarı kesiliyor.
///
/// Hareketi azaltma ayarı açıksa ([MediaQueryData.disableAnimations]) animasyon
/// çalışmaz, rotası tamamlanmış tek bir kare gösterilir.
class YollaLoader extends StatefulWidget {
  const YollaLoader({this.size = 104, this.label, super.key});

  /// Görselin kenar uzunluğu. Deste bu kutunun içine sığar.
  final double size;

  /// Altında gösterilecek metin. Verilmezse yalnızca görsel çizilir;
  /// ekran okuyucuya yine "yükleniyor" bildirilir.
  final String? label;

  /// Ekranın tamamını kaplayan ortalanmış hali.
  static Widget centered({double size = 104, String? label}) =>
      Center(child: YollaLoader(size: size, label: label));

  @override
  State<YollaLoader> createState() => _YollaLoaderState();
}

class _YollaLoaderState extends State<YollaLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Hareketi azaltma ayarı çalışırken değişebilir; denetleyiciyi ona göre
    // durdurup başlatıyoruz.
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion && _controller.isAnimating) {
      _controller.stop();
    } else if (!reduceMotion && !_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final visual = SizedBox(
      width: widget.size,
      height: widget.size,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _DeckLoaderPainter(
                // Hareket kapalıysa rotanın tamamlandığı kareyi göster.
                progress: reduceMotion ? 0.62 : _controller.value,
                cardColor: isDark
                    ? YollaColors.surfaceMutedDark
                    : YollaColors.surface,
                // Arkadaki kartlar ön kartla aynı beyaz olursa kağıt zeminde
                // kayboluyor; deste tek kart gibi görünüyordu.
                stackColor: isDark
                    ? YollaColors.borderDark
                    : YollaColors.surfaceMuted,
                cardBorder: isDark
                    ? YollaColors.borderDark
                    : YollaColors.border,
                routeColor: YollaColors.brand,
                pinColor: YollaColors.brand,
              ),
            );
          },
        ),
      ),
    );

    final label = widget.label;

    return Semantics(
      label: label ?? L10n.of(context).loading,
      // Deste sürekli döndüğü için her kareyi okumasın diye tek düğüm.
      excludeSemantics: true,
      child: label == null
          ? visual
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                visual,
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: YollaText.caption.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
    );
  }
}

/// Destenin tek karesini çizer.
///
/// Döngü üç bölüme ayrılır:
/// * `0.00 – 0.58` öndeki kartın rotası çizilir,
/// * `0.58 – 0.70` iğne yerine oturur ve kısa bir duraklama olur,
/// * `0.70 – 1.00` ön kart sağa savrulur, arkadakiler bir basamak öne gelir.
///
/// Döngü sonunda deste başlangıçtaki diziliminin aynısına döner, bu yüzden
/// tekrar ederken sıçrama görünmez.
class _DeckLoaderPainter extends CustomPainter {
  _DeckLoaderPainter({
    required this.progress,
    required this.cardColor,
    required this.stackColor,
    required this.cardBorder,
    required this.routeColor,
    required this.pinColor,
  });

  final double progress;
  final Color cardColor;
  final Color stackColor;
  final Color cardBorder;
  final Color routeColor;
  final Color pinColor;

  static const _drawEnd = 0.58;
  static const _holdEnd = 0.70;

  /// Destedeki kart sayısı. Üç kart derinlik hissi için yeterli; dördüncüsü
  /// bu boyutta birbirine giriyor.
  static const _cardCount = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height);
    final origin = Offset(
      (size.width - side) / 2,
      (size.height - side) / 2,
    );

    canvas.save();
    canvas.translate(origin.dx, origin.dy);

    // Savrulma evresinin kendi içindeki ilerlemesi.
    final exit = progress <= _holdEnd
        ? 0.0
        : Curves.easeInCubic.transform(
            (progress - _holdEnd) / (1 - _holdEnd),
          );

    // Arkadan öne çiz: en arkadaki en soluk.
    for (var depth = _cardCount - 1; depth >= 0; depth--) {
      // Kartlar savrulma boyunca bir basamak öne kayar.
      final slot = depth - exit;

      if (depth == 0) {
        _paintFrontCard(canvas, side, exit);
      } else {
        _paintStackedCard(canvas, side, slot);
      }
    }

    canvas.restore();
  }

  /// Arkadaki kartlar: sola-aşağı kayık, küçültülmüş ve soluk.
  void _paintStackedCard(Canvas canvas, double side, double slot) {
    final shift = side * 0.078 * slot;
    final scale = 1 - 0.07 * slot;
    final opacity = (1 - 0.22 * slot).clamp(0.0, 1.0);

    canvas.save();
    canvas.translate(-shift, shift * 0.5);

    final rect = _cardRect(side);
    canvas.translate(rect.center.dx, rect.center.dy);
    canvas.scale(scale);
    canvas.translate(-rect.center.dx, -rect.center.dy);

    _drawCardShape(canvas, rect, opacity, fill: stackColor);
    canvas.restore();
  }

  /// Öndeki kart: rotayı taşır, döngü sonunda sağa savrulur.
  void _paintFrontCard(Canvas canvas, double side, double exit) {
    final rect = _cardRect(side);

    canvas.save();

    if (exit > 0) {
      // Savrulurken hafifçe döner; kaydırma jestinin his olarak karşılığı.
      final dx = side * 1.15 * exit;
      final angle = 0.34 * exit;
      canvas.translate(rect.center.dx + dx, rect.center.dy);
      canvas.rotate(angle);
      canvas.translate(-rect.center.dx, -rect.center.dy);
    }

    final opacity = (1 - exit * 1.35).clamp(0.0, 1.0);
    if (opacity <= 0) {
      canvas.restore();
      return;
    }

    _drawCardShape(canvas, rect, opacity);

    // Rota yalnızca çizim ve bekleme evrelerinde ilerler; savrulurken tamdır.
    final drawT = progress >= _drawEnd
        ? 1.0
        : Curves.easeInOutCubic.transform(progress / _drawEnd);

    _drawRoute(canvas, rect, drawT, opacity);

    canvas.restore();
  }

  /// Kartın kutusu. Dikey, ikondaki oranla aynı.
  Rect _cardRect(double side) {
    final width = side * 0.50;
    final height = side * 0.70;
    return Rect.fromLTWH(
      (side - width) / 2 + side * 0.045,
      (side - height) / 2,
      width,
      height,
    );
  }

  void _drawCardShape(
    Canvas canvas,
    Rect rect,
    double opacity, {
    Color? fill,
  }) {
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(rect.width * 0.17),
    );

    canvas
      ..drawRRect(
        rrect,
        Paint()..color = (fill ?? cardColor).withValues(alpha: opacity),
      )
      ..drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(rect.width * 0.012, 0.7)
          ..color = cardBorder.withValues(alpha: opacity),
      );
  }

  /// Kartın üstündeki yılankavi rota ve ucundaki iğne.
  void _drawRoute(Canvas canvas, Rect card, double t, double opacity) {
    final path = _routePath(card);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;

    final metric = metrics.first;
    final drawn = metric.extractPath(0, metric.length * t);

    final strokeWidth = math.max(card.width * 0.075, 1.4);

    canvas.drawPath(
      drawn,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = routeColor.withValues(alpha: opacity),
    );

    // Başlangıç noktası: rota belirir belirmez görünsün.
    if (t > 0.02) {
      final start = metric.getTangentForOffset(0)!.position;
      canvas.drawCircle(
        start,
        strokeWidth * 0.62,
        Paint()..color = routeColor.withValues(alpha: opacity),
      );
    }

    // İğne yolun ucuna varınca oturur; varmadan önce görünmez.
    if (t >= 0.999) {
      final pinT = progress <= _drawEnd
          ? 0.0
          : ((progress - _drawEnd) / (_holdEnd - _drawEnd)).clamp(0.0, 1.0);
      _drawPin(
        canvas,
        metric.getTangentForOffset(metric.length)!.position,
        card.width * 0.20,
        Curves.easeOutBack.transform(pinT),
        opacity,
      );
    }
  }

  /// İkondaki S kıvrımı, kart kutusuna göre oranlanmış.
  Path _routePath(Rect c) {
    Offset p(double x, double y) =>
        Offset(c.left + c.width * x, c.top + c.height * y);

    return Path()
      ..moveTo(p(0.20, 0.94).dx, p(0.20, 0.94).dy)
      ..cubicTo(
        p(0.16, 0.72).dx, p(0.16, 0.72).dy, //
        p(0.66, 0.70).dx, p(0.66, 0.70).dy,
        p(0.60, 0.50).dx, p(0.60, 0.50).dy,
      )
      ..cubicTo(
        p(0.55, 0.34).dx, p(0.55, 0.34).dy, //
        p(0.30, 0.36).dx, p(0.30, 0.36).dy,
        p(0.44, 0.22).dx, p(0.44, 0.22).dy,
      );
  }

  /// Konum iğnesi: damla gövde ve içindeki delik.
  void _drawPin(
    Canvas canvas,
    Offset tip,
    double height,
    double scale,
    double opacity,
  ) {
    if (scale <= 0) return;

    canvas.save();
    canvas.translate(tip.dx, tip.dy);
    canvas.scale(scale.clamp(0.0, 1.4));

    final r = height * 0.36;
    final centerY = -height * 0.62;

    final body = Path()
      ..addOval(Rect.fromCircle(center: Offset(0, centerY), radius: r))
      ..moveTo(-r * 0.72, centerY + r * 0.62)
      ..quadraticBezierTo(-r * 0.30, centerY + r * 1.5, 0, 0)
      ..quadraticBezierTo(r * 0.30, centerY + r * 1.5, r * 0.72, centerY + r * 0.62)
      ..close();

    canvas
      ..drawPath(body, Paint()..color = pinColor.withValues(alpha: opacity))
      ..drawCircle(
        Offset(0, centerY),
        r * 0.38,
        Paint()..color = cardColor.withValues(alpha: opacity),
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_DeckLoaderPainter old) =>
      old.progress != progress ||
      old.cardColor != cardColor ||
      old.stackColor != stackColor ||
      old.routeColor != routeColor;
}
