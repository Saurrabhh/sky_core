import 'package:equatable/equatable.dart';

/// {@template entity}
/// Base class for all Domain Entities.
///
/// In Domain-Driven Design (DDD), an [Entity] represents a business object that
/// has a unique identity ([id]) which distinguishes it from other instances of
/// the same type, even if all other fields are identical.
///
/// Equality is strictly based on the [id].
/// {@endtemplate}
abstract class Entity<Id> extends Equatable {
  /// {@macro entity}
  const Entity(this.id);

  /// The unique identifier of this entity.
  final Id id;

  @override
  List<Object?> get props => [id];

  @override
  String toString() => '$runtimeType(id: $id)';
}
