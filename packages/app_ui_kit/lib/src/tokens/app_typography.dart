import 'package:flutter/material.dart';

/// Type scale. Colour is applied by the theme, so these carry size and weight.
abstract final class AppTypography {
  static const String fontFamily = 'Poppins';
  static const String fontPackage = 'app_ui_kit';

  /// How a font bundled in a package is named from outside it.
  static const String packagedFontFamily = 'packages/$fontPackage/$fontFamily';

  static const TextStyle display = TextStyle(
    fontSize: 28,
    height: 1.2,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle headline = TextStyle(
    fontSize: 22,
    height: 1.25,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle title = TextStyle(
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle body = TextStyle(
    fontSize: 15,
    height: 1.45,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle label = TextStyle(
    fontSize: 13,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle button = TextStyle(
    fontSize: 13,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.6,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );

  /// The big count-up figure in the points ring.
  static const TextStyle figure = TextStyle(
    fontSize: 30,
    height: 1.1,
    fontWeight: FontWeight.w800,
  );
}
