import 'package:flutter/widgets.dart';

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
}
