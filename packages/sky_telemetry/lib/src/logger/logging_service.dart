import 'package:sky_telemetry/src/logger/logger.dart';

/// {@template sky_logging}
/// The registry and coordinator for all diagnostic logging.
///
/// Implements [SkyLogger] so it can be passed as a single unified logger
/// downstream, while internally routing logs to all registered logging
/// adapters.
/// {@endtemplate}
class SkyLogging extends SkyLogger {
  SkyLogging._();

  /// Unified singleton instance of the logging coordinator.
  static final SkyLogging instance = SkyLogging._();

  final List<SkyLogger> _loggers = [];

  /// Returns a read-only list of currently registered loggers.
  List<SkyLogger> get loggers => List.unmodifiable(_loggers);

  /// Registers a new [logger] adapter.
  void registerLogger(SkyLogger logger) {
    if (!_loggers.contains(logger)) {
      _loggers.add(logger);
    }
  }

  /// Unregisters an active [logger] adapter.
  void unregisterLogger(SkyLogger logger) {
    _loggers.remove(logger);
  }

  /// Clears all registered logging adapters.
  void clearLoggers() {
    _loggers.clear();
  }

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    for (final logger in _loggers) {
      logger.log(
        level,
        message,
        error: error,
        stackTrace: stackTrace,
        context: context,
      );
    }
  }
}
