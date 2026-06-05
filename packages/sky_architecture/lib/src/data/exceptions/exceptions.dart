import 'package:sky_architecture/src/data/exceptions/exception.dart';

/// Exception thrown when a server-side error occurs.
class ServerException extends BaseException {
  /// Creates a [ServerException] with the given [message], optional [code],
  /// underlying [error], [stackTrace], and HTTP [statusCode].
  const ServerException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.statusCode,
  });

  /// The HTTP status code returned by the server, if available.
  final int? statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

/// Exception thrown when a local cache operation fails.
class CacheException extends BaseException {
  /// Creates a [CacheException] with the given [message], optional [code],
  /// underlying [error], and [stackTrace].
  const CacheException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// Exception thrown when a network communication error occurs.
class NetworkException extends BaseException {
  /// Creates a [NetworkException] with the given [message], optional [code],
  /// underlying [error], and [stackTrace].
  const NetworkException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// Exception thrown when validation fails on data.
class ValidationException extends BaseException {
  /// Creates a [ValidationException] with the given [message], optional [code],
  /// underlying [error], and [stackTrace].
  const ValidationException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// Exception thrown when an unknown or unclassified error occurs.
class UnknownException extends BaseException {
  /// Creates an [UnknownException] with the given [message], optional [code],
  /// underlying [error], and [stackTrace].
  const UnknownException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}
