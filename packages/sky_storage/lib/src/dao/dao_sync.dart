/// Data Access Object interface for synchronous database table access.
abstract interface class DaoSync<ID, T> {
  /// Saves [value] associated with [id] to the store synchronously.
  ///
  /// Note: For database backends like Isar, the [id] argument should match
  /// the annotated id field of the [value] object itself.
  void put(ID id, T value);

  /// Retrieves the value associated with [id], or null if not found,
  /// synchronously.
  T? get(ID id);

  /// Retrieves all values in this store synchronously.
  List<T> getAll();

  /// Removes the value associated with [id] from the store synchronously.
  void delete(ID id);

  /// Removes all values from the store synchronously.
  void clear();

  /// Emits a list of all values whenever the store updates.
  Stream<List<T>> watchAll();
}
