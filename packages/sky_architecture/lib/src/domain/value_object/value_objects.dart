import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';
import 'package:sky_architecture/src/domain/failures/failures.dart';
import 'package:sky_architecture/src/domain/value_object/value_object.dart';

/// Represents a validated name.
class Name extends ValueObject<String> {
  /// Validates the given name string.
  ///
  /// A name is valid if it is not empty or composed solely of whitespace.
  factory Name(String input) {
    if (input.trim().isEmpty) {
      return Name._(
        left(const ValidationFailure(message: 'Name cannot be empty')),
      );
    }
    return Name._(right(input.trim()));
  }

  const Name._(this.value);

  @override
  final Either<Failure, String> value;
}

/// Represents a validated email address.
class EmailAddress extends ValueObject<String> {
  /// Validates the given email address string.
  factory EmailAddress(String input) {
    final cleaned = input.trim();
    if (cleaned.isEmpty) {
      return EmailAddress._(
        left(
          const ValidationFailure(message: 'Email address cannot be empty'),
        ),
      );
    }
    if (!_emailRegExp.hasMatch(cleaned)) {
      return EmailAddress._(
        left(
          const ValidationFailure(message: 'Invalid email address format'),
        ),
      );
    }
    return EmailAddress._(right(cleaned));
  }

  const EmailAddress._(this.value);

  @override
  final Either<Failure, String> value;

  // Standard email validation pattern
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
}

/// Represents a validated phone number.
class PhoneNumber extends ValueObject<String> {
  /// Validates the given phone number string.
  factory PhoneNumber(String input) {
    final cleaned = input.trim();
    if (cleaned.isEmpty) {
      return PhoneNumber._(
        left(const ValidationFailure(message: 'Phone number cannot be empty')),
      );
    }
    if (!_phoneRegExp.hasMatch(cleaned)) {
      return PhoneNumber._(
        left(const ValidationFailure(message: 'Invalid phone number format')),
      );
    }
    return PhoneNumber._(right(cleaned));
  }

  const PhoneNumber._(this.value);

  @override
  final Either<Failure, String> value;

  // A basic phone number regular expression allowing optional '+' prefix,
  // digits, spaces, hyphens, and parentheses.
  static final RegExp _phoneRegExp = RegExp(
    r'^\+?[0-9\s\-()]{7,15}$',
  );
}
