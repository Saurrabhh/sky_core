import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

export 'package:fpdart/fpdart.dart';

/// Base class for all failures in the Sky Core ecosystem.
abstract class Failure extends Equatable {
  /// A human-readable message describing the failure.
  final String message;

  /// Creates a [Failure] with the given [message].
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Typedef for a result that can be either a [Failure] or a value of type [T].
typedef Result<T> = Either<Failure, T>;

/// Typedef for a future result.
typedef FutureResult<T> = Future<Result<T>>;

/// Represents a failure during network operations.
class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure] with the given [message].
  const NetworkFailure(super.message);
}

/// Represents a failure during cache operations.
class CacheFailure extends Failure {
  /// Creates a [CacheFailure] with the given [message].
  const CacheFailure(super.message);
}

/// Represents a failure on the server side.
class ServerFailure extends Failure {
  /// Creates a [ServerFailure] with the given [message].
  const ServerFailure(super.message);
}

/// Represents a failure during logic or form validation.
class ValidationFailure extends Failure {
  /// Creates a [ValidationFailure] with the given [message].
  const ValidationFailure(super.message);
}

/// A fallback for any unexpected errors.
class UnexpectedFailure extends Failure {
  /// Creates an [UnexpectedFailure] with the given [message].
  const UnexpectedFailure(super.message);
}
