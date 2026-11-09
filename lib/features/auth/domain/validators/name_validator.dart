import 'package:characters/characters.dart';

/// Longest first or last name, in visible characters after trimming.
const int maxNameLength = 50;

enum NameError { required, tooLong, containsDigits, invalidCharacters }

/// Any decimal digit in any script — Western 0-9 and Myanmar ၀-၉ alike.
final RegExp _anyDigit = RegExp(r'\p{Nd}', unicode: true);

/// Letters of any script (Myanmar included), their combining marks — which
/// Myanmar vowels and tones are — and spaces.
final RegExp _lettersAndSpaces = RegExp(r'^[\p{L}\p{M} ]+$', unicode: true);

/// First name: required.
NameError? validateFirstName(String input) => _validateName(input, isRequired: true);

/// Last name: optional (many Myanmar names have no family name), same rules.
NameError? validateLastName(String input) => _validateName(input, isRequired: false);

NameError? _validateName(String input, {required bool isRequired}) {
  final name = input.trim();
  if (name.isEmpty) return isRequired ? NameError.required : null;
  if (name.characters.length > maxNameLength) return NameError.tooLong;
  if (_anyDigit.hasMatch(name)) return NameError.containsDigits;
  if (!_lettersAndSpaces.hasMatch(name)) return NameError.invalidCharacters;
  return null;
}
