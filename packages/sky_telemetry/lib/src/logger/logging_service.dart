import 'package:sky_telemetry/src/logger/logger.dart';

class SkyLogging extends SkyLogger {
  SkyLogging._();

  static final SkyLogging instance = SkyLogging._();

  final List<SkyLogger> _loggers = [];

  List<SkyLogger> get loggers => List.unmodifiable(_loggers);

  void registerLogger(SkyLogger logger) {
    if (!_loggers.contains(logger)) {
      _loggers.add(logger);
    }
  }

  void unregisterLogger(SkyLogger logger) {
    _loggers.remove(logger);
  }

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
