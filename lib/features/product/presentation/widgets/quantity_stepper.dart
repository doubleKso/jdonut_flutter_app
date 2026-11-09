import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../l10n/l10n.dart';

/// − quantity +. The number slides up when it grows and down when it shrinks.
class QuantityStepper extends StatefulWidget {
  const QuantityStepper({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  final int quantity;
  final VoidCallback onIncrement;

  /// Null at the minimum quantity (1).
  final VoidCallback? onDecrement;

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  static const double _buttonSize = 30;
  static const double _numberWidth = 44;

  bool _growing = true;

  @override
  void didUpdateWidget(QuantityStepper old) {
    super.didUpdateWidget(old);
    if (widget.quantity != old.quantity) _growing = widget.quantity > old.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadii.button,
        boxShadow: [BoxShadow(color: palette.shadow, blurRadius: AppSpacing.md, offset: const Offset(0, AppSpacing.xs))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RoundButton(icon: Icons.remove_rounded, label: l10n.decreaseQuantity, onTap: widget.onDecrement, size: _buttonSize),
          SizedBox(
            width: _numberWidth,
            child: Semantics(
              liveRegion: true,
              label: l10n.quantityLabel(widget.quantity),
              child: ClipRect(child: _animatedNumber(context)),
            ),
          ),
          _RoundButton(icon: Icons.add_rounded, label: l10n.increaseQuantity, onTap: widget.onIncrement, size: _buttonSize),
        ],
      ),
    );
  }

  Widget _animatedNumber(BuildContext context) => AnimatedSwitcher(
    duration: context.motion(AppDurations.short),
    transitionBuilder: (child, animation) {
      final entering = child.key == ValueKey(widget.quantity);
      final direction = (_growing ? 1.0 : -1.0) * (entering ? 1 : -1);
      return SlideTransition(
        position: Tween(begin: Offset(0, 0.6 * direction), end: Offset.zero).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    child: Text(
      '${widget.quantity}',
      key: ValueKey(widget.quantity),
      textAlign: TextAlign.center,
      style: context.text.headlineSmall,
    ),
  );
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, required this.label, required this.onTap, required this.size});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return PressableScale(
      onTap: onTap,
      semanticLabel: label,
      child: AnimatedContainer(
        duration: context.motion(AppDurations.short),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: onTap == null ? palette.sky.withValues(alpha: 0.4) : palette.sky,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: AppSpacing.xl, color: palette.onAccent),
      ),
    );
  }
}
