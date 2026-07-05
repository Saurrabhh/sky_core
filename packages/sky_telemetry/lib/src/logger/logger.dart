/// Severity levels for telemetry log messages.
enum LogLevel {
  /// Technical information useful for troubleshooting.
  debug,

  /// Informational messages highlighting progress.
  info,

  /// Warning messages alerting to potential issues.
  warning,

  /// Error messages indicating operation failures.
  error,

  /// Critical failure messages requiring immediate attention.
  fatal,
}

/// Abstract base class defining structured logging capabilities.
abstract class AppLogger {
  /// Creates a [AppLogger] instance.
  const AppLogger();

  /// Writes a log entry with the specified [level] and [message].
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  });

  /// Writes a debug log entry.
  void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => log(
    LogLevel.debug,
    message,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Writes an informational log entry.
  void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => log(
    LogLevel.info,
    message,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Writes a warning log entry.
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => log(
    LogLevel.warning,
    message,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Writes an error log entry.
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => log(
    LogLevel.error,
    message,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Writes a critical fatal log entry.
  void fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => log(
    LogLevel.fatal,
    message,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );
}
