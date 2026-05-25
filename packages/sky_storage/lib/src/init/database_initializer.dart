/// An interface for orchestrating database initialization.
abstract interface class DatabaseInitializer {
  /// Initializes the database engine and opens all necessary boxes or
  /// databases.
  Future<void> initialize();

  /// Closes the database engine and releases all associated resources.
  Future<void> close();
}
