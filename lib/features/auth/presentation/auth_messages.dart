import 'package:app_core/app_core.dart';

import '../../../l10n/l10n.dart';
import '../domain/validators/date_of_birth_validator.dart';
import '../domain/validators/name_validator.dart';
import '../domain/validators/phone_validator.dart';

/// Validation errors and failures → the words shown on screen.
extension AuthMessages on AppLocalizations {
  String phoneError(PhoneError error) => switch (error) {
    PhoneError.required => phoneErrorRequired,
    PhoneError.invalid => phoneErrorInvalid,
  };

  String nameError(NameError error) => switch (error) {
    NameError.required => nameErrorRequired,
    NameError.tooLong => nameErrorTooLong,
    NameError.containsDigits => nameErrorDigits,
    NameError.invalidCharacters => nameErrorCharacters,
  };

  /// Null while the date is still being typed — no message for that.
  String? dateOfBirthError(DateOfBirthError error) => switch (error) {
    DateOfBirthError.incomplete => null,
    DateOfBirthError.invalidDate => dobErrorInvalidDate,
    DateOfBirthError.inFuture => dobErrorFuture,
    DateOfBirthError.tooYoung => dobErrorTooYoung(minimumAgeYears),
  };

  String failureMessage(Failure failure) =>
      failure is NetworkFailure ? networkError : genericError;
}
