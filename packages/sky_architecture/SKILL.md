---
name: sky-architecture
description: Guidelines on when and how to use the sky_architecture package for clean architecture classes
---

# sky_architecture Guidelines

This package provides the foundational types and interfaces for the domain and data layers.

## Guidelines & Checklists

### 1. UseCases
* All business logic actions must be modeled as a UseCase extending `UseCase<Type, Params>`:
  ```dart
  import 'package:sky_architecture/sky_architecture.dart';

  @lazySingleton
  final class MyUseCase implements UseCase<ResultType, MyParams> {
    const MyUseCase(this._repository);
    final MyRepository _repository;

    @override
    FutureEitherFailure<ResultType> call(MyParams params) {
      return _repository.execute(params.value);
    }
  }
  ```
* Every UseCase must define a corresponding `Params` class extending `Equatable`. If no params are needed, use `noParams`.

### 2. Functional Types (Either & Option)
* All use cases and repositories must return the `FutureEitherFailure<T>` type alias, representing `Future<Either<Failure, T>>`.
* Do not return nullable fields in data streams (e.g. Streams). Use `Option<T>` (e.g., `Some(value)` and `None()`).

### 3. Failures & Exception Mapping
* Data sources throw exceptions (e.g., `ServerException`).
* Repositories must catch exceptions and convert them to `Failure` objects using `.toFailure()` extension or custom mapping:
  ```dart
  try {
    final result = await _dataSource.call();
    return Right(result);
  } on Exception catch (e) {
    return Left(e.toFailure());
  }
  ```
