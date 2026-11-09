import 'package:app_core/app_core.dart';

import '../entities/auth_entities.dart';

/// Authentication. The app ships a fake implementation; a real API client
/// can replace it without any change to the screens.
abstract interface class AuthRepository {
  /// Sends a code to [phone] (E.164). Fails with
  /// `PhoneNotRegisteredFailure` (log in) or `PhoneAlreadyRegisteredFailure`
  /// (register) when the number does not fit [flow].
  Future<Result<OtpChallenge>> requestOtp({required String phone, required AuthFlow flow});

  /// Checks [code]. Logging in returns the new session; registering returns
  /// null, because the account is only created at the last step.
  Future<Result<AuthSession?>> verifyOtp({
    required String phone,
    required String code,
    required AuthFlow flow,
  });

  /// Stores the name of a registration in progress.
  Future<Result<void>> saveName({required String phone, required String firstName, String? lastName});

  /// Finishes registration and signs the new user in.
  Future<Result<AuthSession>> completeRegistration({
    required String phone,
    required DateTime dateOfBirth,
  });

  /// The session restored from secure storage, if any.
  Future<AuthSession?> currentSession();

  /// Emits whenever the user signs in or out.
  Stream<AuthSession?> watchSession();

  Future<Result<void>> logOut();
}
