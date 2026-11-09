import 'package:app_core/app_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/auth/domain/entities/auth_entities.dart';
import 'package:jdonuts/features/auth/domain/failures/auth_failure.dart';
import 'package:jdonuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:jdonuts/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:jdonuts/features/member/domain/repositories/member_repository.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockMemberRepository extends Mock implements MemberRepository {}

void main() {
  late _MockAuthRepository auth;
  late _MockMemberRepository member;
  final session = AuthSession(
    phone: '+959254135592',
    displayName: 'Ye Min Phyoe Win',
    token: 'token',
    createdAt: DateTime(2026),
  );

  setUpAll(() => registerFallbackValue(AuthFlow.register));

  setUp(() {
    auth = _MockAuthRepository();
    member = _MockMemberRepository();
    when(() => member.rename(any())).thenAnswer((_) async => const Result.success(null));
  });

  group('RequestOtpUseCase', () {
    test('sends the code to the E.164 form of what was typed', () async {
      when(() => auth.requestOtp(phone: any(named: 'phone'), flow: any(named: 'flow'))).thenAnswer(
        (_) async => const Result.success(OtpChallenge(phone: '+959254135592', resendAfter: Duration(minutes: 5))),
      );

      await RequestOtpUseCase(auth)(const RequestOtpParams(phoneInput: '09 254 135 592', flow: AuthFlow.login));

      verify(() => auth.requestOtp(phone: '+959254135592', flow: AuthFlow.login)).called(1);
    });

    test('refuses an invalid number without calling the repository', () async {
      final result = await RequestOtpUseCase(auth)(const RequestOtpParams(phoneInput: '123', flow: AuthFlow.login));

      expect(result.failureOrNull, isA<InvalidInputFailure>());
      verifyNever(() => auth.requestOtp(phone: any(named: 'phone'), flow: any(named: 'flow')));
    });
  });

  group('VerifyOtpUseCase', () {
    test('logging in puts the signed-in name on the member record', () async {
      when(() => auth.verifyOtp(phone: any(named: 'phone'), code: any(named: 'code'), flow: any(named: 'flow')))
          .thenAnswer((_) async => Result.success(session));

      await VerifyOtpUseCase(auth, member)(
        const VerifyOtpParams(phone: '+959254135592', code: '123456', flow: AuthFlow.login),
      );

      verify(() => member.rename('Ye Min Phyoe Win')).called(1);
    });

    test('a code that is not six digits never reaches the repository', () async {
      final result = await VerifyOtpUseCase(auth, member)(
        const VerifyOtpParams(phone: '+959254135592', code: '12345', flow: AuthFlow.login),
      );

      expect(result.failureOrNull, isA<InvalidInputFailure>());
      verifyNever(() => auth.verifyOtp(phone: any(named: 'phone'), code: any(named: 'code'), flow: any(named: 'flow')));
    });

    test('a wrong code is passed back and leaves the member alone', () async {
      when(() => auth.verifyOtp(phone: any(named: 'phone'), code: any(named: 'code'), flow: any(named: 'flow')))
          .thenAnswer((_) async => const Result.failure(InvalidOtpFailure()));

      final result = await VerifyOtpUseCase(auth, member)(
        const VerifyOtpParams(phone: '+959254135592', code: '000000', flow: AuthFlow.login),
      );

      expect(result.failureOrNull, isA<InvalidOtpFailure>());
      verifyNever(() => member.rename(any()));
    });
  });

  group('SaveNameUseCase', () {
    test('trims the names and stores a blank last name as none', () async {
      when(() => auth.saveName(phone: any(named: 'phone'), firstName: any(named: 'firstName'), lastName: any(named: 'lastName')))
          .thenAnswer((_) async => const Result.success(null));

      await SaveNameUseCase(auth)(const SaveNameParams(phone: '+959254135592', firstName: '  Ye Min ', lastName: '   '));

      verify(() => auth.saveName(phone: '+959254135592', firstName: 'Ye Min', lastName: null)).called(1);
    });

    test('refuses a first name with digits', () async {
      final result = await SaveNameUseCase(auth)(
        const SaveNameParams(phone: '+959254135592', firstName: 'Ye Min 2', lastName: ''),
      );

      expect(result.failureOrNull, isA<InvalidInputFailure>());
    });
  });

  group('CompleteRegistrationUseCase', () {
    test('creates the account with the parsed date and renames the member', () async {
      when(() => auth.completeRegistration(phone: any(named: 'phone'), dateOfBirth: any(named: 'dateOfBirth')))
          .thenAnswer((_) async => Result.success(session));

      await CompleteRegistrationUseCase(auth, member)(
        CompleteRegistrationParams(phone: '+959254135592', month: 5, day: '1', year: '1980', today: DateTime(2026, 11, 9)),
      );

      verify(() => auth.completeRegistration(phone: '+959254135592', dateOfBirth: DateTime(1980, 5))).called(1);
      verify(() => member.rename('Ye Min Phyoe Win')).called(1);
    });

    test('refuses someone younger than 13', () async {
      final result = await CompleteRegistrationUseCase(auth, member)(
        CompleteRegistrationParams(phone: '+959254135592', month: 1, day: '1', year: '2020', today: DateTime(2026, 11, 9)),
      );

      expect(result.failureOrNull, isA<InvalidInputFailure>());
      verifyNever(() => auth.completeRegistration(phone: any(named: 'phone'), dateOfBirth: any(named: 'dateOfBirth')));
    });
  });
}
