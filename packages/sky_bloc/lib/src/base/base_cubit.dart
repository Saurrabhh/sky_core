import 'package:bloc/bloc.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/base_state.dart';

abstract class BaseCubit<State extends BaseState> extends Cubit<State> {
  BaseCubit(super.initialState);

  bool get isLoading;

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
