import 'dart:async';

import 'package:flutter/material.dart';

import '../motion/app_motion.dart';

/// Fades and slides its [child] in after `index × step` — use one per item
/// to make a list or a screen arrive in sequence.
class StaggeredEntrance extends StatefulWidget {
  const StaggeredEntrance({
    required this.index,
    required this.child,
    this.step = AppDurations.staggerStep,
    this.initialDelay = Duration.zero,
    this.offset = const Offset(0, AppMotionValues.entranceOffset),
    super.key,
  });

  final int index;
  final Widget child;
  final Duration step;
  final Duration initialDelay;

  /// Where the child starts, relative to its resting position.
  final Offset offset;

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.entrance,
  );
  late final Animation<double> _curve = CurvedAnimation(parent: _controller, curve: AppCurves.entrance);
  Timer? _delay;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isAnimating || _controller.isCompleted || _delay != null) return;
    if (context.reduceMotion) {
      _controller.value = 1;
      return;
    }
    _delay = Timer(widget.initialDelay + widget.step * widget.index, () {
      if (mounted) unawaited(_controller.forward());
    });
  }

  @override
  void dispose() {
    _delay?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _curve,
    child: widget.child,
    builder: (context, child) => Opacity(
      opacity: _curve.value,
      child: Transform.translate(offset: widget.offset * (1 - _curve.value), child: child),
    ),
  );
}
