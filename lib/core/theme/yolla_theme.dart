import 'package:flutter/material.dart';

import 'yolla_colors.dart';
import 'yolla_tokens.dart';
import 'yolla_typography.dart';

/// Uygulama teması. Açık ve koyu tema aynı token'lardan üretilir.
abstract final class YollaTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final background = isDark ? YollaColors.backgroundDark : YollaColors.background;
    final surface = isDark ? YollaColors.surfaceDark : YollaColors.surface;
    final surfaceMuted = isDark ? YollaColors.surfaceMutedDark : YollaColors.surfaceMuted;
    final border = isDark ? YollaColors.borderDark : YollaColors.border;
    final ink = isDark ? YollaColors.inkDark : YollaColors.ink;
    final inkMuted = isDark ? YollaColors.inkMutedDark : YollaColors.inkMuted;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: YollaColors.brand,
      onPrimary: Colors.white,
      primaryContainer: isDark ? YollaColors.brandDark : YollaColors.brandSoft,
      onPrimaryContainer: isDark ? Colors.white : YollaColors.brandDark,
      secondary: YollaColors.accent,
      onSecondary: Colors.white,
      secondaryContainer: isDark ? YollaColors.accent : YollaColors.accentSoft,
      onSecondaryContainer: isDark ? Colors.white : YollaColors.accent,
      error: YollaColors.danger,
      onError: Colors.white,
      surface: surface,
      onSurface: ink,
      surfaceContainerHighest: surfaceMuted,
      onSurfaceVariant: inkMuted,
      outline: border,
      outlineVariant: border,
    );

    final textTheme = TextTheme(
      displaySmall: YollaText.display,
      headlineSmall: YollaText.title,
      titleMedium: YollaText.subtitle,
      bodyMedium: YollaText.body,
      bodySmall: YollaText.caption,
      labelSmall: YollaText.micro,
    ).apply(bodyColor: ink, displayColor: ink);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: YollaText.subtitle.copyWith(color: ink),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.lg),
          side: BorderSide(color: border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          textStyle: YollaText.subtitle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: ink,
          side: BorderSide(color: border),
          textStyle: YollaText.subtitle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.md),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: YollaColors.brand,
          textStyle: YollaText.caption,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: YollaText.body.copyWith(color: YollaColors.inkFaint),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Space.lg,
          vertical: Space.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: const BorderSide(color: YollaColors.brand, width: 1.6),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceMuted,
        side: BorderSide.none,
        labelStyle: YollaText.caption.copyWith(color: ink),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(
          horizontal: Space.md,
          vertical: Space.sm,
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? YollaColors.surfaceMutedDark : YollaColors.ink,
        contentTextStyle: YollaText.caption.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.md),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: YollaColors.brand,
      ),
    );
  }
}
