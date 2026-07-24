/// A mixin for Isar `@collection` models that provides timestamp tracking
/// and Time-To-Live (TTL) expiration checking for cached items.
///
/// Apply this mixin to any Isar model class to automatically track when the
/// record was last synced and evaluate whether the cache has expired based
/// on a given TTL duration.
///
/// Example:
/// ```dart
/// @collection
/// class GroupIsarModel with IsarCacheable {
///   Id isarId = Isar.autoIncrement;
///   String? id;
///   String? name;
/// }
///
/// final model = GroupIsarModel()..lastSyncedAt = DateTime.now();
/// if (model.isExpired(const Duration(minutes: 15))) {
///   // Fetch fresh data from network
/// }
/// ```
mixin IsarCacheable {
  /// The timestamp when this entity was last successfully synced or written
  /// to storage.
  DateTime? lastSyncedAt;

  /// Returns `true` if [lastSyncedAt] is `null` or if the elapsed time since
  /// [lastSyncedAt] exceeds the provided [ttl] duration.
  bool isExpired(Duration ttl) {
    final syncedAt = lastSyncedAt;
    if (syncedAt == null) return true;
    return DateTime.now().difference(syncedAt) > ttl;
  }
}
