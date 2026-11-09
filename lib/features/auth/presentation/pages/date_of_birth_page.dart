import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/validators/date_of_birth_validator.dart';
import '../auth_messages.dart';
import '../cubit/auth_flow_cubit.dart';
import '../cubit/step_submit_cubit.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/step_layout.dart';

/// Screen 6: month (picked from a list), day and year. Continue stays
/// disabled until the date is real, in the past, and at least 13 years ago.
class DateOfBirthPage extends StatefulWidget {
  const DateOfBirthPage({super.key});

  @override
  State<DateOfBirthPage> createState() => _DateOfBirthPageState();
}

class _DateOfBirthPageState extends State<DateOfBirthPage> {
  static const int _dayDigits = 2;
  static const int _yearDigits = 4;
  static const int _monthsInYear = 12;

  final TextEditingController _month = TextEditingController();
  final TextEditingController _day = TextEditingController();
  final TextEditingController _year = TextEditingController();
  int? _monthNumber;

  @override
  void dispose() {
    for (final controller in [_month, _day, _year]) {
      controller.dispose();
    }
    super.dispose();
  }

  String _monthName(int month) =>
      DateFormat.MMMM(Localizations.localeOf(context).toLanguageTag()).format(DateTime(2000, month));

  Future<void> _pickMonth() async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      // The flow's own navigator stops above the shell footer; the sheet
      // belongs on top of the whole screen.
      useRootNavigator: true,
      builder: (sheet) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (var month = 1; month <= _monthsInYear; month++)
              ListTile(
                title: Text(_monthName(month)),
                selected: month == _monthNumber,
                onTap: () => Navigator.of(sheet).pop(month),
              ),
          ],
        ),
      ),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _monthNumber = picked;
      _month.text = _monthName(picked);
    });
  }

  void _submit(DateOfBirthStepCubit cubit) {
    FocusScope.of(context).unfocus();
    cubit.submit(
      phone: context.read<AuthFlowCubit>().state.phone ?? '',
      month: _monthNumber,
      day: _day.text,
      year: _year.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<DateOfBirthStepCubit>();
    final error = validateDateOfBirth(month: _monthNumber, day: _day.text, year: _year.text, today: cubit.today);
    final message = error == null ? null : l10n.dateOfBirthError(error);
    return BlocConsumer<DateOfBirthStepCubit, StepSubmitState<AuthSession>>(
      listenWhen: (previous, current) => previous.status != current.status,
      // Success signs the user in; the router's guard then opens Welcome.
      listener: (context, state) {
        if (state.failure == null) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.failureMessage(state.failure!))));
      },
      builder: (context, state) => StepLayout(
        title: l10n.dobTitle,
        button: PrimaryButton(
          label: l10n.continueAction,
          loading: state.isSubmitting,
          onPressed: error == null ? () => _submit(cubit) : null,
        ),
        children: [
          AuthTextField(
            key: const Key('month-field'),
            controller: _month,
            hint: l10n.monthHint,
            readOnly: true,
            onTap: _pickMonth,
            suffixIcon: Icon(Icons.expand_more_rounded, color: context.palette.fog),
          ),
          const SizedBox(height: AppSpacing.lg),
          _numberField(const Key('day-field'), _day, l10n.dayHint, _dayDigits),
          const SizedBox(height: AppSpacing.lg),
          _numberField(const Key('year-field'), _year, l10n.yearHint, _yearDigits),
          AnimatedSize(
            duration: context.motion(AppDurations.short),
            alignment: Alignment.topLeft,
            child: message == null
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm, left: AppSpacing.xs),
                    child: Text(
                      message,
                      key: const Key('dob-message'),
                      style: context.text.bodyMedium?.copyWith(color: context.palette.danger),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _numberField(Key key, TextEditingController controller, String hint, int digits) => AuthTextField(
    key: key,
    controller: controller,
    hint: hint,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(digits)],
    onChanged: (_) => setState(() {}),
  );
}
