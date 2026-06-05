/// Interface for capturing application exceptions, errors, and breadcrumbs.
abstract interface class SkyCrashReporter {
  /// Creates a [SkyCrashReporter] instance.
  const SkyCrashReporter();

  /// Records an [error] with its [stackTrace], [reason], and [context].
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, dynamic>? context,
  });

  /// Adds a breadcrumb [message] with optional [category] and [metadata].
  Future<void> logBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? metadata,
  });

  /// Sets the unique [userId] for crash reports.
  Future<void> setUserId(String userId);

  /// Sets a custom user property [key] to [value] for crash reports.
  Future<void> setUserProperty(String key, String value);

  /// Clears the associated user identity.
  Future<void> clearUser();
}
