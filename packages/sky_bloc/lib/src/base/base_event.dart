import 'package:equatable/equatable.dart';

/// {@template base_event}
/// Base class for all BLoC events in Sky applications.
/// {@endtemplate}
abstract class BaseEvent extends Equatable {
  /// {@macro base_event}
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

/// {@template base_started_event}
/// Standardized event indicating that a BLoC has been initialized or started.
///
/// Useful for triggering initial data fetching, local cache checks,
/// or setup logic on startup.
/// {@endtemplate}
class BaseStartedEvent extends BaseEvent {
  /// {@macro base_started_event}
  const BaseStartedEvent();
}
