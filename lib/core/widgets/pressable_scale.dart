import 'package:flutter/material.dart';

import '../motion/app_motion.dart';

/// Shrinks its [child] slightly while pressed — tactile feedback for every
/// tappable surface. A null [onTap] disables both the tap and the effect.
class PressableScale extends StatefulWidget {
  const PressableScale({
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.pressedScale = AppMotionValues.pressedScale,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final double pressedScale;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool pressed) {
    if (widget.onTap == null || _pressed == pressed) return;
    setState(() => _pressed = pressed);
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: widget.onTap != null,
    label: widget.semanticLabel,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1,
        duration: context.motion(AppDurations.press),
        curve: AppCurves.standard,
        child: widget.child,
      ),
    ),
  );
}
