/// Diagnostic logging levels and interface definition.
library;

/// {@template log_level}
/// Severity levels for diagnostic logs.
/// {@endtemplate}
enum LogLevel {
  /// Verbose messages useful during local debugging.
  debug,

  /// General informative system/business messages.
  info,

  /// Potential issues or unexpected states that do not block operations.
  warning,

  /// Operational errors that impede a workflow but do not crash the app.
  error,

  /// Critical, unrecoverable system failures that cause crashes or halts.
  fatal,
}

/// {@template sky_logger}
/// Abstract contract defining the diagnostic logging system.
///
/// Implementations of [SkyLogger] route diagnostic log payloads to concrete
/// destinations such as console terminals or remote telemetry backends.
/// {@endtemplate}
abstract class SkyLogger {
  /// {@macro sky_logger}
  const SkyLogger();

  /// Logs a structured message with the specified severity [level].
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  });

  /// Logs a [debug] severity message.
  void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) =>
      log(
        LogLevel.debug,
        message,
        error: error,
        stackTrace: stackTrace,
        context: context,
      );

  /// Logs an [info] severity message.
  void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) =>
      log(
        LogLevel.info,
        message,
        error: error,
        stackTrace: stackTrace,
        context: context,
      );

  /// Logs a [warning] severity message.
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) =>
      log(
        LogLevel.warning,
        message,
        error: error,
        stackTrace: stackTrace,
        context: context,
      );

  /// Logs an [error] severity message.
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) =>
      log(
        LogLevel.error,
        message,
        error: error,
        stackTrace: stackTrace,
        context: context,
      );

  /// Logs a [fatal] severity message.
  void fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) =>
      log(
        LogLevel.fatal,
        message,
        error: error,
        stackTrace: stackTrace,
        context: context,
      );
}
