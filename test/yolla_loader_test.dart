import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/l10n/app_localizations.dart';
import 'package:yolla/shared/widgets/yolla_loader.dart';

/// Göstergeyi bir uygulama kabuğunun içine koyar; [L10n] olmadan çizilemiyor.
Widget _host(Widget child, {bool disableAnimations = false}) {
  return MaterialApp(
    locale: const Locale('tr'),
    localizationsDelegates: const [
      L10n.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: L10n.supportedLocales,
    home: Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(disableAnimations: disableAnimations),
        child: Scaffold(body: child),
      ),
    ),
  );
}

void main() {
  group('YollaLoader', () {
    testWidgets('döngü boyunca hata vermeden çizer', (tester) async {
      await tester.pumpWidget(_host(const YollaLoader()));

      // Döngünün üç evresi de (çizim, iğne, savrulma) bir kere geçsin.
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }

      expect(tester.takeException(), isNull);
      expect(find.byType(YollaLoader), findsOneWidget);
    });

    testWidgets('ekran okuyucuya yükleniyor diye bildirilir', (tester) async {
      await tester.pumpWidget(_host(const YollaLoader()));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.bySemanticsLabel('Yükleniyor'), findsOneWidget);
    });

    testWidgets('etiket verilince altında gösterilir', (tester) async {
      await tester.pumpWidget(_host(const YollaLoader(label: 'Rota çıkarılıyor')));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Rota çıkarılıyor'), findsOneWidget);
    });

    testWidgets('hareket azaltma açıkken animasyon çalışmaz', (tester) async {
      await tester.pumpWidget(
        _host(const YollaLoader(), disableAnimations: true),
      );
      await tester.pump(const Duration(milliseconds: 100));

      // Denetleyici durmuşsa bekleyen kare kalmaz; `pumpAndSettle` sonsuz
      // animasyonda zaman aşımına düşerdi.
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
