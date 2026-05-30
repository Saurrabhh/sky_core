# sky_bloc

A premium Flutter package providing a standardized and hardened BLoC (Business Logic Component) state management core for Sky Core applications. It streamlines BLoC creations, standardizes observer telemetry, and integrates with core failures.

## Features

* **Standardized State Structures:** Out-of-the-box base state structures to manage loading, loaded, and error lifecycle stages.
* **Unified Error Mapping:** Automatic transformation of core domain `Failure` abstractions into readable user-facing states.
* **Built-in Observers:** Configured telemetry-hooked `BlocObserver` that records state transitions and uncaught errors to telemetry pipelines automatically.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_bloc: ^1.1.0
```

## Usage

Extend the standard components to build highly observable business logic flows:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_bloc/sky_bloc.dart';

// Define standard states
sealed class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  const UserLoaded(this.userName);
  final String userName;

  @override
  List<Object?> get props => [userName];
}

// Create your BLoC extending standard conventions
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._getUser) : super(UserInitial()) {
    on<FetchUserRequested>(_onFetchUser);
  }

  final GetUser _getUser;

  Future<void> _onFetchUser(
    FetchUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _getUser(event.id);
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserLoaded(user.name)),
    );
  }
}
```
