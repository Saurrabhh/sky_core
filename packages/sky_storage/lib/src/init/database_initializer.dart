/// Interface for database initialization and lifecycle management.
abstract interface class DatabaseInitializer {
  /// Prepares and opens the database.
  Future<void> initialize();

  /// Closes the database and releases resources.
  Future<void> close();
}
