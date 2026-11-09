import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../l10n/l10n.dart';

/// The registration progress ring. It tweens to each new step (25% → 50% →
/// 75% → 100%) and, once full, morphs into a check.
class StepProgressRing extends StatelessWidget {
  const StepProgressRing({required this.step, required this.totalSteps, super.key});

  final int step;
  final int totalSteps;

  static const double size = 28;

  @override
  Widget build(BuildContext context) {
    final complete = step >= totalSteps;
    final label = complete
        ? context.l10n.stepsComplete
        : context.l10n.stepProgress(step, totalSteps);
    return Semantics(
      label: label,
      child: SizedBox.square(
        dimension: size,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: step / totalSteps),
          duration: context.motion(AppDurations.ringStep),
          curve: AppCurves.standard,
          builder: (context, progress, _) => AnimatedSwitcher(
            duration: context.motion(AppDurations.morph),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: CurvedAnimation(parent: animation, curve: AppCurves.emphasized),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: complete && progress >= 1
                ? const _CheckBadge(key: ValueKey('check'))
                : CustomPaint(
                    key: const ValueKey('ring'),
                    size: const Size.square(size),
                    painter: _RingPainter(
                      progress: progress,
                      track: context.palette.platinum,
                      fill: context.palette.berry,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress, required this.track, required this.fill});

  final double progress;
  final Color track;
  final Color fill;

  static const double _strokeFraction = 0.2;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * _strokeFraction;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawArc(rect, 0, math.pi * 2, false, paint..color = track);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * progress, false, paint..color = fill);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.track != track || old.fill != fill;
}

class _CheckBadge extends StatelessWidget {
  const _CheckBadge({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: context.palette.berry, shape: BoxShape.circle),
    child: Icon(Icons.check_rounded, size: AppSpacing.lg, color: context.palette.onAccent),
  );
}
