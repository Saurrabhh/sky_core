import 'package:sky_architecture/sky_architecture.dart';
import 'package:test/test.dart';

void main() {
  group('Exceptions & Mapper', () {
    test('ServerException holds and formats data correctly', () {
      final stackTrace = StackTrace.current;
      final exception = ServerException(
        message: 'Server Timeout',
        code: '504',
        statusCode: 504,
        error: 'Timeout occurred',
        stackTrace: stackTrace,
      );

      expect(exception.message, equals('Server Timeout'));
      expect(exception.code, equals('504'));
      expect(exception.statusCode, equals(504));
      expect(exception.error, equals('Timeout occurred'));
      expect(exception.stackTrace, equals(stackTrace));
      expect(
        exception.toString(),
        contains('ServerException: Server Timeout (Code: 504)'),
      );
    });

    test('ExceptionMapper maps ServerException to ServerFailure', () {
      const exception = ServerException(
        message: 'Server error',
        code: 'INTERNAL_ERROR',
        statusCode: 500,
        error: 'DB connection down',
      );

      final failure = exception.toFailure();

      expect(failure, isA<ServerFailure>());
      final serverFailure = failure as ServerFailure;
      expect(serverFailure.message, equals('Server error'));
      expect(serverFailure.code, equals('INTERNAL_ERROR'));
      expect(serverFailure.statusCode, equals(500));
      expect(serverFailure.error, equals('DB connection down'));
    });

    test('ExceptionMapper maps CacheException to CacheFailure', () {
      const exception = CacheException(
        message: 'Disk full',
        code: 'WRITE_FAIL',
      );

      final failure = exception.toFailure();

      expect(failure, isA<CacheFailure>());
      expect(failure.message, equals('Disk full'));
      expect(failure.code, equals('WRITE_FAIL'));
    });

    test('ExceptionMapper maps NetworkException to NetworkFailure', () {
      const exception = NetworkException(
        message: 'No internet',
        code: 'OFFLINE',
      );

      final failure = exception.toFailure();

      expect(failure, isA<NetworkFailure>());
      expect(failure.message, equals('No internet'));
      expect(failure.code, equals('OFFLINE'));
    });

    test('ExceptionMapper maps ValidationException to ValidationFailure', () {
      const exception = ValidationException(
        message: 'Invalid JSON schema',
        code: 'PARSING_ERROR',
      );

      final failure = exception.toFailure();

      expect(failure, isA<ValidationFailure>());
      expect(failure.message, equals('Invalid JSON schema'));
      expect(failure.code, equals('PARSING_ERROR'));
    });

    test('ExceptionMapper maps raw Object to UnknownFailure', () {
      const rawError = 'Some arbitrary error message';
      final failure = rawError.toFailure();

      expect(failure, isA<UnknownFailure>());
      expect(failure.message, contains('Some arbitrary error message'));
      expect(failure.error, equals(rawError));
    });
  });
}
