/// The youngest age that may register.
const int minimumAgeYears = 13;

const int _yearDigits = 4;

enum DateOfBirthError {
  /// A field is still empty — Continue stays disabled, no message yet.
  incomplete,

  /// Not a real calendar date, e.g. 31 April or 29 February 2023.
  invalidDate,
  inFuture,
  tooYoung,
}

/// Validates a date of birth entered as month (1–12) plus typed day and year,
/// against [today]. Null when the date is acceptable.
DateOfBirthError? validateDateOfBirth({
  required int? month,
  required String day,
  required String year,
  required DateTime today,
}) {
  final date = parseDateOfBirth(month: month, day: day, year: year);
  if (date == null) {
    return _isIncomplete(month, day, year) ? DateOfBirthError.incomplete : DateOfBirthError.invalidDate;
  }
  final todayDate = DateTime(today.year, today.month, today.day);
  if (date.isAfter(todayDate)) return DateOfBirthError.inFuture;
  if (ageOn(date, todayDate) < minimumAgeYears) return DateOfBirthError.tooYoung;
  return null;
}

/// The calendar date, or null when the parts are missing or do not exist.
/// DateTime silently rolls 31 April over to 1 May; comparing the parts back
/// catches that, which is what rejects impossible days and 29 Feb in a
/// non-leap year.
DateTime? parseDateOfBirth({required int? month, required String day, required String year}) {
  final d = int.tryParse(day.trim());
  final y = int.tryParse(year.trim());
  if (month == null || d == null || y == null || year.trim().length != _yearDigits) return null;
  final date = DateTime(y, month, d);
  final exists = date.year == y && date.month == month && date.day == d;
  return exists ? date : null;
}

/// Whole years between [birth] and [today].
int ageOn(DateTime birth, DateTime today) {
  final hadBirthdayThisYear =
      today.month > birth.month || (today.month == birth.month && today.day >= birth.day);
  return today.year - birth.year - (hadBirthdayThisYear ? 0 : 1);
}

bool _isIncomplete(int? month, String day, String year) =>
    month == null || day.trim().isEmpty || year.trim().length < _yearDigits;
