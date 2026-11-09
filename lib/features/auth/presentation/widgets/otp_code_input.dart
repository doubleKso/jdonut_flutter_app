import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/validators/otp_validator.dart';

/// Six OTP boxes over one invisible text field. One field gives everything
/// the spec asks for: typing advances box by box, backspace moves back, a
/// pasted or SMS-autofilled code fills all six, and the keyboard is numeric.
/// The boxes shake when [shakeCount] changes (a wrong code).
class OtpCodeInput extends StatefulWidget {
  const OtpCodeInput({
    required this.code,
    required this.enabled,
    required this.shakeCount,
    required this.onChanged,
    this.hasError = false,
    super.key,
  });

  final String code;
  final bool enabled;
  final int shakeCount;
  final bool hasError;
  final ValueChanged<String> onChanged;

  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> with SingleTickerProviderStateMixin {
  late final TextEditingController _controller = TextEditingController(text: widget.code);
  final FocusNode _focus = FocusNode();
  late final AnimationController _shake = AnimationController(vsync: this, duration: AppDurations.shake);

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(OtpCodeInput old) {
    super.didUpdateWidget(old);
    if (widget.code != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.code,
        selection: TextSelection.collapsed(offset: widget.code.length),
      );
    }
    if (widget.shakeCount != old.shakeCount && !context.reduceMotion) _shake.forward(from: 0);
    if (widget.enabled && !old.enabled) _focus.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _shake,
    builder: (context, child) => Transform.translate(offset: Offset(_shakeOffset(), 0), child: child),
    child: Stack(children: [_boxes(context), Positioned.fill(child: _hiddenField())]),
  );

  double _shakeOffset() =>
      math.sin(_shake.value * math.pi * 2 * AppMotionValues.shakeCycles) *
      AppMotionValues.shakeDistance *
      (1 - _shake.value);

  Widget _boxes(BuildContext context) => Row(
    children: [
      for (var i = 0; i < OtpPolicy.length; i++) ...[
        if (i > 0) const SizedBox(width: AppSpacing.sm),
        Expanded(child: _box(context, i)),
      ],
    ],
  );

  Widget _box(BuildContext context, int index) {
    final palette = context.palette;
    final digit = index < widget.code.length ? widget.code[index] : '';
    final active = _focus.hasFocus && widget.enabled && index == math.min(widget.code.length, OtpPolicy.length - 1);
    final borderColor = widget.hasError ? palette.danger : (active ? palette.sky : palette.surface);
    return Semantics(
      label: context.l10n.otpDigitLabel(index + 1),
      value: digit,
      child: AnimatedContainer(
        duration: context.motion(AppDurations.short),
        height: AppSpacing.fieldHeight - AppSpacing.xs,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.enabled ? palette.surface : palette.pebble,
          borderRadius: AppRadii.field,
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: AnimatedSwitcher(
          duration: context.motion(AppDurations.short),
          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
          child: Text(digit, key: ValueKey('$index$digit'), style: context.text.headlineSmall),
        ),
      ),
    );
  }

  Widget _hiddenField() => Opacity(
    opacity: 0,
    child: TextField(
      key: const Key('otp-field'),
      controller: _controller,
      focusNode: _focus,
      autofocus: true,
      enabled: widget.enabled,
      keyboardType: TextInputType.number,
      autofillHints: const [AutofillHints.oneTimeCode],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(OtpPolicy.length),
      ],
      showCursor: false,
      onChanged: widget.onChanged,
      decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
    ),
  );
}
