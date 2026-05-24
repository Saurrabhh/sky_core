import 'package:sky_architecture/src/data/exceptions/exception.dart';
import 'package:sky_architecture/src/data/exceptions/exceptions.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';
import 'package:sky_architecture/src/domain/failures/failures.dart';

/// Extension to map Dart exceptions and errors safely into
/// domain-level [Failure]s.
extension ExceptionMapper on Object {
  /// Converts any caught exception, error, or object into a
  /// corresponding [Failure].
  ///
  /// This is used inside repositories (data layer) to map caught exceptions
  /// to pure type-safe failures returned as Left-values.
  Failure toFailure() {
    final self = this;

    if (self is ServerException) {
      return ServerFailure(
        message: self.message,
        code: self.code,
        error: self.error,
        stackTrace: self.stackTrace,
        statusCode: self.statusCode,
      );
    }

    if (self is CacheException) {
      return CacheFailure(
        message: self.message,
        code: self.code,
        error: self.error,
        stackTrace: self.stackTrace,
      );
    }

    if (self is NetworkException) {
      return NetworkFailure(
        message: self.message,
        code: self.code,
        error: self.error,
        stackTrace: self.stackTrace,
      );
    }

    if (self is ValidationException) {
      return ValidationFailure(
        message: self.message,
        code: self.code,
        error: self.error,
        stackTrace: self.stackTrace,
      );
    }

    if (self is SkyException) {
      return UnknownFailure(
        message: self.message,
        code: self.code,
        error: self,
        stackTrace: self.stackTrace,
      );
    }

    if (self is Error) {
      return UnknownFailure(
        message: self.toString(),
        stackTrace: self.stackTrace,
        error: self,
      );
    }

    if (self is Exception) {
      return UnknownFailure(
        message: self.toString(),
        error: self,
      );
    }

    return UnknownFailure(
      message: 'An unexpected error occurred: $self',
      error: self,
    );
  }
}
