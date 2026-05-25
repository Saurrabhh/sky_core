import 'package:hive_ce/hive.dart';

import 'package:sky_storage/sky_storage.dart';

/// {@template hive_dao}
/// A highly optimized generic [Dao] implementation wrapping a Hive [Box].
///
/// Operates on keys of type [String].
/// {@endtemplate}
class HiveDao<T> implements Dao<String, T> {
  /// {@macro hive_dao}
  const HiveDao({required this.box});

  /// Exposes the underlying Hive [Box] for advanced, database-specific
  /// actions.
  final Box<T> box;

  @override
  Future<void> put(String key, T value) async {
    await box.put(key, value);
  }

  @override
  Future<T?> get(String key) async {
    return box.get(key);
  }

  @override
  Future<List<T>> getAll() async {
    return box.values.toList();
  }

  @override
  Future<void> delete(String key) async {
    await box.delete(key);
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }

  @override
  Stream<List<T>> watchAll() async* {
    yield box.values.toList();
    await for (final _ in box.watch()) {
      yield box.values.toList();
    }
  }
}
