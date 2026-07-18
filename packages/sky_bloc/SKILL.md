---
name: sky-bloc
description: Guidelines on state management and UI pages using sky_bloc
---

# sky_bloc Guidelines

This package provides BloC, State, and Page base classes.

## Guidelines & Checklists

### 1. BloC Definition
* Implement BloCs by extending `BaseBloc<Event, State, Params>`.
* Construct state using a Freezed sealed class that extends `BaseState`.
* Define a single `store` property containing a Freezed class `StateStore` to manage all data fields.
* Register event handlers in `handleEvents()` using `on<Event>(_handler)`.

### 2. Overriding BaseState Methods
* State classes must override:
  * `getLoadingState({required bool loading})`: Returns a state updated with the new loading value.
  * `getFailureState({required Failure failure})`: Returns a state containing the failure.
  ```dart
  @override
  MyState getLoadingState({required bool loading}) {
    return MyState.onLoadingStateChange(store: store.copyWith(loading: loading));
  }
  ```

### 3. Emitting States and Handling Async Operations
* Use `changeLoadingState(emit: emit, loading: true)` to start loading.
* Use `handleFailure(emit: emit, failure: failure)` to emit a failure state.

### 4. BasePage UI
* UI pages must extend `BasePage<Bloc, State>`.
* Implement `createBloc()` to inject the bloc using `getIt<MyBloc>()..started(params)`, where `params` is a typed object matched to the BLoC/Cubit's `Params` type parameter.
* Implement `buildPage(BuildContext context)` to define the page content.
* Optionally override `showLoading()` and `handleStateChange()` to handle loading bars and side-effects.

### 5. BaseCubit Definition
* Implement Cubits by extending `BaseCubit<State, Params>` (two type parameters, same as `BaseBloc`).
* `started(Params params)` is the single entry point — do not call it without a well-typed `Params` object.
* Use `changeLoadingState(emit: emit, loading: true/false)` to toggle loading (previously `setLoading`; `setLoading` has been removed).
* There is no `isLoading` getter on `BaseCubit` — derive loading status from `state.store.loading`.

### Code Examples

#### State Definition Example
```dart
part of 'login_bloc.dart';

@freezed
sealed class LoginState extends BaseState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial({
    required LoginStateStore store,
  }) = Initial;

  const factory LoginState.onEmailChange({
    required LoginStateStore store,
  }) = OnEmailChange;

  const factory LoginState.onLoginSuccess({
    required LoginStateStore store,
  }) = OnLoginSuccess;

  const factory LoginState.onLoadingStateChange({
    required LoginStateStore store,
  }) = OnLoadingStateChange;

  const factory LoginState.onFailure({
    required LoginStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  LoginState getLoadingState({required bool loading}) {
    return LoginState.onLoadingStateChange(
      store: store.copyWith(loading: loading),
    );
  }

  @override
  LoginState getFailureState({required Failure failure}) {
    return LoginState.onFailure(
      store: store.copyWith(loading: false),
      failure: failure,
    );
  }
}

@freezed
class LoginStateStore with _$LoginStateStore {
  const LoginStateStore({
    this.loading = false,
    this.email = '',
    this.password = '',
  });

  @override
  final bool loading;
  @override
  final String email;
  @override
  final String password;
}
```

#### UI Page Example
```dart
import 'package:flutter/material';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:splittr/di/injection.dart';

class LoginPage extends BasePage<LoginBloc, LoginState> {
  const LoginPage({required this.params, super.key});

  final LoginParams params;

  @override
  LoginBloc createBloc() => getIt<LoginBloc>()..started(params);

  @override
  bool showLoading(LoginState state) => state.store.loading;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: 'Login'),
      body: const LoginForm(),
    );
  }

  @override
  void handleStateChange(BuildContext context, LoginState state) {
    switch (state) {
      case OnFailure(:final failure):
        AppSnackBar.show(
          context,
          message: failure.message,
        );
      case OnLoginSuccess():
        context.router.replace(RoutePaths.dashboard);
      default:
        break;
    }
  }
}
```
