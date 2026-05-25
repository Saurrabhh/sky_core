abstract interface class DatabaseInitializer {
  Future<void> initialize();

  Future<void> close();
}
