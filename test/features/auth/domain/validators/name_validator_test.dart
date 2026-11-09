import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/auth/domain/validators/name_validator.dart';

void main() {
  group('validateFirstName', () {
    test('accepts a Latin name with spaces', () {
      expect(validateFirstName('Ye Min'), isNull);
    });

    test('accepts a name in Myanmar script', () {
      expect(validateFirstName('ရဲမင်း'), isNull);
    });

    test('trims surrounding spaces before checking', () {
      expect(validateFirstName('  Hania  '), isNull);
    });

    test('is required, including when only spaces are typed', () {
      expect(validateFirstName(''), NameError.required);
      expect(validateFirstName('   '), NameError.required);
    });

    test('allows exactly 50 characters and rejects 51', () {
      expect(validateFirstName('a' * maxNameLength), isNull);
      expect(validateFirstName('a' * (maxNameLength + 1)), NameError.tooLong);
    });

    test('counts a Myanmar syllable as one character, not its code points', () {
      const syllable = 'မ်'; // two code points, one visible character
      expect(validateFirstName(syllable * maxNameLength), isNull);
    });

    test('rejects Western digits', () {
      expect(validateFirstName('Ye Min 2'), NameError.containsDigits);
    });

    test('rejects Myanmar digits', () {
      expect(validateFirstName('ရဲမင်း၂'), NameError.containsDigits);
    });

    test('rejects punctuation and symbols', () {
      expect(validateFirstName('Ye-Min'), NameError.invalidCharacters);
      expect(validateFirstName('Hania!'), NameError.invalidCharacters);
    });
  });

  group('validateLastName', () {
    test('is optional', () {
      expect(validateLastName(''), isNull);
      expect(validateLastName('   '), isNull);
    });

    test('follows the same character rules as the first name', () {
      expect(validateLastName('Phyoe Win'), isNull);
      expect(validateLastName('Win7'), NameError.containsDigits);
      expect(validateLastName('Win_'), NameError.invalidCharacters);
      expect(validateLastName('a' * (maxNameLength + 1)), NameError.tooLong);
    });
  });
}
