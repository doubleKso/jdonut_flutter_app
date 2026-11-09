import 'package:app_core/app_core.dart';
import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth_entities.dart';
import '../../domain/usecases/auth_use_cases.dart';

enum SubmitStatus { idle, submitting, success, failure }

final class StepSubmitState<R> extends Equatable {
  const StepSubmitState({this.status = SubmitStatus.idle, this.result, this.failure});

  final SubmitStatus status;
  final R? result;
  final Failure? failure;

  bool get isSubmitting => status == SubmitStatus.submitting;

  @override
  List<Object?> get props => [status, result, failure];
}

/// Runs one registration step's fake call with a loading state. While a call
/// is in flight further submits are ignored — a double tap sends one request.
abstract base class StepSubmitCubit<R> extends Cubit<StepSubmitState<R>> {
  StepSubmitCubit() : super(StepSubmitState<R>());

  Future<void> run(Future<Result<R>> Function() request) async {
    if (state.isSubmitting) return;
    emit(StepSubmitState<R>(status: SubmitStatus.submitting));
    final result = await request();
    if (isClosed) return;
    emit(
      result.fold(
        (failure) => StepSubmitState<R>(status: SubmitStatus.failure, failure: failure),
        (value) => StepSubmitState<R>(status: SubmitStatus.success, result: value),
      ),
    );
  }

  /// Clears a shown failure once the user edits the field again.
  void clearFailure() {
    if (state.status == SubmitStatus.failure) emit(StepSubmitState<R>());
  }
}

/// Phone step: sends the code.
final class PhoneStepCubit extends StepSubmitCubit<OtpChallenge> {
  PhoneStepCubit(this._requestOtp);

  final RequestOtpUseCase _requestOtp;

  Future<void> submit(String phoneInput, AuthFlow flow) =>
      run(() => _requestOtp(RequestOtpParams(phoneInput: phoneInput, flow: flow)));
}

/// Name step: stores the name of the registration in progress.
final class NameStepCubit extends StepSubmitCubit<void> {
  NameStepCubit(this._saveName);

  final SaveNameUseCase _saveName;

  Future<void> submit({required String phone, required String firstName, required String lastName}) =>
      run(() => _saveName(SaveNameParams(phone: phone, firstName: firstName, lastName: lastName)));
}

/// Date-of-birth step: completes registration and signs in.
final class DateOfBirthStepCubit extends StepSubmitCubit<AuthSession> {
  DateOfBirthStepCubit(this._completeRegistration, {DateTime Function()? today})
    : _clock = today ?? clock.now;

  final CompleteRegistrationUseCase _completeRegistration;
  final DateTime Function() _clock;

  DateTime get today => _clock();

  Future<void> submit({
    required String phone,
    required int? month,
    required String day,
    required String year,
  }) => run(
    () => _completeRegistration(
      CompleteRegistrationParams(phone: phone, month: month, day: day, year: year, today: today),
    ),
  );
}
