import 'package:bloc/bloc.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/bloc/base_event.dart';
import 'package:sky_bloc/src/base/bloc/base_state.dart';

/// A base BLoC implementation that standardizes event handling and status tracking.
///
/// Provides built-in support for loading indicators and failure propagation
/// using standard state transitions.
abstract class BaseBloc<Event extends BaseEvent, State extends BaseState, Params>
    extends Bloc<Event, State> {
  /// Creates a [BaseBloc] with the given [initialState] and sets up event handling.
  BaseBloc(super.initialState) {
    handleEvents();
  }

  /// Registers event handlers for this BLoC.
  ///
  /// Automatically called during initialization.
  void handleEvents();

  /// Starts the BLoC operations with parameters [params].
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
