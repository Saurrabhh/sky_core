import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:test/test.dart';

void main() {
  group('EitherFutureX Functional Extensions', () {
    test('mapRight transforms inner right value asynchronously', () async {
      final future = Future<Either<Failure, int>>.value(
        Either.right(10),
      );

      final result = await future.mapRight((right) => right * 2);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0), equals(20));
    });

    test('mapLeft transforms inner left failure asynchronously', () async {
      final future = Future<Either<Failure, int>>.value(
        Either.left(const ValidationFailure(message: 'Original Error')),
      );

      final result = await future.mapLeft(
        (left) => const ServerFailure(message: 'Mapped Error'),
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (left) {
          expect(left, isA<ServerFailure>());
          expect(left.message, equals('Mapped Error'));
        },
        (_) => fail('Should have failed'),
      );
    });

    test('flatMapRight chains success futures successfully', () async {
      final firstFuture = Future<Either<Failure, int>>.value(
        Either.right(5),
      );

      final chainedFuture = firstFuture.flatMapRight((rightVal) async {
        return Either.right(rightVal + 15);
      });

      final result = await chainedFuture;

      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0), equals(20));
    });

    test('flatMapRight bypasses chaining on failure states', () async {
      final firstFuture = Future<Either<Failure, int>>.value(
        Either.left(const NetworkFailure(message: 'Connection Timeout')),
      );

      var didChain = false;
      final chainedFuture = firstFuture.flatMapRight((_) async {
        didChain = true;
        return Either.right(100);
      });

      final result = await chainedFuture;

      expect(result.isLeft(), isTrue);
      expect(didChain, isFalse);
      expect(result.getOrElse((_) => -9), equals(-9));
    });

    test(
      'getOrElse resolves right values and applies orElse on lefts',
      () async {
        final successFuture = Future<Either<Failure, String>>.value(
          Either.right('Success'),
        );
        final failureFuture = Future<Either<Failure, String>>.value(
          Either.left(const ServerFailure(message: 'Internal Error')),
        );

        final successVal = await successFuture.getOrElse((_) => 'Fallback');
        final failureVal = await failureFuture.getOrElse((_) => 'Fallback');

        expect(successVal, equals('Success'));
        expect(failureVal, equals('Fallback'));
      },
    );

    test('fold collapses future either into expected value', () async {
      final successFuture = Future<Either<Failure, int>>.value(
        Either.right(100),
      );

      final foldedVal = await successFuture.fold(
        (left) => 'Error: ${left.message}',
        (right) => 'Success: $right',
      );

      expect(foldedVal, equals('Success: 100'));
    });
  });
}
