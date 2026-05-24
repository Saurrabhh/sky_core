import 'package:equatable/equatable.dart';

/// {@template sky_exception}
/// Base class for all exceptions thrown within the Sky core suite.
///
/// Exceptions represent operational or system errors encountered in the data
/// layer (e.g. databases, HTTP clients, external plugins) and should be caught
/// and mapped to domain-level `Failure` objects before reaching presentation.
/// {@endtemplate}
abstract class SkyException extends Equatable implements Exception {
  /// {@macro sky_exception}
  const SkyException({
    required this.message,
    this.code,
    this.error,
    this.stackTrace,
  });

  /// A descriptive message explaining the reason for the exception.
  final String message;

  /// An optional application-specific error code for classification or
  /// localization.
  final String? code;

  /// The underlying raw error or exception object, if any.
  final Object? error;

  /// The stack trace associated with this exception, if available.
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
