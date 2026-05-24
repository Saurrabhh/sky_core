// UseCases are designed with a single 'call' method to serve as callables.
// ignore_for_file: one_member_abstracts

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
