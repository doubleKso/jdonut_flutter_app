import 'package:app_core/app_core.dart';
import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/validators/phone_validator.dart';
import '../auth_messages.dart';
import '../cubit/auth_flow_cubit.dart';
import '../cubit/step_submit_cubit.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/step_layout.dart';

/// Screen 2. Continue stays disabled until the number is valid; the inline
/// message appears once the field loses focus.
class PhonePage extends StatefulWidget {
  const PhonePage({this.initialPhone = '', super.key});

  final String initialPhone;

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  static const int _maxInputLength = 16;

  late final TextEditingController _phone = TextEditingController(text: widget.initialPhone);
  final FocusNode _focus = FocusNode();
  bool _touched = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (!_focus.hasFocus && _phone.text.isNotEmpty) setState(() => _touched = true);
    });
  }

  @override
  void dispose() {
    _phone.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<PhoneStepCubit>().submit(_phone.text, context.read<AuthFlowCubit>().state.flow);
  }

  void _onSubmitted(StepSubmitState<OtpChallenge> state) {
    final challenge = state.result;
    if (state.status != SubmitStatus.success || challenge == null) return;
    final flowCubit = context.read<AuthFlowCubit>()..phoneVerified(challenge.phone);
    context.push(flowCubit.state.flow == AuthFlow.register ? RoutePaths.registerOtp : RoutePaths.loginOtp);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final error = validatePhone(_phone.text);
    return BlocConsumer<PhoneStepCubit, StepSubmitState<OtpChallenge>>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) => _onSubmitted(state),
      builder: (context, state) => StepLayout(
        title: l10n.phoneTitle,
        button: PrimaryButton(
          label: l10n.continueAction,
          loading: state.isSubmitting,
          onPressed: error == null ? _submit : null,
        ),
        children: [
          AuthTextField(
            key: const Key('phone-field'),
            controller: _phone,
            focusNode: _focus,
            hint: l10n.phoneHint,
            prefixText: myanmarCountryCode,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.telephoneNumberNational],
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9 \-]')),
              LengthLimitingTextInputFormatter(_maxInputLength),
            ],
            errorText: _touched && error != null ? l10n.phoneError(error) : null,
            onChanged: (_) {
              context.read<PhoneStepCubit>().clearFailure();
              setState(() {});
            },
            onSubmitted: (_) => error == null ? _submit() : setState(() => _touched = true),
          ),
          AnimatedSwitcher(
            duration: context.motion(AppDurations.short),
            child: state.failure == null
                ? const SizedBox.shrink()
                : _FailureMessage(failure: state.failure!, phone: _phone.text),
          ),
        ],
      ),
    );
  }
}

/// "This number isn't registered yet. Register now" and its mirror image.
class _FailureMessage extends StatelessWidget {
  const _FailureMessage({required this.failure, required this.phone});

  final Failure failure;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (message, linkLabel, linkTarget) = switch (failure) {
      PhoneNotRegisteredFailure() => (l10n.phoneNotRegistered, l10n.registerInstead, RoutePaths.registerPhone),
      PhoneAlreadyRegisteredFailure() => (l10n.phoneAlreadyRegistered, l10n.logInInstead, RoutePaths.loginPhone),
      _ => (l10n.failureMessage(failure), null, null),
    };
    return Padding(
      key: ValueKey(message),
      padding: const EdgeInsets.only(top: AppSpacing.md, left: AppSpacing.xs),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('$message ', style: context.text.bodyMedium?.copyWith(color: context.palette.danger)),
          if (linkLabel != null && linkTarget != null)
            GestureDetector(
              onTap: () => context.go(Uri(path: linkTarget, queryParameters: {RoutePaths.phoneQuery: phone}).toString()),
              child: Text(
                linkLabel,
                style: context.text.labelMedium?.copyWith(
                  color: context.palette.berry,
                  decoration: TextDecoration.underline,
                  decorationColor: context.palette.berry,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
