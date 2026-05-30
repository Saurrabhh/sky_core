# sky_architecture

A pure Dart package providing core contracts, interfaces, and utilities for Clean Architecture domain and data layers. Highly optimized for functional programming styles using `fpdart` and value equality using `equatable`.

## Features

* **Functional Domain Layer:** Built-in `UseCase` patterns allowing both synchronous and asynchronous operations.
* **Failure Handling:** Integrated abstract `Failure` contract for domain-specific error handling.
* **Functional Result Pattern:** Native interoperability with `Either<Failure, T>` from `fpdart` for elegant, compile-safe error propagation.
* **Value Equality:** Direct base entities utilizing `Equatable` for efficient change-detection and UI updates.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_architecture: ^1.0.0
```

## Usage

Here is a quick example of a Clean Architecture `UseCase` and entity:

```dart
import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';

// 1. Define your Entity with value equality
class User extends Equatable {
  const User({required this.id, required this.name});
  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

// 2. Define a failure state
class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure() : super(message: 'User could not be found.');
}

// 3. Implement a clean UseCase
class GetUser extends UseCase<User, String> {
  const GetUser(this._repository);
  
  final UserRepository _repository;

  @override
  Future<Either<Failure, User>> call(String userId) async {
    return _repository.getUserById(userId);
  }
}

abstract class UserRepository {
  Future<Either<Failure, User>> getUserById(String id);
}
```
