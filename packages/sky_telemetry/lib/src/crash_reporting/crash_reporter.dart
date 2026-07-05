/// Interface for capturing application exceptions, errors, and breadcrumbs.
abstract interface class AppCrashReporter {
  /// Creates a [AppCrashReporter] instance.
  const AppCrashReporter();

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

  /// Associates future telemetry events with a unique [userId].
  Future<void> setUserIdentifier(String userId);

  /// Sets a custom user property [key] to [value] for crash reports.
  Future<void> setCustomMetadata(String key, Object value);

  /// Clears the associated user identity.
  Future<void> clearUserIdentifier();

  /// Removes a custom metadata [key] from crash reports.
  Future<void> removeCustomMetadata(String key);
}
