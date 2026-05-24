import 'package:sky_architecture/src/data/exceptions/exception.dart';

class ServerException extends SkyException {
  const ServerException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.statusCode,
  });

  final int? statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

class CacheException extends SkyException {
  const CacheException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class NetworkException extends SkyException {
  const NetworkException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class ValidationException extends SkyException {
  const ValidationException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class UnknownException extends SkyException {
  const UnknownException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}
