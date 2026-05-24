import 'package:equatable/equatable.dart';
import 'package:sky_architecture/src/domain/usecase/usecase.dart';

/// {@template no_params}
/// A class used as a placeholder for [UseCase] or [SyncUseCase] parameters
/// when the operation requires no input arguments.
///
/// This avoids using arbitrary `null` or `void` types and ensures type safety.
/// {@endtemplate}
class NoParams extends Equatable {
  /// {@macro no_params}
  const NoParams();

  @override
  List<Object?> get props => [];
}
