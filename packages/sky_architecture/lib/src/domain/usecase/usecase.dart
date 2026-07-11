import 'package:sky_architecture/sky_architecture.dart';

/// Represents an asynchronous use case.
///
/// Encapsulates business logic. Takes [Params] and returns a [Future]
/// containing either a [Failure] or a valid result of type [T].
abstract interface class UseCase<T, Params> {
  /// Creates a [UseCase].
  const UseCase();

  /// Runs the use case logic.
  FutureEitherFailure<T> call(Params params);
}

/// Represents a synchronous use case.
///
/// Takes [Params] and returns either a [Failure] or a valid result of type [T].
abstract interface class SyncUseCase<T, Params> {
  /// Creates a [SyncUseCase].
  const SyncUseCase();

  /// Runs the use case logic synchronously.
  EitherFailure<T> call(Params params);
}

/// Represents a streaming use case.
///
/// Takes [Params] and returns a [Stream] containing either a [Failure] or a
/// valid result of type [T].
abstract interface class StreamUseCase<T, Params> {
  /// Creates a [StreamUseCase].
  const StreamUseCase();

  /// Runs the use case logic, returning a stream of results.
  StreamEitherFailure<T> call(Params params);
}

/// Represents a streaming use case that returns an [Option].
///
/// Takes [Params] and returns a [Stream] containing an [Option] of type [T].
/// Useful for observing data that may or may not exist.
abstract interface class StreamOptionUseCase<T, Params> {
  /// Creates a [StreamOptionUseCase].
  const StreamOptionUseCase();

  /// Runs the use case logic, returning a stream of options.
  StreamOption<T> call(Params params);
}
