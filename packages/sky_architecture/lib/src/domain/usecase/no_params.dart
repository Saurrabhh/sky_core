import 'package:equatable/equatable.dart';

/// Represents empty parameters for use cases that do not require input.
class NoParams extends Equatable {
  /// Creates a [NoParams] instance.
  const NoParams();

  @override
  List<Object?> get props => [];
}
