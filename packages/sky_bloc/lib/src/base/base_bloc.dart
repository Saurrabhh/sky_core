import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/base_event.dart';
import 'package:sky_bloc/src/base/base_state.dart';

/// {@template base_bloc}
/// A highly optimized base [Bloc] implementation for Sky applications.
///
/// Standardizes how UI loaders and expected business errors are handled
/// and emitted, reducing feature-level boilerplate.
/// {@endtemplate}
abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  /// {@macro base_bloc}
  BaseBloc(super.initialState);

  /// Sets the loading status of the current state.
  void setLoading({required bool isLoading}) {
    // Emitting state outside event handlers is allowed in this core base
    // class framework helper.
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(isLoading: isLoading) as S);
  }

  /// Handles expected business [failure]s returned by domain UseCases cleanly,
  /// automatically toggling loading off and emitting the failure value.
  void handleFailure(Failure failure) {
    // Emitting state outside event handlers is allowed in this core base
    // class framework helper.
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(isLoading: false, failure: failure) as S);
  }
}
