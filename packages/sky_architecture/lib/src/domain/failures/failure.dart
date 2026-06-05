import 'package:equatable/equatable.dart';

/// Represents a domain-level failure or error.
///
/// Failures represent expected errors that flow through the domain layer to
/// be handled by the user interface.
abstract class Failure extends Equatable implements Exception {
  /// Creates a [Failure] with the given [message] and optional [code].
  const Failure({
    required this.message,
    this.code,
  });

  /// A description of the failure.
  final String message;

  /// A code identifying the failure type.
  final String? code;

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() {
    final buffer = StringBuffer()..write('$runtimeType: $message');
    if (code != null) {
      buffer.write(' (Code: $code)');
    }
    return buffer.toString();
  }
}
