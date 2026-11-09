import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/images/app_image.dart';
import '../../../../core/motion/app_motion.dart';
import '../../domain/entities/challenge.dart';

/// A challenge's artwork with its progress drawn in, animating from empty.
class ChallengeArtwork extends StatelessWidget {
  const ChallengeArtwork({required this.challenge, super.key});

  final Challenge challenge;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: challenge.fraction),
    duration: context.motion(AppDurations.pointsSweep),
    curve: AppCurves.sweep,
    builder: (context, fraction, _) => switch (challenge.art) {
      ChallengeArt.donut => _DonutQuarters(challenge: challenge, fraction: fraction),
      ChallengeArt.arc => _ArcOverImage(challenge: challenge, fraction: fraction),
    },
  );
}

/// The donut colours in clockwise from 12 o'clock — a quarter per donut
/// eaten in "Eat 4": the rest stays grey.
class _DonutQuarters extends StatelessWidget {
  const _DonutQuarters({required this.challenge, required this.fraction});

  final Challenge challenge;
  final double fraction;

  /// Greyscale that also lifts the tone, so the unearned part reads as pale.
  static const List<double> _paleGrey = [
    0.11, 0.36, 0.04, 0, 128, //
    0.11, 0.36, 0.04, 0, 128, //
    0.11, 0.36, 0.04, 0, 128, //
    0, 0, 0, 1, 0, //
  ];

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      ColorFiltered(colorFilter: const ColorFilter.matrix(_paleGrey), child: AppImage(challenge.image)),
      ClipPath(clipper: _PieClipper(fraction), child: AppImage(challenge.image)),
    ],
  );
}

class _PieClipper extends CustomClipper<Path> {
  const _PieClipper(this.fraction);

  final double fraction;

  @override
  Path getClip(Size size) {
    final center = size.center(Offset.zero);
    final rect = Rect.fromCircle(center: center, radius: size.longestSide);
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, -math.pi / 2, math.pi * 2 * fraction, false)
      ..close();
  }

  @override
  bool shouldReclip(_PieClipper old) => old.fraction != fraction;
}

/// An arc over the cup fills as cups are drunk (9/12).
class _ArcOverImage extends StatelessWidget {
  const _ArcOverImage({required this.challenge, required this.fraction});

  final Challenge challenge;
  final double fraction;

  static const double _imageFraction = 0.78;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned.fill(
        child: CustomPaint(painter: _ArcPainter(fraction, track: context.palette.track, fill: context.palette.tangerine)),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(heightFactor: _imageFraction, child: AppImage(challenge.image)),
      ),
    ],
  );
}

class _ArcPainter extends CustomPainter {
  const _ArcPainter(this.fraction, {required this.track, required this.fill});

  final double fraction;
  final Color track;
  final Color fill;

  static const double _start = math.pi * 0.9;
  static const double _sweep = math.pi * 1.2;
  static const double _strokeFraction = 0.09;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * _strokeFraction;
    final rect = Rect.fromCircle(center: size.center(Offset.zero), radius: (size.shortestSide - stroke) / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, _start, _sweep, false, paint..color = track);
    if (fraction > 0) canvas.drawArc(rect, _start, _sweep * fraction, false, paint..color = fill);
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.fraction != fraction;
}
