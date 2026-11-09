import 'package:app_core/app_core.dart';

import '../../../member/domain/repositories/member_repository.dart';
import '../entities/auth_entities.dart';
import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';
import '../validators/date_of_birth_validator.dart';
import '../validators/name_validator.dart';
import '../validators/otp_validator.dart';
import '../validators/phone_validator.dart';

final class RequestOtpParams {
  const RequestOtpParams({required this.phoneInput, required this.flow});

  /// What was typed after +95.
  final String phoneInput;
  final AuthFlow flow;
}

final class RequestOtpUseCase implements UseCase<OtpChallenge, RequestOtpParams> {
  const RequestOtpUseCase(this._auth);

  final AuthRepository _auth;

  @override
  Future<Result<OtpChallenge>> call(RequestOtpParams params) async {
    final phone = toE164(params.phoneInput);
    if (phone == null) return const Result.failure(InvalidInputFailure('Invalid phone number'));
    return _auth.requestOtp(phone: phone, flow: params.flow);
  }
}

final class VerifyOtpParams {
  const VerifyOtpParams({required this.phone, required this.code, required this.flow});

  final String phone;
  final String code;
  final AuthFlow flow;
}

/// Verifies the code; logging in also puts the user's name on the member.
final class VerifyOtpUseCase implements UseCase<AuthSession?, VerifyOtpParams> {
  const VerifyOtpUseCase(this._auth, this._member);

  final AuthRepository _auth;
  final MemberRepository _member;

  @override
  Future<Result<AuthSession?>> call(VerifyOtpParams params) async {
    if (!isCompleteOtp(params.code)) {
      return const Result.failure(InvalidInputFailure('The code must be six digits'));
    }
    final result = await _auth.verifyOtp(phone: params.phone, code: params.code, flow: params.flow);
    final session = result.dataOrNull;
    if (session != null) await _member.rename(session.displayName);
    return result;
  }
}

final class SaveNameParams {
  const SaveNameParams({required this.phone, required this.firstName, required this.lastName});

  final String phone;
  final String firstName;
  final String lastName;
}

final class SaveNameUseCase implements UseCase<void, SaveNameParams> {
  const SaveNameUseCase(this._auth);

  final AuthRepository _auth;

  @override
  Future<Result<void>> call(SaveNameParams params) async {
    if (validateFirstName(params.firstName) != null || validateLastName(params.lastName) != null) {
      return const Result.failure(InvalidInputFailure('Invalid name'));
    }
    final lastName = params.lastName.trim();
    return _auth.saveName(
      phone: params.phone,
      firstName: params.firstName.trim(),
      lastName: lastName.isEmpty ? null : lastName,
    );
  }
}

final class CompleteRegistrationParams {
  const CompleteRegistrationParams({
    required this.phone,
    required this.month,
    required this.day,
    required this.year,
    required this.today,
  });

  final String phone;
  final int? month;
  final String day;
  final String year;
  final DateTime today;
}

/// Saves the date of birth, creates the account and signs it in.
final class CompleteRegistrationUseCase implements UseCase<AuthSession, CompleteRegistrationParams> {
  const CompleteRegistrationUseCase(this._auth, this._member);

  final AuthRepository _auth;
  final MemberRepository _member;

  @override
  Future<Result<AuthSession>> call(CompleteRegistrationParams p) async {
    final error = validateDateOfBirth(month: p.month, day: p.day, year: p.year, today: p.today);
    final date = parseDateOfBirth(month: p.month, day: p.day, year: p.year);
    if (error != null || date == null) {
      return const Result.failure(InvalidInputFailure('Invalid date of birth'));
    }
    final result = await _auth.completeRegistration(phone: p.phone, dateOfBirth: date);
    final session = result.dataOrNull;
    if (session != null) await _member.rename(session.displayName);
    return result;
  }
}

final class GetCurrentSessionUseCase implements UseCase<AuthSession?, NoParams> {
  const GetCurrentSessionUseCase(this._auth);

  final AuthRepository _auth;

  @override
  Future<Result<AuthSession?>> call(NoParams params) async => Result.success(await _auth.currentSession());
}

final class WatchSessionUseCase implements StreamUseCase<AuthSession?, NoParams> {
  const WatchSessionUseCase(this._auth);

  final AuthRepository _auth;

  @override
  Stream<AuthSession?> call(NoParams params) => _auth.watchSession();
}

final class LogOutUseCase implements UseCase<void, NoParams> {
  const LogOutUseCase(this._auth);

  final AuthRepository _auth;

  @override
  Future<Result<void>> call(NoParams params) => _auth.logOut();
}
