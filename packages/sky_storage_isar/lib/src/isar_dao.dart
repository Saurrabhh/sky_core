import 'package:isar_community/isar.dart';

import 'package:sky_storage/sky_storage.dart';

class IsarDao<T> implements Dao<int, T> {
  const IsarDao({required this.collection});

  final IsarCollection<T> collection;

  @override
  Future<void> put(int id, T value) async {
    await collection.isar.writeTxn(() async {
      await collection.put(value);
    });
  }

  @override
  Future<T?> get(int id) async {
    return collection.get(id);
  }

  @override
  Future<List<T>> getAll() async {
    return collection.where().findAll();
  }

  @override
  Future<void> delete(int id) async {
    await collection.isar.writeTxn(() async {
      await collection.delete(id);
    });
  }

  @override
  Future<void> clear() async {
    await collection.isar.writeTxn(() async {
      await collection.clear();
    });
  }

  @override
  Stream<List<T>> watchAll() {
    return collection
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => getAll());
  }
}
