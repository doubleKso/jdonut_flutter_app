import 'dart:async';

import 'package:flutter/material.dart';

import '../motion/app_motion.dart';

/// Scales its [child] up from nothing with a springy overshoot after [delay].
class PopIn extends StatefulWidget {
  const PopIn({required this.child, this.delay = Duration.zero, super.key});

  final Widget child;
  final Duration delay;

  @override
  State<PopIn> createState() => _PopInState();
}

class _PopInState extends State<PopIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: AppDurations.badgePop);
  late final Animation<double> _scale = CurvedAnimation(parent: _controller, curve: AppCurves.pop);
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isCompleted || _controller.isAnimating || _timer != null) return;
    if (context.reduceMotion) {
      _controller.value = 1;
    } else {
      _timer = Timer(widget.delay, () => mounted ? unawaited(_controller.forward()) : null);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(scale: _scale, child: widget.child);
}
