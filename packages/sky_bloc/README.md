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

Extend the standard components to build highly observable business logic flows.

`BaseBloc` and `BaseCubit` each take a typed `Params` parameter that is passed into `started()`. This replaces the old untyped `Map<String, dynamic>? args` pattern and gives you compile-time safety.

```dart
import 'package:sky_bloc/sky_bloc.dart';

// 1. Define a typed Params object
class FetchUserParams {
  const FetchUserParams({required this.userId});
  final String userId;
}

// 2. Define your state (extends BaseState)
sealed class UserState extends BaseState {
  const UserState({required this.store});
  final UserStateStore store;
}

// 3. Extend BaseBloc with all three type parameters
class UserBloc extends BaseBloc<UserEvent, UserState, FetchUserParams> {
  UserBloc(this._getUser) : super(UserState.initial(...));

  final GetUser _getUser;

  @override
  void handleEvents() {
    on<FetchUserRequested>(_onFetchUser);
  }

  @override
  void started(FetchUserParams params) {
    add(FetchUserRequested(userId: params.userId));
  }

  Future<void> _onFetchUser(
    FetchUserRequested event,
    Emitter<UserState> emit,
  ) async {
    changeLoadingState(emit: emit, loading: true);
    final result = await _getUser(event.userId);
    result.fold(
      (failure) => handleFailure(emit: emit, failure: failure),
      (user) => emit(UserState.loaded(...)),
    );
  }
}

// 4. For Cubits, extend BaseCubit<State, Params>
class ProfileCubit extends BaseCubit<ProfileState, ProfileParams> {
  ProfileCubit() : super(ProfileState.initial(...));

  @override
  void started(ProfileParams params) {
    // kick off logic with typed params
  }
}
```
