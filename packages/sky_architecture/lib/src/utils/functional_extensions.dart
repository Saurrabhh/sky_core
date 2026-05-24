import 'package:fpdart/fpdart.dart';

extension EitherFutureX<L, R> on Future<Either<L, R>> {
  Future<Either<L, T>> mapRight<T>(T Function(R right) f) {
    return then((either) => either.map(f));
  }

  Future<Either<T, R>> mapLeft<T>(T Function(L left) f) {
    return then((either) => either.mapLeft(f));
  }

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

  Future<R> getOrElse(R Function(L left) orElse) {
    return then((either) => either.getOrElse(orElse));
  }

  Future<T> fold<T>(T Function(L left) leftF, T Function(R right) rightF) {
    return then((either) => either.fold(leftF, rightF));
  }
}
