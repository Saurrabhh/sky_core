abstract interface class SkyCrashReporter {
  const SkyCrashReporter();

  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, dynamic>? context,
  });

  Future<void> logBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? metadata,
  });

  Future<void> setUserId(String userId);

  Future<void> setUserProperty(String key, String value);

  Future<void> clearUser();
}
