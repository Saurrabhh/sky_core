import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  const BaseException({
    required this.message,
    this.code,
    this.error,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final Object? error;
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
