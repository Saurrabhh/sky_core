import 'dart:async';
import 'package:sky_telemetry/src/crash_reporting/crash_reporting_service.dart';
import 'package:sky_telemetry/src/logger/logger.dart';

/// {@template breadcrumb_logger}
/// A mediator logging implementation that bridges log statements to
/// crash breadcrumbs.
///
/// Implements [SkyLogger]. When registered with `SkyLogging`, it forwards
/// logs above [minLevel] directly to [SkyCrashReporting] as session
/// breadcrumbs. This allows crash reporters like Sentry to automatically
/// receive preceding logs when an exception occurs.
/// {@endtemplate}
class BreadcrumbLogger extends SkyLogger {
  /// {@macro breadcrumb_logger}
  const BreadcrumbLogger({
    this.minLevel = LogLevel.info,
  });

  /// The minimum log severity level required to log as a breadcrumb.
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
