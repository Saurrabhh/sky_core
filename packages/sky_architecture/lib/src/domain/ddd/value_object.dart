import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/src/domain/failures/failure.dart';

abstract class ValueObject<T> extends Equatable {
  const ValueObject();

  Either<Failure, T> get value;

  bool isValid() => value.isRight();

  bool isInvalid() => value.isLeft();

  T getOrElse(T defaultValue) => value.getOrElse((_) => defaultValue);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '$runtimeType(value: $value)';
}
