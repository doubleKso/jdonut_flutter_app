import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/auth/domain/validators/date_of_birth_validator.dart';

void main() {
  final today = DateTime(2026, 11, 9);

  DateOfBirthError? check(int? month, String day, String year) =>
      validateDateOfBirth(month: month, day: day, year: year, today: today);

  group('validateDateOfBirth', () {
    test('accepts the date from the design: 1 May 1980', () {
      expect(check(5, '1', '1980'), isNull);
    });

    test('reports a missing month, day or a short year as incomplete', () {
      expect(check(null, '1', '1980'), DateOfBirthError.incomplete);
      expect(check(5, '', '1980'), DateOfBirthError.incomplete);
      expect(check(5, '1', '198'), DateOfBirthError.incomplete);
    });

    test('rejects 31 April', () {
      expect(check(4, '31', '1990'), DateOfBirthError.invalidDate);
    });

    test('accepts 29 February in a leap year', () {
      expect(check(2, '29', '2000'), isNull);
    });

    test('rejects 29 February outside a leap year', () {
      expect(check(2, '29', '2001'), DateOfBirthError.invalidDate);
    });

    test('rejects day zero and day 32', () {
      expect(check(1, '0', '1990'), DateOfBirthError.invalidDate);
      expect(check(1, '32', '1990'), DateOfBirthError.invalidDate);
    });

    test('rejects a date in the future', () {
      expect(check(11, '10', '2026'), DateOfBirthError.inFuture);
    });

    test('accepts someone turning 13 today', () {
      expect(check(11, '9', '2013'), isNull);
    });

    test('rejects someone who turns 13 tomorrow', () {
      expect(check(11, '10', '2013'), DateOfBirthError.tooYoung);
    });
  });

  group('ageOn', () {
    test('counts a birthday only once it has passed this year', () {
      expect(ageOn(DateTime(2000, 11, 10), today), 25);
      expect(ageOn(DateTime(2000, 11, 9), today), 26);
    });
  });

  test('the minimum age is a named constant of 13', () {
    expect(minimumAgeYears, 13);
  });
}
