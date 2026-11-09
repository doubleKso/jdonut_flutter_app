import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/motion/app_motion.dart';

/// The white rounded field of the registration screens. Its border animates
/// in on focus and turns red on error; the error text slides in below.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.controller,
    required this.hint,
    this.errorText,
    this.prefixText,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final String? errorText;

  /// Fixed text before the input, e.g. "+95".
  final String? prefixText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// A picker field (the month) is read-only and opens a sheet on tap.
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final FocusNode _ownFocus = FocusNode();
  FocusNode get _focus => widget.focusNode ?? _ownFocus;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _ownFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final hasError = widget.errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: context.motion(AppDurations.short),
          height: AppSpacing.fieldHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: AppRadii.field,
            border: Border.all(color: _borderColor(palette, hasError), width: 1.5),
          ),
          child: Row(children: [if (widget.prefixText != null) _prefix(palette), Expanded(child: _input())]),
        ),
        AnimatedSize(
          duration: context.motion(AppDurations.short),
          curve: AppCurves.standard,
          alignment: Alignment.topLeft,
          child: hasError ? _error(palette) : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }

  Color _borderColor(AppPalette palette, bool hasError) {
    if (hasError) return palette.danger;
    return _focus.hasFocus ? palette.sky : palette.surface;
  }

  Widget _prefix(AppPalette palette) => Padding(
    padding: const EdgeInsets.only(right: AppSpacing.lg),
    child: Text(widget.prefixText!, style: context.text.bodyLarge?.copyWith(color: palette.fog)),
  );

  Widget _input() => TextField(
    controller: widget.controller,
    focusNode: _focus,
    keyboardType: widget.keyboardType,
    inputFormatters: widget.inputFormatters,
    textInputAction: widget.textInputAction,
    autofillHints: widget.autofillHints,
    onChanged: widget.onChanged,
    onSubmitted: widget.onSubmitted,
    readOnly: widget.readOnly,
    onTap: widget.onTap,
    style: context.text.bodyLarge,
    decoration: InputDecoration.collapsed(
      hintText: widget.hint,
      hintStyle: context.text.bodyLarge?.copyWith(color: context.palette.fog),
    ).copyWith(suffixIcon: widget.suffixIcon),
  );

  Widget _error(AppPalette palette) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.xs, left: AppSpacing.xs),
    child: Text(widget.errorText!, style: context.text.bodyMedium?.copyWith(color: palette.danger)),
  );
}
