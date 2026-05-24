import 'package:equatable/equatable.dart';
import 'package:sky_architecture/sky_architecture.dart';

/// {@template data_state}
/// A highly optimized native Dart 3 sealed class representing standard UI
/// states.
///
/// By using a `sealed` class hierarchy, the Dart compiler enforces complete,
/// exhaustive checking in switch statements/expressions, providing identical
/// safety to Freezed without any build_runner code-generation overhead.
///
/// Standard subtypes:
/// * [DataInitial]: The starting state before any operation begins.
/// * [DataLoading]: An operational process is running.
/// * [DataSuccess]: The operation finished successfully, carrying data [T].
/// * [DataFailure]: The operation failed, carrying a domain [Failure].
/// {@endtemplate}
sealed class DataState<T> extends Equatable {
  /// {@macro data_state}
  const DataState();

  @override
  List<Object?> get props => [];
}

/// {@template data_initial}
/// Initial starting state.
/// {@endtemplate}
class DataInitial<T> extends DataState<T> {
  /// {@macro data_initial}
  const DataInitial();
}

/// {@template data_loading}
/// Loading state.
/// {@endtemplate}
class DataLoading<T> extends DataState<T> {
  /// {@macro data_loading}
  const DataLoading();
}

/// {@template data_success}
/// Successful execution state, containing the loaded [data].
/// {@endtemplate}
class DataSuccess<T> extends DataState<T> {
  /// {@macro data_success}
  const DataSuccess(this.data);

  /// The successful output payload data.
  final T data;

  @override
  List<Object?> get props => [data];
}

/// {@template data_failure}
/// Failure state, containing the domain [failure].
/// {@endtemplate}
class DataFailure<T> extends DataState<T> {
  /// {@macro data_failure}
  const DataFailure(this.failure);

  /// The domain-level failure details.
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
