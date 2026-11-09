import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/auth/domain/validators/otp_validator.dart';

void main() {
  group('isCompleteOtp', () {
    test('accepts exactly six digits', () {
      expect(isCompleteOtp('123456'), isTrue);
    });

    test('rejects five digits, seven digits and non-digits', () {
      expect(isCompleteOtp('12345'), isFalse);
      expect(isCompleteOtp('1234567'), isFalse);
      expect(isCompleteOtp('12a456'), isFalse);
    });
  });

  group('sanitizeOtpInput', () {
    test('keeps only the digits of a pasted message', () {
      expect(sanitizeOtpInput('Your code: 123-456'), '123456');
    });

    test('keeps at most six digits', () {
      expect(sanitizeOtpInput('12345678'), '123456');
    });
  });

  group('remainingOtpAttempts', () {
    test('counts down from three and never goes below zero', () {
      expect(remainingOtpAttempts(0), OtpPolicy.maxAttempts);
      expect(remainingOtpAttempts(2), 1);
      expect(remainingOtpAttempts(5), 0);
    });
  });

  group('formatCountdown', () {
    test('shows minutes and zero-padded seconds', () {
      expect(formatCountdown(const Duration(minutes: 5)), '5:00');
      expect(formatCountdown(const Duration(minutes: 4, seconds: 58)), '4:58');
      expect(formatCountdown(const Duration(seconds: 7)), '0:07');
    });

    test('never shows a negative time', () {
      expect(formatCountdown(const Duration(seconds: -3)), '0:00');
    });
  });

  test('the resend countdown starts at five minutes', () {
    expect(OtpPolicy.resendCooldown, const Duration(minutes: 5));
  });
}
