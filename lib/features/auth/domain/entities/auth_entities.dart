import 'package:equatable/equatable.dart';

/// Which journey the phone and OTP screens belong to.
enum AuthFlow {
  /// Phone → OTP → Name → Date of birth → Welcome → Home.
  register(totalSteps: 4),

  /// Phone → OTP → Home.
  login(totalSteps: 2);

  const AuthFlow({required this.totalSteps});

  /// How many steps the header's progress ring counts.
  final int totalSteps;
}

/// A code has been sent to [phone].
final class OtpChallenge extends Equatable {
  const OtpChallenge({required this.phone, required this.resendAfter});

  /// E.164, e.g. +959254135592.
  final String phone;
  final Duration resendAfter;

  @override
  List<Object?> get props => [phone, resendAfter];
}

/// A signed-in user, kept in secure storage across launches.
final class AuthSession extends Equatable {
  const AuthSession({
    required this.phone,
    required this.displayName,
    required this.token,
    required this.createdAt,
  });

  final String phone;
  final String displayName;
  final String token;
  final DateTime createdAt;

  @override
  List<Object?> get props => [phone, displayName, token, createdAt];
}
