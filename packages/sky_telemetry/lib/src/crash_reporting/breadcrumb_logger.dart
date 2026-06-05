import 'dart:async';

import 'package:sky_telemetry/src/crash_reporting/crash_reporting_service.dart';
import 'package:sky_telemetry/src/logger/logger.dart';

/// A [SkyLogger] forwarding messages to the crash reporting service.
class BreadcrumbLogger extends SkyLogger {
  /// Creates a [BreadcrumbLogger] with an optional [minLevel] filter.
  const BreadcrumbLogger({
    this.minLevel = LogLevel.info,
  });

  /// The minimum log level to register as a breadcrumb.
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
