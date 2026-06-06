import 'package:bloc/bloc.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/bloc/base_state.dart';

/// A base Cubit implementation that standardizes status tracking and error handling.
///
/// Provides basic hooks for checking loading state, starting actions, and
/// emitting standard loading and failure states.
abstract class BaseCubit<State extends BaseState> extends Cubit<State> {
  /// Creates a [BaseCubit] with the given [initialState].
  BaseCubit(super.initialState);

  /// Indicates if the Cubit is currently processing an operation.
  bool get isLoading;

  /// Starts the Cubit operations with optional configuration arguments [args].
  void started({Map<String, dynamic>? args});

  /// Emits a state update indicating changes to the loading status.
  void setLoading({required Emitter<BaseState> emit, required bool loading}) {
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
