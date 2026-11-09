import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/validators/otp_validator.dart';
import '../cubit/otp_cubit.dart';
import '../widgets/otp_code_input.dart';
import '../widgets/step_layout.dart';

/// Screen 3. A complete code is verified straight away (Continue does the
/// same); a wrong one shakes and clears the boxes, three lock entry until a
/// new code is requested.
class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpCubit, OtpState>(
          listenWhen: (previous, current) => previous.resentCount != current.resentCount,
          listener: (context, _) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(context.l10n.otpCodeSent))),
        ),
        // Logging in signs the user in and the router's guard takes over;
        // registering moves on to the name step.
        BlocListener<OtpCubit, OtpState>(
          listenWhen: (previous, current) =>
              previous.status != current.status && current.status == OtpStatus.verified,
          listener: (context, _) {
            if (cubit.flow == AuthFlow.register) context.push(RoutePaths.registerName);
          },
        ),
      ],
      child: _OtpForm(cubit: cubit),
    );
  }
}

class _OtpForm extends StatelessWidget {
  const _OtpForm({required this.cubit});

  final OtpCubit cubit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) => StepLayout(
        title: l10n.otpTitle,
        button: PrimaryButton(
          label: l10n.continueAction,
          loading: state.status == OtpStatus.verifying,
          onPressed: state.canVerify ? cubit.verify : null,
        ),
        children: [
          Transform.translate(
            offset: const Offset(0, -AppSpacing.lg),
            child: Text(l10n.otpSentTo(cubit.phone), style: context.text.bodyMedium),
          ),
          const SizedBox(height: AppSpacing.sm),
          OtpCodeInput(
            code: state.code,
            enabled: state.canEdit,
            shakeCount: state.shakeCount,
            hasError: state.problem != null,
            onChanged: cubit.codeChanged,
          ),
          _ProblemMessage(state: state),
          const SizedBox(height: AppSpacing.lg),
          _ResendArea(state: state, onResend: cubit.resend),
        ],
      ),
    );
  }
}

class _ProblemMessage extends StatelessWidget {
  const _ProblemMessage({required this.state});

  final OtpState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final message = switch (state.problem) {
      OtpProblem.incorrect => l10n.otpIncorrect(state.remainingAttempts),
      OtpProblem.locked => l10n.otpLocked,
      OtpProblem.failed => l10n.genericError,
      null => null,
    };
    return AnimatedSize(
      duration: context.motion(AppDurations.short),
      alignment: Alignment.topLeft,
      child: message == null
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(
                message,
                key: const Key('otp-message'),
                style: context.text.bodyMedium?.copyWith(color: context.palette.danger),
              ),
            ),
    );
  }
}

/// "Didn't receive the code? resend in 4:58 min", then a Resend link at 0:00.
class _ResendArea extends StatelessWidget {
  const _ResendArea({required this.state, required this.onResend});

  final OtpState state;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final base = context.text.bodyMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.otpDidntReceive, style: base),
        AnimatedSwitcher(
          duration: context.motion(AppDurations.short),
          child: state.canResend
              ? GestureDetector(
                  key: const Key('otp-resend'),
                  onTap: onResend,
                  child: Text(l10n.otpResend, style: context.text.labelMedium?.copyWith(color: palette.berry)),
                )
              : Text.rich(
                  key: const Key('otp-countdown'),
                  TextSpan(
                    style: base,
                    children: [
                      TextSpan(text: '${l10n.otpResendPrefix} '),
                      TextSpan(text: formatCountdown(state.resendIn), style: TextStyle(color: palette.berry)),
                      TextSpan(text: ' ${l10n.otpResendSuffix}'),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
