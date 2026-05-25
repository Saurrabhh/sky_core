import 'package:sky_architecture/src/data/exceptions/exception.dart';

class ServerException extends BaseException {
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

class CacheException extends BaseException {
  const CacheException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class NetworkException extends BaseException {
  const NetworkException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class ValidationException extends BaseException {
  const ValidationException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class UnknownException extends BaseException {
  const UnknownException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}
