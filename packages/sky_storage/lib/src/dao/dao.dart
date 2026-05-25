/// A generic Data Access Object (DAO) interface.
///
/// Defines the core contract for local persistence, isolating the domain and
/// data source layers from specific storage library implementations.
abstract interface class Dao<ID, T> {
  /// Persists a [value] associated with [id].
  Future<void> put(ID id, T value);

  /// Retrieves the value associated with [id], or null if not found.
  Future<T?> get(ID id);

  /// Retrieves all values currently stored in this store.
  Future<List<T>> getAll();

  /// Deletes the value associated with [id].
  Future<void> delete(ID id);

  /// Clears all entries from this store.
  Future<void> clear();

  /// Returns a stream that emits the list of all stored values whenever
  /// the store changes.
  Stream<List<T>> watchAll();
}
