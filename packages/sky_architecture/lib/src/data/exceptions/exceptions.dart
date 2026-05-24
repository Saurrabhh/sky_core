import 'package:sky_architecture/src/data/exceptions/exception.dart';

/// {@template server_exception}
/// Thrown when an error occurs during communications with a remote server/API.
/// Holds the optional HTTP status code or server-specific response metadata.
/// {@endtemplate}
class ServerException extends SkyException {
  /// {@macro server_exception}
  const ServerException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.statusCode,
  });

  /// The HTTP status code returned by the server, if applicable.
  final int? statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

/// {@template cache_exception}
/// Thrown when a local persistence or caching layer operation fails.
/// (e.g. Hive, SQFlite, SharedPreferences access issues).
/// {@endtemplate}
class CacheException extends SkyException {
  /// {@macro cache_exception}
  const CacheException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// {@template network_exception}
/// Thrown when a network-related issue occurs before any server response.
/// (e.g. socket exceptions, client connection timeouts, offline states).
/// {@endtemplate}
class NetworkException extends SkyException {
  /// {@macro network_exception}
  const NetworkException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// {@template validation_exception}
/// Thrown when data validation checks fail within data models or parsers
/// (e.g., JSON parsing mismatch, invalid DTO parameters).
/// {@endtemplate}
class ValidationException extends SkyException {
  /// {@macro validation_exception}
  const ValidationException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

/// {@template unknown_exception}
/// A fallback exception used when an unhandled error is caught in the
/// data layer.
/// {@endtemplate}
class UnknownException extends SkyException {
  /// {@macro unknown_exception}
  const UnknownException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}
