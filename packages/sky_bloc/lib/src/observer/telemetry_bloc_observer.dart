import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

class TelemetryBlocObserver extends BlocObserver {
  const TelemetryBlocObserver(this._skyLogging);

  final SkyLogging _skyLogging;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _skyLogging.debug('BLoC Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _skyLogging.debug(
      'BLoC Change (${bloc.runtimeType}): '
      '${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _skyLogging.warning(
      'BLoC Error (${bloc.runtimeType}): $error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _skyLogging.debug('BLoC Closed: ${bloc.runtimeType}');
  }
}
