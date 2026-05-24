import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';

/// {@template value_object}
/// Base class for all Domain Value Objects.
///
/// In Domain-Driven Design (DDD), a [ValueObject] has no identity and is
/// defined solely by its properties. It is immutable, and validation is
/// typically performed on instantiation, returning either a [Failure] on the
/// left or the validated value [T] on the right.
///
/// Example:
/// ```dart
/// class EmailAddress extends ValueObject<String> {
///   factory EmailAddress(String input) {
///     return EmailAddress._(
///       input.contains('@')
///           ? Either.right(input)
///           : Either.left(const ValidationFailure(message: 'Invalid email')),
///     );
///   }
///   const EmailAddress._(this.value);
///
///   @override
///   final Either<Failure, String> value;
/// }
/// ```
/// {@endtemplate}
abstract class ValueObject<T> extends Equatable {
  /// {@macro value_object}
  const ValueObject();

  /// The functional container representing the validated value or a domain
  /// [Failure].
  Either<Failure, T> get value;

  /// Checks if the value is valid (Right).
  bool isValid() => value.isRight();

  /// Checks if the value is invalid (Left).
  bool isInvalid() => value.isLeft();

  /// Safely retrieves the inner value, falling back to [defaultValue] if a
  /// [Failure] exists.
  T getOrElse(T defaultValue) => value.getOrElse((_) => defaultValue);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '$runtimeType(value: $value)';
}
