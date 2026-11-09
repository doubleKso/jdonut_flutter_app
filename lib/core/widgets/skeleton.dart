import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../motion/app_motion.dart';

/// Sweeps a soft highlight across its [child] — the loading skeleton look.
/// With Reduce Motion on, the skeleton stays still.
class Shimmer extends StatefulWidget {
  const Shimmer({required this.child, super.key});

  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.shimmer,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          colors: [palette.track, palette.surface, palette.track],
          stops: const [0.25, 0.5, 0.75],
          begin: Alignment(-2 + _controller.value * 4, 0),
          end: Alignment(-1 + _controller.value * 4, 0),
        ).createShader(bounds),
        child: child,
      ),
    );
  }
}

/// A rounded grey block standing in for content that is still loading.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({this.width, this.height, this.radius = AppRadii.md, super.key});

  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) => Shimmer(
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.palette.track,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}
