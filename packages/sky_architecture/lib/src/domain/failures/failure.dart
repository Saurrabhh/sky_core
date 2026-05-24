import 'package:equatable/equatable.dart';

/// {@template failure}
/// Unified domain-level base class representing errors, issues, or failures.
///
/// Unlike exceptions which are thrown and propagate up the stack, failures
/// are returned as values within `Either` containers. This encourages explicit
/// type-safe error handling throughout the application.
/// {@endtemplate}
abstract class Failure extends Equatable {
  /// {@macro failure}
  const Failure({
    required this.message,
    this.code,
    this.error,
    this.stackTrace,
  });

  /// A human-readable or developer-facing message explaining the error.
  final String message;

  /// An optional application-specific error code for classification or
  /// localization.
  final String? code;

  /// The original caught object or exception, if any.
  final Object? error;

  /// The stack trace associated with the original error.
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, code, error, stackTrace];

  @override
  String toString() {
    final buffer = StringBuffer()..write('$runtimeType: $message');
    if (code != null) {
      buffer.write(' (Code: $code)');
    }
    return buffer.toString();
  }
}
