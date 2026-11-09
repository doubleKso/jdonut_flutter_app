import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../motion/app_motion.dart';
import 'pressable_scale.dart';

/// The cyan pill. While [loading] it morphs into a circle with a spinner and
/// ignores taps, so a double tap can never send a second request.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.trailing,
    super.key,
  });

  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;
  final bool loading;

  /// Optional text after a divider, e.g. the cart total.
  final String? trailing;

  static const double _spinnerSize = 22;
  static const double _spinnerStroke = 2.5;
  static const double _dividerHeight = 18;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final enabled = onPressed != null && !loading;
    // AnimatedSize (not a LayoutBuilder) does the morph, so the button can
    // still report its intrinsic size inside SliverFillRemaining.
    return Center(
      child: PressableScale(
        onTap: enabled ? onPressed : null,
        semanticLabel: label,
        child: AnimatedSize(
          duration: context.motion(AppDurations.morph),
          curve: AppCurves.standard,
          child: AnimatedContainer(
            duration: context.motion(AppDurations.short),
            width: loading ? AppSpacing.buttonHeight : double.infinity,
            height: AppSpacing.buttonHeight,
            decoration: BoxDecoration(
              color: onPressed == null ? palette.sky.withValues(alpha: 0.45) : palette.sky,
              borderRadius: AppRadii.button,
            ),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: context.motion(AppDurations.short),
              child: loading ? _spinner(palette) : _label(context, palette),
            ),
          ),
        ),
      ),
    );
  }

  Widget _spinner(AppPalette palette) => SizedBox.square(
    key: const ValueKey('spinner'),
    dimension: _spinnerSize,
    child: CircularProgressIndicator(strokeWidth: _spinnerStroke, color: palette.onAccent),
  );

  Widget _label(BuildContext context, AppPalette palette) {
    final style = context.text.labelLarge?.copyWith(color: palette.onAccent);
    return Row(
      key: const ValueKey('label'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(label, style: style, maxLines: 1, overflow: TextOverflow.ellipsis)),
        if (trailing != null) ...[
          Container(
            width: 1,
            height: _dividerHeight,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            color: palette.onAccent.withValues(alpha: 0.6),
          ),
          Text(trailing!, style: style),
        ],
      ],
    );
  }
}
