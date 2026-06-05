import 'package:sky_architecture/src/domain/failures/failure.dart';

/// Represents a failure resulting from a server-side error.
class ServerFailure extends Failure {
  /// Creates a [ServerFailure] with the given [message], optional [code],
  /// and HTTP [statusCode].
  const ServerFailure({
    required super.message,
    super.code,
    this.statusCode,
  });

  /// The HTTP status code returned by the server, if available.
  final int? statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

/// Represents a failure resulting from a cache or local storage operation.
class CacheFailure extends Failure {
  /// Creates a [CacheFailure] with the given [message] and optional [code].
  const CacheFailure({
    required super.message,
    super.code,
  });
}

/// Represents a failure resulting from network communication issues.
class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure] with the given [message] and optional [code].
  const NetworkFailure({
    required super.message,
    super.code,
  });
}

/// Represents a failure due to invalid inputs or failed validation checks.
class ValidationFailure extends Failure {
  /// Creates a [ValidationFailure] with a [message] and optional [code].
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

/// Represents a failure from an unknown or unhandled source.
class UnknownFailure extends Failure {
  /// Creates an [UnknownFailure] with a [message] and optional [code].
  const UnknownFailure({
    required super.message,
    super.code,
  });
}
