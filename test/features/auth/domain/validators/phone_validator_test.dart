import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/auth/domain/validators/phone_validator.dart';

void main() {
  group('normalizeMyanmarPhone', () {
    test('strips spaces, dashes and one leading zero', () {
      expect(normalizeMyanmarPhone('09 254-135 592'), '9254135592');
    });

    test('removes only the first leading zero', () {
      expect(normalizeMyanmarPhone('009254135'), '09254135');
    });
  });

  group('validatePhone', () {
    test('accepts the example number from the design', () {
      expect(validatePhone('09254135592'), isNull);
    });

    test('accepts the shortest number: 9 followed by 7 digits', () {
      expect(validatePhone('91234567'), isNull);
    });

    test('accepts the longest number: 9 followed by 9 digits', () {
      expect(validatePhone('9123456789'), isNull);
    });

    test('accepts a number typed with spaces and dashes', () {
      expect(validatePhone('09 254-135-592'), isNull);
    });

    test('reports an empty field as required', () {
      expect(validatePhone('   '), PhoneError.required);
    });

    test('rejects 9 followed by only 6 digits', () {
      expect(validatePhone('9123456'), PhoneError.invalid);
    });

    test('rejects 9 followed by 10 digits', () {
      expect(validatePhone('91234567890'), PhoneError.invalid);
    });

    test('rejects a number that does not start with 9 after the zero', () {
      expect(validatePhone('08254135592'), PhoneError.invalid);
    });

    test('rejects letters and other symbols', () {
      expect(validatePhone('09254a35592'), PhoneError.invalid);
      expect(validatePhone('(09)254135592'), PhoneError.invalid);
    });

    test('strips only one leading zero, so 009... is invalid', () {
      expect(validatePhone('009254135592'), PhoneError.invalid);
    });
  });

  group('toE164', () {
    test('formats 09254135592 as +959254135592', () {
      expect(toE164('09254135592'), '+959254135592');
    });

    test('returns null for an invalid number', () {
      expect(toE164('123'), isNull);
    });
  });
}
