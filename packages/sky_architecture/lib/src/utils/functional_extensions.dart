import 'package:fpdart/fpdart.dart';

/// Extension to ease functional operations on asynchronous `Either` results
/// (`Future<Either<L, R>>`).
///
/// This greatly reduces boilerplate when working with futures that return
/// `Either` containers (which is standard for repository and use case
/// boundaries).
extension EitherFutureX<L, R> on Future<Either<L, R>> {
  /// Maps the Right value of this Future [Either] if it succeeds, leaving Left
  /// untouched.
  ///
  /// Example:
  /// ```dart
  /// Future<Either<Failure, int>> countFuture =
  ///     getCount().mapRight((user) => user.postCount);
  /// ```
  Future<Either<L, T>> mapRight<T>(T Function(R right) f) {
    return then((either) => either.map(f));
  }

  /// Maps the Left value of this Future [Either] if it fails, leaving Right
  /// untouched.
  Future<Either<T, R>> mapLeft<T>(T Function(L left) f) {
    return then((either) => either.mapLeft(f));
  }

  /// Flat-maps (chains) another asynchronous operation returning an [Either].
  ///
  /// Useful when an operation depends on the successful output of the current
  /// future.
  Future<Either<L, T>> flatMapRight<T>(
    Future<Either<L, T>> Function(R right) f,
  ) {
    return then(
      (either) => either.fold(
        (left) => Future.value(Either<L, T>.left(left)),
        f,
      ),
    );
  }

  /// Safe retrieval of the Right value, falling back to [orElse] if the
  /// result is Left.
  Future<R> getOrElse(R Function(L left) orElse) {
    return then((either) => either.getOrElse(orElse));
  }

  /// Collapses (folds) the asynchronous [Either] into a single value of
  /// type [T].
  Future<T> fold<T>(T Function(L left) leftF, T Function(R right) rightF) {
    return then((either) => either.fold(leftF, rightF));
  }
}
