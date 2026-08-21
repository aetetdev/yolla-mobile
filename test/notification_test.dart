import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/core/models/app_notification.dart';
import 'package:yolla/l10n/app_localizations.dart';
import 'package:yolla/shared/format.dart';

/// `GET /api/v1/bildirimler` yanıtından bir satır.
const _onaylananFotograf = {
  'id': 12,
  'kind': 'PhotoApproved',
  'title': 'Fotoğrafın yayında',
  'body': 'Anıtkabir için gönderdiğin fotoğraf yayına girdi. 25 coin kazandın.',
  'placeId': 4472,
  'isRead': false,
  'createdAt': '2026-08-20T09:15:00+00:00',
};

/// Metni ekrana çizmeden [Format.relativeTime] çağırabilmek için bir kabuk.
Future<String> _relative(WidgetTester tester, DateTime time) async {
  late String result;

  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.supportedLocales,
      home: Builder(
        builder: (context) {
          result = Format.relativeTime(context, time);
          return const SizedBox.shrink();
        },
      ),
    ),
  );

  return result;
}

void main() {
  group('AppNotification', () {
    test('sunucu gövdesi çözümlenebiliyor', () {
      final notification = AppNotification.fromJson(
        Map<String, dynamic>.from(_onaylananFotograf),
      );

      expect(notification.id, 12);
      expect(notification.kind, NotificationKind.photoApproved);
      expect(notification.placeId, 4472);
      expect(notification.isRead, isFalse);
      expect(notification.createdAt.isUtc, isTrue);
    });

    test('yer taşımayan bildirim çözümlenebiliyor', () {
      final notification = AppNotification.fromJson({
        ...Map<String, dynamic>.from(_onaylananFotograf),
        'kind': 'PhotoRejected',
        'placeId': null,
      });

      expect(notification.placeId, isNull);
      expect(notification.kind.isRejection, isTrue);
    });

    test('bilinmeyen tür çökmüyor', () {
      // Sunucuya yeni bir tür eklendiğinde mağazadaki eski sürüm listeyi
      // açamaz hale gelmemeli: bilinmeyen değer `unknown`'a düşüyor.
      final notification = AppNotification.fromJson({
        ...Map<String, dynamic>.from(_onaylananFotograf),
        'kind': 'TripReminder',
      });

      expect(notification.kind, NotificationKind.unknown);
      expect(notification.kind.isRejection, isFalse);
    });
  });

  group('Format.relativeTime', () {
    testWidgets('bir dakikadan yenisi "az önce"', (tester) async {
      final metin = await _relative(
        tester,
        DateTime.now().subtract(const Duration(seconds: 20)),
      );

      expect(metin, 'az önce');
    });

    testWidgets('sunucu saati ileri olsa da eksi süre yazmıyor', (
      tester,
    ) async {
      final metin = await _relative(
        tester,
        DateTime.now().add(const Duration(seconds: 30)),
      );

      expect(metin, 'az önce');
    });

    testWidgets('saat ve gün ölçeğinde sayı veriyor', (tester) async {
      expect(
        await _relative(
          tester,
          DateTime.now().subtract(const Duration(minutes: 12)),
        ),
        '12 dk önce',
      );
      expect(
        await _relative(
          tester,
          DateTime.now().subtract(const Duration(hours: 3)),
        ),
        '3 sa önce',
      );
      expect(
        await _relative(
          tester,
          DateTime.now().subtract(const Duration(days: 2)),
        ),
        '2 gün önce',
      );
    });

    testWidgets('bir haftadan eskisi tarih olarak yazılıyor', (tester) async {
      final metin = await _relative(tester, DateTime(2026, 1, 14));

      // "23 gün önce" okuyanı saydırıyor; o noktada tarihin kendisi anlaşılır.
      expect(metin, contains('2026'));
      expect(metin, isNot(contains('önce')));
    });
  });
}
