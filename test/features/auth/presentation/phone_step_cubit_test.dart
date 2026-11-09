import 'package:app_core/app_core.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/auth/domain/entities/auth_entities.dart';
import 'package:jdonuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:jdonuts/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:jdonuts/features/auth/presentation/cubit/step_submit_cubit.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() => registerFallbackValue(AuthFlow.register));

  test('a double tap on Continue sends one request', () async {
    final auth = _MockAuthRepository();
    when(() => auth.requestOtp(phone: any(named: 'phone'), flow: any(named: 'flow'))).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 20));
      return const Result.success(OtpChallenge(phone: '+959254135592', resendAfter: Duration(minutes: 5)));
    });
    final cubit = PhoneStepCubit(RequestOtpUseCase(auth));

    final first = cubit.submit('09254135592', AuthFlow.register);
    final second = cubit.submit('09254135592', AuthFlow.register);
    await Future.wait([first, second]);

    verify(() => auth.requestOtp(phone: any(named: 'phone'), flow: any(named: 'flow'))).called(1);
    expect(cubit.state.status, SubmitStatus.success);
    await cubit.close();
  });

  blocTest<PhoneStepCubit, StepSubmitState<OtpChallenge>>(
    'shows the loading state while the fake call runs, then succeeds',
    build: () {
      final auth = _MockAuthRepository();
      when(() => auth.requestOtp(phone: any(named: 'phone'), flow: any(named: 'flow'))).thenAnswer(
        (_) async => const Result.success(OtpChallenge(phone: '+959254135592', resendAfter: Duration(minutes: 5))),
      );
      return PhoneStepCubit(RequestOtpUseCase(auth));
    },
    act: (cubit) => cubit.submit('09254135592', AuthFlow.register),
    expect: () => [
      isA<StepSubmitState<OtpChallenge>>().having((s) => s.status, 'status', SubmitStatus.submitting),
      isA<StepSubmitState<OtpChallenge>>().having((s) => s.status, 'status', SubmitStatus.success),
    ],
  );
}
