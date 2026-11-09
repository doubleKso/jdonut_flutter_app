import 'package:flutter/material.dart';

/// Every colour the app uses, as a theme extension so widgets read them from
/// the theme (`context.palette`) instead of hard-coding values.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.sky,
    required this.skyDeep,
    required this.berry,
    required this.berrySoft,
    required this.tangerine,
    required this.grape,
    required this.peach,
    required this.blushTop,
    required this.blushBottom,
    required this.mist,
    required this.surface,
    required this.ink,
    required this.slate,
    required this.fog,
    required this.pebble,
    required this.leaf,
    required this.silver,
    required this.gold,
    required this.platinum,
    required this.track,
    required this.danger,
    required this.shadow,
    required this.onAccent,
    required this.tileSky,
    required this.tilePeach,
    required this.tileLavender,
    required this.tileSun,
    required this.tileRose,
    required this.googleBlue,
    required this.googleRed,
    required this.googleYellow,
    required this.googleGreen,
    required this.facebook,
  });

  /// Primary actions, the bottom nav bar, the shops section.
  final Color sky;
  final Color skyDeep;

  /// Links, the active nav pill, the points ring, the progress ring.
  final Color berry;
  final Color berrySoft;

  /// Badges, the notification bell, the Rewards pill.
  final Color tangerine;
  final Color grape;
  final Color peach;

  /// The pink gradient behind onboarding and registration.
  final Color blushTop;
  final Color blushBottom;

  /// The cool grey page behind Home, Product detail and the Rewards cards.
  final Color mist;
  final Color surface;

  /// Text: primary, secondary and hint.
  final Color ink;
  final Color slate;
  final Color fog;

  /// Disabled fills (an incomplete challenge's EARN button).
  final Color pebble;
  final Color leaf;
  final Color silver;
  final Color gold;
  final Color platinum;

  /// Unfilled part of rings and progress lines.
  final Color track;
  final Color danger;
  final Color shadow;

  /// Text and icons on a coloured fill.
  final Color onAccent;

  /// Soft backgrounds of the donut circles and tiles (onboarding, Welcome).
  final Color tileSky;
  final Color tilePeach;
  final Color tileLavender;
  final Color tileSun;
  final Color tileRose;

  /// Brand colours of the social sign-in glyphs.
  final Color googleBlue;
  final Color googleRed;
  final Color googleYellow;
  final Color googleGreen;
  final Color facebook;

  static const light = AppPalette(
    sky: Color(0xFF58CEEB),
    skyDeep: Color(0xFF2BB3D6),
    berry: Color(0xFFEF4F95),
    berrySoft: Color(0xFFF7A8CB),
    tangerine: Color(0xFFFF7A1C),
    grape: Color(0xFF6C5FC7),
    peach: Color(0xFFFCE4D3),
    blushTop: Color(0xFFFBE3EE),
    blushBottom: Color(0xFFF8F4F8),
    mist: Color(0xFFEAF0F0),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1D1D27),
    slate: Color(0xFF6E6E78),
    fog: Color(0xFFA6A6AE),
    pebble: Color(0xFFE6E6E6),
    leaf: Color(0xFF7CB342),
    silver: Color(0xFFB9BCC2),
    gold: Color(0xFFF2CF6E),
    platinum: Color(0xFF9ED9EE),
    track: Color(0xFFE6ECEC),
    danger: Color(0xFFE53950),
    shadow: Color(0x1F1D1D27),
    onAccent: Color(0xFFFFFFFF),
    tileSky: Color(0xFFBDE7F3),
    tilePeach: Color(0xFFF6DCC4),
    tileLavender: Color(0xFFD3CCF5),
    tileSun: Color(0xFFFFCF8A),
    tileRose: Color(0xFFF9C9DA),
    googleBlue: Color(0xFF4285F4),
    googleRed: Color(0xFFEA4335),
    googleYellow: Color(0xFFFBBC05),
    googleGreen: Color(0xFF34A853),
    facebook: Color(0xFF1877F2),
  );

  @override
  AppPalette copyWith({Color? sky, Color? berry, Color? tangerine}) => AppPalette(
    sky: sky ?? this.sky,
    skyDeep: skyDeep,
    berry: berry ?? this.berry,
    berrySoft: berrySoft,
    tangerine: tangerine ?? this.tangerine,
    grape: grape,
    peach: peach,
    blushTop: blushTop,
    blushBottom: blushBottom,
    mist: mist,
    surface: surface,
    ink: ink,
    slate: slate,
    fog: fog,
    pebble: pebble,
    leaf: leaf,
    silver: silver,
    gold: gold,
    platinum: platinum,
    track: track,
    danger: danger,
    shadow: shadow,
    onAccent: onAccent,
    tileSky: tileSky,
    tilePeach: tilePeach,
    tileLavender: tileLavender,
    tileSun: tileSun,
    tileRose: tileRose,
    googleBlue: googleBlue,
    googleRed: googleRed,
    googleYellow: googleYellow,
    googleGreen: googleGreen,
    facebook: facebook,
  );

  @override
  AppPalette lerp(AppPalette? other, double t) => other == null || t < 0.5 ? this : other;
}
