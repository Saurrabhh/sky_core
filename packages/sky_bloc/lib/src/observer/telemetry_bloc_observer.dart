import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

/// {@template telemetry_bloc_observer}
/// A highly optimized [BlocObserver] integrating BLoC lifecycles with
/// the `SkyLogging` system.
///
/// Automatically logs creations, state transitions, closures, and errors
/// at standard severity levels (debug and warning) in a non-spammy,
/// single-line format.
/// {@endtemplate}
class TelemetryBlocObserver extends BlocObserver {
  /// {@macro telemetry_bloc_observer}
  const TelemetryBlocObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    SkyLogging.instance.debug('BLoC Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    SkyLogging.instance.debug(
      'BLoC Change (${bloc.runtimeType}): '
      '${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    SkyLogging.instance.warning(
      'BLoC Error (${bloc.runtimeType}): $error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    SkyLogging.instance.debug('BLoC Closed: ${bloc.runtimeType}');
  }
}
