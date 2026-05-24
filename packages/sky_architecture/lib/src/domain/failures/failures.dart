import 'package:sky_architecture/src/domain/failures/failure.dart';

/// {@template server_failure}
/// Represents a failure encountered while interacting with a remote server/API.
/// {@endtemplate}
class ServerFailure extends Failure {
  /// {@macro server_failure}
  const ServerFailure({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.statusCode,
  });

  /// Optional HTTP response status code returned by the server.
  final int? statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

/// {@template cache_failure}
/// Represents a failure encountered within a local persistence or caching
/// layer.
/// {@endtemplate}
class CacheFailure extends Failure {
  /// {@macro cache_failure}
  const CacheFailure({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// {@template network_failure}
/// Represents a failure due to network instability or offline status.
/// {@endtemplate}
class NetworkFailure extends Failure {
  /// {@macro network_failure}
  const NetworkFailure({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// {@template validation_failure}
/// Represents a domain or data validation failure.
/// {@endtemplate}
class ValidationFailure extends Failure {
  /// {@macro validation_failure}
  const ValidationFailure({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// {@template unknown_failure}
/// A fallback failure for unhandled errors.
/// {@endtemplate}
class UnknownFailure extends Failure {
  /// {@macro unknown_failure}
  const UnknownFailure({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}
