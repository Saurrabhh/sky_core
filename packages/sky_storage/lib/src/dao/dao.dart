/// Data Access Object interface for a generic database table.
abstract interface class Dao<ID, T> {
  /// Saves [value] associated with [id] to the store.
  Future<void> put(ID id, T value);

  /// Retrieves the value associated with [id], or null if not found.
  Future<T?> get(ID id);

  /// Retrieves all values in this store.
  Future<List<T>> getAll();

  /// Removes the value associated with [id] from the store.
  Future<void> delete(ID id);

  /// Removes all values from the store.
  Future<void> clear();

  /// Emits a list of all values whenever the store updates.
  Stream<List<T>> watchAll();
}
