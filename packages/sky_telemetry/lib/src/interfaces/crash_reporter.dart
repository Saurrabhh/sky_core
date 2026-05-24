/// Crash reporting and error tracking interface definition.
library;

/// {@template sky_crash_reporter}
/// Abstract contract defining the crash reporting system.
///
/// Implementations of [SkyCrashReporter] forward fatal/non-fatal errors,
/// context properties, and analytical breadcrumbs to error monitoring systems
/// like Sentry or Firebase Crashlytics.
/// {@endtemplate}
abstract class SkyCrashReporter {
  /// {@macro sky_crash_reporter}
  const SkyCrashReporter();

  /// Captures and logs a caught [error] and [stackTrace].
  ///
  /// Specify [reason] for descriptive classification and [fatal] if the error
  /// resulted in system instability or shutdown. Custom key-value pairs can
  /// be provided in the [context] parameter.
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, dynamic>? context,
  });

  /// Appends a breadcrumb to the current session.
  ///
  /// Breadcrumbs represent short chronological system logs (e.g. user
  /// navigation paths, button clicks, API responses) that occurred prior
  /// to a crash, aiding in replication.
  Future<void> logBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? metadata,
  });

  /// Associates the current session with a distinct [userId].
  Future<void> setUserId(String userId);

  /// Sets a persistent custom user characteristic [key] to [value].
  Future<void> setUserProperty(String key, String value);

  /// Clears user identities, commonly invoked during user logout.
  Future<void> clearUser();
}
