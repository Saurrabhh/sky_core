import 'package:equatable/equatable.dart';
import 'package:sky_architecture/sky_architecture.dart';

/// Represents a Domain-Driven Design Value Object.
///
/// An object whose identity is defined by its properties rather than a unique
/// identifier. Enforces invariants by holding either a [Failure] or a valid [T]
/// value.
///
/// Example:
/// ```dart
/// class EmailAddress extends ValueObject<String> {
///   @override
///   final EitherFailure<String> value;
///
///   const EmailAddress(this.value);
/// }
/// ```
abstract class ValueObject<T> extends Equatable {
  /// Creates a [ValueObject].
  const ValueObject();

  /// The underlying value, containing either a [Failure] or a valid value [T].
  EitherFailure<T> get value;

  /// Returns true if the value is valid.
  bool isValid() => value.isRight();

  /// Returns true if the value is invalid due to a failure.
  bool isInvalid() => value.isLeft();

  /// Returns the valid value, or [defaultValue] if a failure occurred.
  T getOrElse(T defaultValue) => value.getOrElse((_) => defaultValue);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '$runtimeType(value: $value)';
}
