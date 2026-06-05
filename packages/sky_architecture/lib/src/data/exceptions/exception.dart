import 'package:equatable/equatable.dart';

/// A base class for data layer exceptions.
///
/// Provides properties for error message, error code, underlying error object,
/// and stack trace to help diagnose issues.
abstract class BaseException extends Equatable implements Exception {
  /// Creates a [BaseException] with the given [message], optional [code],
  /// underlying [error], and [stackTrace].
  const BaseException({
    required this.message,
    this.code,
    this.error,
    this.stackTrace,
  });

  /// A description of the exception.
  final String message;

  /// A code identifying the exception type.
  final String? code;

  /// The underlying error or exception object, if any.
  final Object? error;

  /// The stack trace associated with the error, if any.
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, code, error, stackTrace];

  @override
  String toString() {
    final buffer = StringBuffer()..write('$runtimeType: $message');
    if (code != null) {
      buffer.write(' (Code: $code)');
    }
    if (error != null) {
      buffer.write('\nUnderlying error: $error');
    }
    return buffer.toString();
  }
}
