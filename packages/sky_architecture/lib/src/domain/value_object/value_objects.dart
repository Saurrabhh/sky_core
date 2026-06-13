import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failures.dart';
import 'package:sky_architecture/src/domain/value_object/value_object.dart';
import 'package:sky_architecture/src/utils/typedefs.dart';

/// Represents a validated user name in the domain layer.
class Name extends ValueObject<String> {
  /// Creates a [Name] value object.
  ///
  /// Validation is performed lazily when accessing the [value] property.
  /// A name is valid if it is not empty or composed solely of whitespace.
  const Name(this._input);

  final String _input;

  @override
  EitherFailure<String> get value {
    final trimmed = _input.trim();
    if (trimmed.isEmpty) {
      return left(const ValidationFailure(message: 'Name cannot be empty'));
    }
    return right(trimmed);
  }
}

/// Represents a validated email address in the domain layer.
class EmailAddress extends ValueObject<String> {
  /// Creates an [EmailAddress] value object.
  ///
  /// Validation is performed lazily when accessing the [value] property.
  /// An email address is valid if it is not empty and matches the standard
  /// email format.
  const EmailAddress(this._input);

  final String _input;

  @override
  EitherFailure<String> get value {
    final cleaned = _input.trim();
    if (cleaned.isEmpty) {
      return left(
        const ValidationFailure(message: 'Email address cannot be empty'),
      );
    }
    if (!_emailRegExp.hasMatch(cleaned)) {
      return left(
        const ValidationFailure(message: 'Invalid email address format'),
      );
    }
    return right(cleaned);
  }

  // Standard email validation pattern
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
}

/// Represents a validated phone number in the domain layer.
class PhoneNumber extends ValueObject<String> {
  /// Creates a [PhoneNumber] value object.
  ///
  /// Validation is performed lazily when accessing the [value] property.
  /// A phone number is valid if it is not empty and matches a pattern allowing
  /// an optional '+' prefix followed by 7 to 15 digits, spaces, hyphens, or
  /// parentheses.
  const PhoneNumber(this._input);

  final String _input;

  @override
  EitherFailure<String> get value {
    final cleaned = _input.trim();
    if (cleaned.isEmpty) {
      return left(
        const ValidationFailure(message: 'Phone number cannot be empty'),
      );
    }
    if (!_phoneRegExp.hasMatch(cleaned)) {
      return left(
        const ValidationFailure(message: 'Invalid phone number format'),
      );
    }
    return right(cleaned);
  }

  // A basic phone number regular expression allowing optional '+' prefix,
  // digits, spaces, hyphens, and parentheses.
  static final RegExp _phoneRegExp = RegExp(
    r'^\+?[0-9\s\-()]{7,15}$',
  );
}

/// Represents a validated password in the domain layer.
class Password extends ValueObject<String> {
  /// Creates a [Password] value object.
  ///
  /// Validation is performed lazily when accessing the [value] property.
  /// A password is valid if it is at least 6 characters in length.
  const Password(this._input);

  final String _input;

  @override
  EitherFailure<String> get value {
    if (_input.length < 6) {
      return left(
        const ValidationFailure(
          message: 'Password must be at least 6 characters',
        ),
      );
    }
    return right(_input);
  }
}
