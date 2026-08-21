import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Kullanıcıya gösterilen sayı ve süre biçimleri.
abstract final class Format {
  /// "2 sa 15 dk" · "45 dk" · "1 dk'dan az"
  ///
  /// Dile bağlı olduğu için [context] alıyor.
  static String duration(BuildContext context, Duration duration) {
    final l10n = L10n.of(context);
    if (duration.inMinutes < 1) return l10n.durationLessThanMinute;

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours == 0) return l10n.durationMinutes(minutes);
    if (minutes == 0) return l10n.durationHours(hours);
    return l10n.durationHoursMinutes(hours, minutes);
  }

  /// "12,4 km" · "840 m"
  ///
  /// Türkçede ondalık ayırıcı virgül; İngilizcede nokta.
  static String distance(BuildContext context, double meters) {
    if (meters < 950) return '${meters.round()} m';

    final value = (meters / 1000).toStringAsFixed(1);
    final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return '${isTurkish ? value.replaceAll('.', ',') : value} km';
  }

  /// "az önce" · "12 dk önce" · "3 sa önce" · "2 gün önce" · "20.08.2026"
  ///
  /// Bir haftadan eskisini "23 gün önce" diye anlatmak okuyanı saydırıyor;
  /// o noktada tarihin kendisi daha anlaşılır.
  ///
  /// Tarih biçimi [MaterialLocalizations]'tan geliyor — `intl`'in
  /// `DateFormat`'ı Türkçe için ayrıca yerel veri yüklenmesini istiyor,
  /// tek satırlık iş için o kurulum fazla.
  static String relativeTime(BuildContext context, DateTime time) {
    final l10n = L10n.of(context);
    final local = time.toLocal();

    // Sunucu saati birkaç saniye ileride olabilir; eksi fark "az önce"ye
    // düşüyor, "-1 dk önce" yazmıyor.
    final elapsed = DateTime.now().difference(local);

    if (elapsed.inMinutes < 1) return l10n.timeJustNow;
    if (elapsed.inHours < 1) return l10n.timeMinutesAgo(elapsed.inMinutes);
    if (elapsed.inDays < 1) return l10n.timeHoursAgo(elapsed.inHours);
    if (elapsed.inDays < 7) return l10n.timeDaysAgo(elapsed.inDays);

    return MaterialLocalizations.of(context).formatShortDate(local);
  }
}
