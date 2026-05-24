import 'package:sky_architecture/sky_architecture.dart';
import 'package:test/test.dart';

void main() {
  group('Domain Failures Equatable', () {
    test('ServerFailure supports equatable equality', () {
      const failure1 = ServerFailure(
        message: 'Conflict',
        code: '409',
        statusCode: 409,
      );
      const failure2 = ServerFailure(
        message: 'Conflict',
        code: '409',
        statusCode: 409,
      );
      const failure3 = ServerFailure(
        message: 'Not Found',
        code: '404',
        statusCode: 404,
      );

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
      expect(failure1.hashCode, equals(failure2.hashCode));
      expect(
        failure1.toString(),
        contains('ServerFailure: Conflict (Code: 409)'),
      );
    });

    test('NetworkFailure supports equatable equality', () {
      const failure1 = NetworkFailure(
        message: 'Timeout',
        code: 'TIMEOUT',
      );
      const failure2 = NetworkFailure(
        message: 'Timeout',
        code: 'TIMEOUT',
      );

      expect(failure1, equals(failure2));
    });

    test('CacheFailure supports equatable equality', () {
      const failure1 = CacheFailure(message: 'Read error');
      const failure2 = CacheFailure(message: 'Read error');

      expect(failure1, equals(failure2));
    });
  });
}
