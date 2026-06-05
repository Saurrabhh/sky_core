import 'package:sky_telemetry/src/logger/logger.dart';

/// Registry for loggers that multiplexes log operations across outputs.
class SkyLogging extends SkyLogger {
  SkyLogging._();

  /// The shared singleton instance of the logging registry.
  static final SkyLogging instance = SkyLogging._();

  final List<SkyLogger> _loggers = [];

  /// Returns an unmodifiable list of currently registered loggers.
  List<SkyLogger> get loggers => List.unmodifiable(_loggers);

  /// Registers a [logger] implementation.
  void registerLogger(SkyLogger logger) {
    if (!_loggers.contains(logger)) {
      _loggers.add(logger);
    }
  }

  /// Unregisters a [logger] implementation.
  void unregisterLogger(SkyLogger logger) {
    _loggers.remove(logger);
  }

  /// Removes all registered loggers.
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
