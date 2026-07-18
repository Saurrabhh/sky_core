import 'package:isar_community/isar.dart';
import 'package:sky_storage/sky_storage.dart';

/// A [DaoSync] implementation that uses Isar for synchronous persistence.
///
/// Manages objects of type [T] using integer keys.
class IsarDaoSync<T> implements DaoSync<int, T> {
  /// Creates an [IsarDaoSync] using the specified [collection].
  const IsarDaoSync({required this.collection});

  /// The underlying Isar collection.
  final IsarCollection<T> collection;

  @override
  void put(int id, T value) {
    collection.isar.writeTxnSync(() {
      collection.putSync(value);
    });
  }

  @override
  T? get(int id) {
    return collection.getSync(id);
  }

  @override
  List<T> getAll() {
    return collection.where().findAllSync();
  }

  @override
  void delete(int id) {
    collection.isar.writeTxnSync(() {
      collection.deleteSync(id);
    });
  }

  @override
  void clear() {
    collection.isar.writeTxnSync(collection.clearSync);
  }

  @override
  Stream<List<T>> watchAll() {
    return collection.watchLazy(fireImmediately: true).map((_) => getAll());
  }
}
