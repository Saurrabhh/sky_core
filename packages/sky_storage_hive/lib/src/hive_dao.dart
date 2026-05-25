import 'package:hive_ce/hive.dart';

import 'package:sky_storage/sky_storage.dart';

class HiveDao<T> implements Dao<String, T> {
  const HiveDao({required this.box});

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
