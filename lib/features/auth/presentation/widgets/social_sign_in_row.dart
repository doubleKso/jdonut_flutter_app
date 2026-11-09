import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/coming_soon_sheet.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../l10n/l10n.dart';

/// Google, Apple and Facebook. No real integration: each opens a sheet.
class SocialSignInRow extends StatelessWidget {
  const SocialSignInRow({super.key});

  static const double _iconSize = 26;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(context, 'Google', const CustomPaint(painter: _GoogleGlyphPainter(), size: Size.square(_iconSize))),
        _button(context, 'Apple', Icon(Icons.apple, size: _iconSize + 2, color: palette.ink)),
        _button(context, 'Facebook', Icon(Icons.facebook, size: _iconSize, color: palette.facebook)),
      ],
    );
  }

  Widget _button(BuildContext context, String provider, Widget glyph) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    child: PressableScale(
      semanticLabel: provider,
      onTap: () => showComingSoonSheet(context, context.l10n.socialSignInUnavailable(provider)),
      child: Padding(padding: const EdgeInsets.all(AppSpacing.sm), child: glyph),
    ),
  );
}

/// A four-colour "G", drawn so no brand bitmap is needed.
class _GoogleGlyphPainter extends CustomPainter {
  const _GoogleGlyphPainter();

  static const double _strokeFraction = 0.2;

  @override
  void paint(Canvas canvas, Size size) {
    const palette = AppPalette.light;
    final stroke = size.shortestSide * _strokeFraction;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    void arc(double startDegrees, double sweepDegrees, Color color) => canvas.drawArc(
      rect,
      startDegrees * math.pi / 180,
      sweepDegrees * math.pi / 180,
      false,
      paint..color = color,
    );
    arc(-40, -95, palette.googleRed);
    arc(-135, -90, palette.googleYellow);
    arc(135, -90, palette.googleGreen);
    arc(45, -45, palette.googleBlue);
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2, size.height / 2 - stroke / 2, size.width / 2, stroke),
      Paint()..color = palette.googleBlue,
    );
  }

  @override
  bool shouldRepaint(_GoogleGlyphPainter oldDelegate) => false;
}
