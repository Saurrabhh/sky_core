import 'package:sky_architecture/src/data/exceptions/exception.dart';
import 'package:sky_architecture/src/data/exceptions/exceptions.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';
import 'package:sky_architecture/src/domain/failures/failures.dart';

extension ExceptionMapper on Object {
  Failure toFailure() {
    final self = this;

    if (self is ServerException) {
      return ServerFailure(
        message: self.message,
        code: self.code,
        statusCode: self.statusCode,
      );
    }

    if (self is CacheException) {
      return CacheFailure(
        message: self.message,
        code: self.code,
      );
    }

    if (self is NetworkException) {
      return NetworkFailure(
        message: self.message,
        code: self.code,
      );
    }

    if (self is ValidationException) {
      return ValidationFailure(
        message: self.message,
        code: self.code,
      );
    }

    if (self is BaseException) {
      return UnknownFailure(
        message: self.message,
        code: self.code,
      );
    }

    if (self is Error) {
      return UnknownFailure(
        message: self.toString(),
      );
    }

    if (self is Exception) {
      return UnknownFailure(
        message: self.toString(),
      );
    }

    return UnknownFailure(
      message: 'An unexpected error occurred: $self',
    );
  }
}
