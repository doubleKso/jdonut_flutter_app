/// Myanmar's country code, shown in front of the number field.
const String myanmarCountryCode = '+95';

enum PhoneError { required, invalid }

final RegExp _separators = RegExp(r'[\s-]');

/// A mobile number after the country code: 9 followed by 7 to 9 digits.
final RegExp _nationalMobileNumber = RegExp(r'^9[0-9]{7,9}$');

/// Strips spaces, dashes and one leading 0: "09 254-135 592" → "9254135592".
String normalizeMyanmarPhone(String input) {
  final compact = input.replaceAll(_separators, '');
  return compact.startsWith('0') ? compact.substring(1) : compact;
}

/// Null when [input] is a valid Myanmar mobile number.
PhoneError? validatePhone(String input) {
  if (input.trim().isEmpty) return PhoneError.required;
  return _nationalMobileNumber.hasMatch(normalizeMyanmarPhone(input)) ? null : PhoneError.invalid;
}

/// "09254135592" → "+959254135592"; null when [input] is not valid.
String? toE164(String input) =>
    validatePhone(input) == null ? '$myanmarCountryCode${normalizeMyanmarPhone(input)}' : null;
