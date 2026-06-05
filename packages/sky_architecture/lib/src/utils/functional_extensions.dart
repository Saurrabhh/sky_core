import 'package:fpdart/fpdart.dart';

/// Extensions on a [Future] that resolves to an [Either].
///
/// Simplifies chaining asynchronous operations in functional programming.
extension EitherFutureX<L, R> on Future<Either<L, R>> {
  /// Maps the right-side value of the [Either] using the function [f].
  Future<Either<L, T>> mapRight<T>(T Function(R right) f) {
    return then((either) => either.map(f));
  }

  /// Maps the left-side value of the [Either] using the function [f].
  Future<Either<T, R>> mapLeft<T>(T Function(L left) f) {
    return then((either) => either.mapLeft(f));
  }

  /// Flat-maps the right-side value of the [Either] using the function [f].
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

  /// Returns the right-side value if present, otherwise returns [orElse].
  Future<R> getOrElse(R Function(L left) orElse) {
    return then((either) => either.getOrElse(orElse));
  }

  /// Folds the result, applying [leftF] on left or [rightF] on right.
  Future<T> fold<T>(T Function(L left) leftF, T Function(R right) rightF) {
    return then((either) => either.fold(leftF, rightF));
  }
}
