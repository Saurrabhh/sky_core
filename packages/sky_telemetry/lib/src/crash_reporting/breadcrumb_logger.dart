import 'dart:async';

import 'package:sky_telemetry/src/crash_reporting/crash_reporting_service.dart';
import 'package:sky_telemetry/src/logger/logger.dart';

class BreadcrumbLogger extends SkyLogger {
  const BreadcrumbLogger({
    this.minLevel = LogLevel.info,
  });

  final LogLevel minLevel;

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    if (level.index >= minLevel.index) {
      final metadata = <String, dynamic>{};
      if (context != null) {
        metadata.addAll(context);
      }
      if (error != null) {
        metadata['error'] = error.toString();
      }

      unawaited(
        SkyCrashReporting.instance.logBreadcrumb(
          message,
          category: 'log_${level.name}',
          metadata: metadata.isNotEmpty ? metadata : null,
        ),
      );
    }
  }
}
