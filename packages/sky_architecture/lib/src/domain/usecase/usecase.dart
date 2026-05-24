// UseCases are designed with a single 'call' method to serve as callables.
// ignore_for_file: one_member_abstracts

import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';

/// {@template use_case}
/// An abstract representation of an asynchronous business use case.
///
/// Every [UseCase] handles a single responsibility or business workflow.
/// It receives [Params], executes asynchronously, and returns either a
/// [Failure] on the left or [T] (success data) on the right.
///
/// Example:
/// ```dart
/// class GetUser extends UseCase<User, GetUserParams> {
///   GetUser(this.repository);
///   final UserRepository repository;
///
///   @override
///   Future<Either<Failure, User>> call(GetUserParams params) {
///     return repository.getUser(params.userId);
///   }
/// }
/// ```
/// {@endtemplate}
abstract class UseCase<T, Params> {
  /// {@macro use_case}
  const UseCase();

  /// Executes the business logic asynchronously.
  Future<Either<Failure, T>> call(Params params);
}

/// {@template sync_use_case}
/// An abstract representation of a synchronous business usecase.
///
/// Executes immediately in the current thread and returns either a [Failure]
/// or [T]. Used for in-memory operations, local config lookups,
/// or pure calculations.
/// {@endtemplate}
abstract class SyncUseCase<T, Params> {
  /// {@macro sync_use_case}
  const SyncUseCase();

  /// Executes the business logic synchronously.
  Either<Failure, T> call(Params params);
}

/// {@template stream_use_case}
/// An abstract representation of a reactive streaming business use case.
///
/// Returns a [Stream] of [Either<Failure, T>]. Useful for listening to
/// database changes, WebSockets, or active background computations.
/// {@endtemplate}
abstract class StreamUseCase<T, Params> {
  /// {@macro stream_use_case}
  const StreamUseCase();

  /// Executes and returns a reactive stream of results.
  Stream<Either<Failure, T>> call(Params params);
}
