import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';

/// Represents a result that is either a [Failure] on the left or a value of
/// type [T] on the right.
///
/// This typedef simplifies the signature of synchronous operations that can
/// fail.
///
/// Example:
/// ```dart
/// EitherFailure<User> getUser(String id);
/// ```
typedef EitherFailure<T> = Either<Failure, T>;

/// A specialized version of [EitherFailure] where the success type is [Unit].
///
/// Use this when an operation performs a side effect and returns no data on
/// success.
///
/// Example:
/// ```dart
/// EitherFailureUnit deleteUser(String id);
/// ```
typedef EitherFailureUnit = EitherFailure<Unit>;

/// Represents an asynchronous result that will eventually yield either a
/// [Failure] on the left or a value of type [T] on the right.
///
/// This is the standard return type for asynchronous methods, repositories,
/// and use cases.
///
/// Example:
/// ```dart
/// FutureEitherFailure<User> fetchUser(String id);
/// ```
typedef FutureEitherFailure<T> = Future<Either<Failure, T>>;

/// A specialized version of [FutureEitherFailure] where the success type is
/// [Unit].
///
/// Use this for asynchronous side effects that yield no data on success.
///
/// Example:
/// ```dart
/// FutureEitherFailureUnit saveUser(User user);
/// ```
typedef FutureEitherFailureUnit = FutureEitherFailure<Unit>;

/// Represents a stream of results that emit either a [Failure] on the left or a
/// value of type [T] on the right.
///
/// Example:
/// ```dart
/// StreamEitherFailure<User> watchUser(String id);
/// ```
typedef StreamEitherFailure<T> = Stream<Either<Failure, T>>;

/// A specialized version of [StreamEitherFailure] where the success type is
/// [Unit].
///
/// Use this for streams of operations that yield success signals with no data.
typedef StreamEitherFailureUnit = StreamEitherFailure<Unit>;

/// Represents a lazy, asynchronous computation that can fail with a [Failure]
/// or succeed with a value of type [T].
///
/// In functional programming, `TaskEither` is preferred over `Future` as it
/// defers execution (lazy evaluation) and represents side effects purely.
///
/// Example:
/// ```dart
/// TaskEitherFailure<User> getUserTask(String id) =>
///     TaskEither.fromRunnable(() => database.find(id));
/// ```
typedef TaskEitherFailure<T> = TaskEither<Failure, T>;

/// A specialized version of [TaskEitherFailure] where the success type is
/// [Unit].
///
/// Use this for lazy asynchronous side effects that yield no data on success.
typedef TaskEitherFailureUnit = TaskEitherFailure<Unit>;
