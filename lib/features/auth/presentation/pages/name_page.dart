import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/validators/name_validator.dart';
import '../auth_messages.dart';
import '../cubit/auth_flow_cubit.dart';
import '../cubit/step_submit_cubit.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/step_layout.dart';

/// Screens 4 and 5: first name (required) and last name (optional).
class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController _first = TextEditingController();
  final TextEditingController _last = TextEditingController();
  final FocusNode _firstFocus = FocusNode();
  final FocusNode _lastFocus = FocusNode();
  bool _firstTouched = false;
  bool _lastTouched = false;

  @override
  void initState() {
    super.initState();
    _firstFocus.addListener(() => _firstFocus.hasFocus ? null : setState(() => _firstTouched = true));
    _lastFocus.addListener(() => _lastFocus.hasFocus ? null : setState(() => _lastTouched = true));
  }

  @override
  void dispose() {
    for (final disposable in [_first, _last, _firstFocus, _lastFocus]) {
      disposable.dispose();
    }
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<NameStepCubit>().submit(
      phone: context.read<AuthFlowCubit>().state.phone ?? '',
      firstName: _first.text,
      lastName: _last.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final firstError = validateFirstName(_first.text);
    final lastError = validateLastName(_last.text);
    // Show a mistake once the field is left, or as soon as it is typed (a digit).
    String? shown(NameError? error, bool touched, String text) =>
        error != null && (touched || (text.isNotEmpty && error != NameError.required)) ? l10n.nameError(error) : null;

    return BlocConsumer<NameStepCubit, StepSubmitState<void>>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SubmitStatus.success) context.push(RoutePaths.registerDateOfBirth);
        if (state.failure != null) _showFailure(context, l10n.failureMessage(state.failure!));
      },
      builder: (context, state) => StepLayout(
        title: l10n.nameTitle,
        button: PrimaryButton(
          label: l10n.continueAction,
          loading: state.isSubmitting,
          onPressed: firstError == null && lastError == null ? _submit : null,
        ),
        children: [
          AuthTextField(
            key: const Key('first-name-field'),
            controller: _first,
            focusNode: _firstFocus,
            hint: l10n.firstNameHint,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.givenName],
            errorText: shown(firstError, _firstTouched, _first.text),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthTextField(
            key: const Key('last-name-field'),
            controller: _last,
            focusNode: _lastFocus,
            hint: l10n.lastNameHint,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.familyName],
            errorText: shown(lastError, _lastTouched, _last.text),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  void _showFailure(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
