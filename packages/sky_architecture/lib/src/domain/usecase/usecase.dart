import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';

/// Represents an asynchronous use case.
///
/// Encapsulates business logic. Takes [Params] and returns a [Future]
/// containing either a [Failure] or a valid result of type [T].
abstract interface class UseCase<T, Params> {
  /// Creates a [UseCase].
  const UseCase();

  /// Runs the use case logic.
  Future<Either<Failure, T>> call(Params params);
}

/// Represents a synchronous use case.
///
/// Takes [Params] and returns either a [Failure] or a valid result of type [T].
abstract interface class SyncUseCase<T, Params> {
  /// Creates a [SyncUseCase].
  const SyncUseCase();

  /// Runs the use case logic synchronously.
  Either<Failure, T> call(Params params);
}

/// Represents a streaming use case.
///
/// Takes [Params] and returns a [Stream] containing either a [Failure] or a
/// valid result of type [T].
abstract interface class StreamUseCase<T, Params> {
  /// Creates a [StreamUseCase].
  const StreamUseCase();

  /// Runs the use case logic, returning a stream of results.
  Stream<Either<Failure, T>> call(Params params);
}
