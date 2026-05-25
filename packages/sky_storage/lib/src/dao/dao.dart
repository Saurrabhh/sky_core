abstract interface class Dao<ID, T> {
  Future<void> put(ID id, T value);

  Future<T?> get(ID id);

  Future<List<T>> getAll();

  Future<void> delete(ID id);

  Future<void> clear();

  Stream<List<T>> watchAll();
}
