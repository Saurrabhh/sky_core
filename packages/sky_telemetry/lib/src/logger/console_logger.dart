import 'package:logger/logger.dart' as log_pkg;
import 'package:sky_telemetry/src/logger/logger.dart';

class ConsoleLogger extends SkyLogger {
  ConsoleLogger({
    log_pkg.Level level = log_pkg.Level.debug,
  }) : _logger = log_pkg.Logger(
         level: level,
         printer: log_pkg.PrettyPrinter(
           methodCount: 0,
           lineLength: 80,
         ),
       );

  final log_pkg.Logger _logger;

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    final buffer = StringBuffer()..write(message);

    if (context != null && context.isNotEmpty) {
      buffer.write(' | Context: $context');
    }

    final formattedMessage = buffer.toString();
    final loggerLevel = _mapLogLevel(level);

    _logger.log(
      loggerLevel,
      formattedMessage,
      error: error,
      stackTrace: stackTrace,
    );
  }

  log_pkg.Level _mapLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return log_pkg.Level.debug;
      case LogLevel.info:
        return log_pkg.Level.info;
      case LogLevel.warning:
        return log_pkg.Level.warning;
      case LogLevel.error:
        return log_pkg.Level.error;
      case LogLevel.fatal:
        return log_pkg.Level.fatal;
    }
  }
}
