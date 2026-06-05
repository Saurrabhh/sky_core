import 'package:sky_architecture/sky_architecture.dart';

/// Base class for all states managed by BLoCs or Cubits.
///
/// Requires implementing classes to provide methods for generating status-specific
/// state copies.
abstract class BaseState {
  /// Creates a [BaseState].
  const BaseState();

  /// Returns a new state copy indicating if an operation is [loading].
  BaseState getLoadingState({required bool loading});

  /// Returns a new state copy containing the specified [failure].
  BaseState getFailureState({required Failure failure});
}
