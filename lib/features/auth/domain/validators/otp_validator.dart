/// The rules of the one-time code.
abstract final class OtpPolicy {
  static const int length = 6;

  /// Wrong codes allowed before entry locks until a new code is requested.
  static const int maxAttempts = 3;

  /// How long before "Resend" becomes available, and how long it restarts for.
  static const Duration resendCooldown = Duration(minutes: 5);
}

final RegExp _nonDigit = RegExp(r'[^0-9]');
final RegExp _completeCode = RegExp('^[0-9]{${OtpPolicy.length}}\$');

/// True when [code] is exactly six digits.
bool isCompleteOtp(String code) => _completeCode.hasMatch(code);

/// Keeps the digits of [raw], at most six — what a paste fills the boxes with.
String sanitizeOtpInput(String raw) {
  final digits = raw.replaceAll(_nonDigit, '');
  return digits.length > OtpPolicy.length ? digits.substring(0, OtpPolicy.length) : digits;
}

/// Attempts left after [wrongAttempts] incorrect codes.
int remainingOtpAttempts(int wrongAttempts) =>
    (OtpPolicy.maxAttempts - wrongAttempts).clamp(0, OtpPolicy.maxAttempts);

/// "4:58" for the resend countdown.
String formatCountdown(Duration remaining) {
  final seconds = remaining.isNegative ? 0 : remaining.inSeconds;
  return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
}
