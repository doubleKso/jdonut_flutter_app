import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

import '../tokens/app_palette.dart';
import '../tokens/app_radii.dart';
import '../tokens/app_typography.dart';

/// Builds the one app theme from the tokens.
abstract final class AppTheme {
  static ThemeData light() {
    const palette = AppPalette.light;
    final textTheme = _textTheme(palette);
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.packagedFontFamily,
      scaffoldBackgroundColor: palette.surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.sky,
        primary: palette.sky,
        secondary: palette.berry,
        tertiary: palette.tangerine,
        surface: palette.surface,
        error: palette.danger,
      ),
      textTheme: textTheme,
      extensions: const [palette],
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: palette.ink,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: palette.onAccent),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.tile),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surface,
        showDragHandle: true,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static TextTheme _textTheme(AppPalette palette) {
    TextStyle ink(TextStyle s) => s.copyWith(
      color: palette.ink,
      fontFamily: AppTypography.fontFamily,
      package: AppTypography.fontPackage,
    );
    return TextTheme(
      displaySmall: ink(AppTypography.display),
      headlineSmall: ink(AppTypography.headline),
      titleLarge: ink(AppTypography.title),
      titleMedium: ink(AppTypography.subtitle),
      bodyLarge: ink(AppTypography.body),
      bodyMedium: ink(AppTypography.bodySmall),
      labelLarge: ink(AppTypography.button),
      labelMedium: ink(AppTypography.label),
      bodySmall: ink(AppTypography.caption),
    );
  }
}
