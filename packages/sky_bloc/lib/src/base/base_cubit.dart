import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/base_bloc.dart';
import 'package:sky_bloc/src/base/base_state.dart';

/// {@template base_cubit}
/// A highly optimized base [Cubit] implementation for Sky applications.
///
/// Standardizes how UI loaders and expected business errors are handled
/// and emitted, matching the API of [BaseBloc] for consistency.
/// {@endtemplate}
abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  /// {@macro base_cubit}
  BaseCubit(super.initialState);

  /// Sets the loading status of the current state.
  void setLoading({required bool isLoading}) {
    emit(state.copyWith(isLoading: isLoading) as S);
  }

  /// Handles expected business [failure]s returned by domain UseCases cleanly,
  /// automatically toggling loading off and emitting the failure value.
  void handleFailure(Failure failure) {
    emit(state.copyWith(isLoading: false, failure: failure) as S);
  }
}
