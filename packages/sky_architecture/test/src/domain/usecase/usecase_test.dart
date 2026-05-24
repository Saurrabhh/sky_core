import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:test/test.dart';

// Mock Asynchronous UseCase
class AsyncGetUser extends UseCase<String, int> {
  @override
  Future<Either<Failure, String>> call(int params) async {
    if (params < 0) {
      return Either.left(const ValidationFailure(message: 'Invalid user ID'));
    }
    return Either.right('User_$params');
  }
}

// Mock Synchronous UseCase
class SyncValidateCode extends SyncUseCase<bool, String> {
  @override
  Either<Failure, bool> call(String params) {
    if (params.isEmpty) {
      return Either.left(
        const ValidationFailure(message: 'Code cannot be empty'),
      );
    }
    return Either.right(params == 'SKY_CODE');
  }
}

// Mock Stream UseCase
class StreamUserStatus extends StreamUseCase<String, int> {
  @override
  Stream<Either<Failure, String>> call(int params) async* {
    if (params < 0) {
      yield Either.left(const ValidationFailure(message: 'Invalid User ID'));
      return;
    }
    yield Either.right('StatusOnline_$params');
  }
}

void main() {
  group('UseCases Execution tests', () {
    group('UseCase (Asynchronous)', () {
      late AsyncGetUser useCase;

      setUp(() {
        useCase = AsyncGetUser();
      });

      test('returns Right on success', () async {
        final result = await useCase(42);

        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => ''), equals('User_42'));
      });

      test('returns Left on validation failure', () async {
        final result = await useCase(-1);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, equals('Invalid user ID'));
          },
          (_) => fail('Should have returned a failure'),
        );
      });
    });

    group('SyncUseCase (Synchronous)', () {
      late SyncValidateCode useCase;

      setUp(() {
        useCase = SyncValidateCode();
      });

      test('returns Right with true on valid code', () {
        final result = useCase('SKY_CODE');

        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => false), isTrue);
      });

      test('returns Left on empty code', () {
        final result = useCase('');

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, equals('Code cannot be empty'));
          },
          (_) => fail('Should have failed'),
        );
      });
    });

    group('StreamUseCase (Reactive)', () {
      late StreamUserStatus useCase;

      setUp(() {
        useCase = StreamUserStatus();
      });

      test('emits Right values', () async {
        final streamResult = useCase(5);

        final listResult = await streamResult.toList();
        expect(listResult, hasLength(1));
        expect(listResult.first.isRight(), isTrue);
        expect(listResult.first.getOrElse((_) => ''), equals('StatusOnline_5'));
      });
    });

    group('NoParams Equatable', () {
      test('NoParams equals NoParams', () {
        const noParams1 = NoParams();
        const noParams2 = NoParams();

        expect(noParams1, equals(noParams2));
      });
    });
  });
}
