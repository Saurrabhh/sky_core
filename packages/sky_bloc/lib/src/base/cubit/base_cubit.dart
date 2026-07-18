import 'package:bloc/bloc.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/bloc/base_state.dart';

/// A base Cubit implementation that standardizes status tracking and error handling.
///
/// Provides basic hooks for checking loading state, starting actions, and
/// emitting standard loading and failure states.
abstract class BaseCubit<State extends BaseState, Params> extends Cubit<State> {
  /// Creates a [BaseCubit] with the given [initialState].
  BaseCubit(super.initialState);

  /// Starts the Cubit operations with parameters [params].
  void started(Params params);

  /// Emits a state update indicating changes to the loading status.
  void changeLoadingState({
    required Emitter<BaseState> emit,
    required bool loading,
  }) {
    emit(state.getLoadingState(loading: loading));
  }

  /// Emits a state update representing a failure condition.
  void handleFailure({
    required Emitter<BaseState> emit,
    required Failure failure,
  }) {
    emit(state.getFailureState(failure: failure));
  }
}
