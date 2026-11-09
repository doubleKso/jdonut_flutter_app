import 'package:app_core/app_core.dart';

/// Everything that can go wrong signing in or registering. Sealed, so the
/// screens switch over it exhaustively when choosing a message.
sealed class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Log in with a number that never registered.
final class PhoneNotRegisteredFailure extends AuthFailure {
  const PhoneNotRegisteredFailure() : super('Phone number is not registered');
}

/// Register with a number that already has an account.
final class PhoneAlreadyRegisteredFailure extends AuthFailure {
  const PhoneAlreadyRegisteredFailure() : super('Phone number is already registered');
}

final class InvalidOtpFailure extends AuthFailure {
  const InvalidOtpFailure() : super('The one-time code is incorrect');
}

/// A use case received input its validator rejects — the UI should have
/// stopped it first; this is the domain refusing to trust that.
final class InvalidInputFailure extends AuthFailure {
  const InvalidInputFailure(super.message);
}

/// The local user store or the secure session store failed.
final class AuthStorageFailure extends AuthFailure {
  const AuthStorageFailure(super.message);
}
