import 'package:sky_telemetry/src/logger/logger.dart';

/// Registry for loggers that multiplexes log operations across outputs.
class AppLoggerRegistry extends AppLogger {
  AppLoggerRegistry._();

  /// The shared singleton instance of the logging registry.
  static final AppLoggerRegistry instance = AppLoggerRegistry._();

  final List<AppLogger> _loggers = [];

  /// Returns an unmodifiable list of currently registered loggers.
  List<AppLogger> get loggers => List.unmodifiable(_loggers);

  /// Registers a [logger] implementation.
  void register(AppLogger logger) {
    if (!_loggers.contains(logger)) {
      _loggers.add(logger);
    }
  }

  /// Unregisters a [logger] implementation.
  void unregister(AppLogger logger) {
    _loggers.remove(logger);
  }

  /// Removes all registered loggers.
  void clear() {
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
