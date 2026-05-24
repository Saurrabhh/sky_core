import 'package:sky_architecture/sky_architecture.dart';

abstract class BaseState {
  const BaseState();

  BaseState getLoadingState({required bool loading});

  BaseState getFailureState({required Failure failure});
}
