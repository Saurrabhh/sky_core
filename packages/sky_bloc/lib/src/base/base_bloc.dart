import 'package:bloc/bloc.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/base_event.dart';
import 'package:sky_bloc/src/base/base_state.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<Event, State> {
  BaseBloc(super.initialState) {
    handleEvents();
  }

  bool get isLoading;

  void handleEvents();

  void started({Map<String, dynamic>? args});

  void setLoading({
    required Emitter<BaseState> emit,
    required bool loading,
  }) {
    emit(state.getLoadingState(loading: loading));
  }

  void handleFailure({
    required Emitter<BaseState> emit,
    required Failure failure,
  }) {
    emit(state.getFailureState(failure: failure));
  }
}
