import 'package:equatable/equatable.dart';
import 'package:sky_architecture/sky_architecture.dart';

/// {@template base_state}
/// Base class for all BLoC states in Sky applications.
///
/// Ensures that every UI state contains standard fields to represent loading
/// processes ([isLoading]) and expected business failures ([failure]) natively.
///
/// Subclasses are required to implement [copyWith] to support type-safe,
/// standardized mutations.
/// {@endtemplate}
abstract class BaseState extends Equatable {
  /// {@macro base_state}
  const BaseState({
    required this.isLoading,
    this.failure,
  });

  /// Indicates whether a process is currently executing.
  final bool isLoading;

  /// The active domain [Failure], if any operation failed.
  final Failure? failure;

  /// Standard contract to produce a copy of the state with updated parameters.
  BaseState copyWith({
    bool? isLoading,
    Failure? failure,
  });

  @override
  List<Object?> get props => [isLoading, failure];
}
