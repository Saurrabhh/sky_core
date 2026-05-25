import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';

abstract class UseCase<T, Params> {
  const UseCase();

  Future<Either<Failure, T>> call(Params params);
}

abstract class SyncUseCase<T, Params> {
  const SyncUseCase();

  Either<Failure, T> call(Params params);
}

abstract class StreamUseCase<T, Params> {
  const StreamUseCase();

  Stream<Either<Failure, T>> call(Params params);
}
