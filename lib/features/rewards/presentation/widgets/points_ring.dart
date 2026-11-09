import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/formatting/mmk_format.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../l10n/l10n.dart';

/// The sprinkled donut ring. On entry it sweeps from 0 to [progress] while
/// the total in the middle counts up to [totalPoints].
class PointsRing extends StatelessWidget {
  const PointsRing({required this.progress, required this.totalPoints, super.key});

  /// 0..1 progress towards the next tier.
  final double progress;
  final int totalPoints;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: context.motion(AppDurations.pointsSweep),
      curve: AppCurves.sweep,
      builder: (context, t, _) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: PointsRingPainter(
                progress: progress * t,
                track: palette.track,
                ring: palette.berry,
                ringLight: palette.berrySoft,
                sprinkle: palette.surface,
                centre: palette.surface,
              ),
            ),
          ),
          _Total(points: (totalPoints * t).round()),
        ],
      ),
    );
  }
}

class _Total extends StatelessWidget {
  const _Total({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    final berry = context.palette.berry;
    return Semantics(
      label: '${context.l10n.totalPoints} ${formatCount(points)}',
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.l10n.totalPoints, style: context.text.labelMedium?.copyWith(color: berry)),
          FittedBox(
            child: Text(formatCount(points), style: AppTypography.figure.copyWith(color: berry)),
          ),
        ],
      ),
    );
  }
}

/// Track, gradient arc with round caps, sprinkles along the filled part, and
/// the white centre.
class PointsRingPainter extends CustomPainter {
  const PointsRingPainter({
    required this.progress,
    required this.track,
    required this.ring,
    required this.ringLight,
    required this.sprinkle,
    required this.centre,
  });

  final double progress;
  final Color track;
  final Color ring;
  final Color ringLight;
  final Color sprinkle;
  final Color centre;

  static const double _strokeFraction = 0.24;
  static const double _startAngle = math.pi * 0.75;
  static const int _sprinkleCount = 22;
  static const double _sprinkleAlpha = 0.75;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * _strokeFraction;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(center, radius, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = track);
    if (progress > 0) _paintArc(canvas, rect, stroke);
    _paintSprinkles(canvas, center, radius, stroke);
    canvas.drawCircle(center, radius - stroke / 2, Paint()..color = centre);
  }

  void _paintArc(Canvas canvas, Rect rect, double stroke) {
    final sweep = math.pi * 2 * progress;
    canvas.drawArc(
      rect,
      _startAngle,
      sweep,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: 0,
          endAngle: math.pi * 2,
          colors: [ring, ringLight, ring],
          transform: const GradientRotation(_startAngle),
        ).createShader(rect),
    );
  }

  /// Short tangential strokes, only on the part of the ring already filled.
  void _paintSprinkles(Canvas canvas, Offset center, double radius, double stroke) {
    final paint = Paint()
      ..color = sprinkle.withValues(alpha: _sprinkleAlpha)
      ..strokeWidth = stroke * 0.07
      ..strokeCap = StrokeCap.round;
    final filled = math.pi * 2 * progress;
    for (var i = 0; i < _sprinkleCount; i++) {
      final along = math.pi * 2 * (i + 0.5) / _sprinkleCount;
      if (along > filled) break;
      final wobble = ((i * 37) % 7 - 3) / 10;
      final angle = _startAngle + along;
      final at = center + Offset(math.cos(angle), math.sin(angle)) * (radius + stroke * wobble * 0.6);
      final tilt = angle + math.pi / 2 + wobble;
      final half = Offset(math.cos(tilt), math.sin(tilt)) * stroke * 0.12;
      canvas.drawLine(at - half, at + half, paint);
    }
  }

  @override
  bool shouldRepaint(PointsRingPainter old) =>
      old.progress != progress || old.ring != ring || old.track != track;
}
