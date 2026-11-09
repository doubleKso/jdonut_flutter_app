import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_assets.dart';
import '../../../../core/domain/image_ref.dart';
import '../../../../core/images/app_image.dart';
import '../../../../core/motion/app_motion.dart';

/// One pastel circle with a donut, placed by fractions of the hero area.
final class _Circle {
  const _Circle(this.center, this.diameter, this.color, this.image, this.from);

  /// Centre as a fraction of the hero's width and height.
  final Offset center;

  /// Diameter as a fraction of the hero's width.
  final double diameter;
  final Color Function(AppPalette) color;
  final ImageRef image;

  /// Direction the circle drifts in from.
  final Offset from;
}

final List<_Circle> _circles = [
  _Circle(const Offset(0.5, 0.42), 0.52, (p) => p.tilePeach, AppAssets.strawberryDonut, const Offset(0, -1)),
  _Circle(const Offset(0.02, 0.1), 0.38, (p) => p.sky, AppAssets.grapeDonut, const Offset(-1, -0.4)),
  _Circle(const Offset(0.98, 0.16), 0.34, (p) => p.tileSky, AppAssets.chocolateDonut, const Offset(1, -0.4)),
  _Circle(const Offset(0.0, 0.74), 0.3, (p) => p.tileLavender, AppAssets.vanillaDonut, const Offset(-1, 0.3)),
  _Circle(const Offset(1.0, 0.7), 0.3, (p) => p.tileRose, AppAssets.stripedDonut, const Offset(1, 0.3)),
  _Circle(const Offset(0.5, 1.02), 0.42, (p) => p.tileSun, AppAssets.caramelDonut, const Offset(0, 1)),
];

/// The onboarding hero: donut circles drift in one after another, then float.
class DonutCircleCluster extends StatefulWidget {
  const DonutCircleCluster({super.key});

  @override
  State<DonutCircleCluster> createState() => _DonutCircleClusterState();
}

class _DonutCircleClusterState extends State<DonutCircleCluster> with TickerProviderStateMixin {
  static const double _staggerFraction = 0.1;
  static const double _floatDistance = 4;

  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: AppDurations.drift + AppDurations.staggerStep * _circles.length,
  );
  late final AnimationController _float = AnimationController(vsync: this, duration: AppDurations.drift * 3);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _entrance.value = 1;
      _float.stop();
    } else if (!_entrance.isAnimating && !_entrance.isCompleted) {
      _entrance.forward().then((_) => mounted ? _float.repeat(reverse: true) : null);
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => ClipRect(
      child: Stack(
        children: [
          for (final (index, circle) in _circles.indexed) _positioned(context, constraints.biggest, index, circle),
        ],
      ),
    ),
  );

  Widget _positioned(BuildContext context, Size area, int index, _Circle circle) {
    final diameter = area.width * circle.diameter;
    final start = index * _staggerFraction;
    final interval = Interval(start, math.min(1, start + 0.55), curve: AppCurves.entrance);
    return Positioned(
      left: area.width * circle.center.dx - diameter / 2,
      top: area.height * circle.center.dy - diameter / 2,
      width: diameter,
      height: diameter,
      child: AnimatedBuilder(
        animation: Listenable.merge([_entrance, _float]),
        builder: (context, child) => _drift(interval.transform(_entrance.value), index, circle, child!),
        child: _CircleTile(color: circle.color(context.palette), image: circle.image),
      ),
    );
  }

  Widget _drift(double t, int index, _Circle circle, Widget child) {
    final bob = math.sin((_float.value + index / _circles.length) * math.pi * 2) * _floatDistance;
    final offset = circle.from * AppMotionValues.driftOffset * (1 - t) + Offset(0, bob);
    return Opacity(
      opacity: t.clamp(0, 1),
      child: Transform.translate(offset: offset, child: Transform.scale(scale: 0.85 + 0.15 * t, child: child)),
    );
  }
}

class _CircleTile extends StatelessWidget {
  const _CircleTile({required this.color, required this.image});

  final Color color;
  final ImageRef image;

  static const double _donutInset = 0.16;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: LayoutBuilder(
      builder: (context, c) => Padding(
        padding: EdgeInsets.all(c.maxWidth * _donutInset),
        child: AppImage(image),
      ),
    ),
  );
}
