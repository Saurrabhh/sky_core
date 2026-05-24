import 'package:sky_telemetry/src/crash_reporting/crash_reporter.dart';

/// {@template sky_crash_reporting}
/// The registry and coordinator for all crash reporting.
///
/// Implements [SkyCrashReporter] to act as a unified error tracking gateway,
/// multiplexing errors, user traits, and breadcrumbs to Sentry, Crashlytics,
/// etc.
/// {@endtemplate}
class SkyCrashReporting extends SkyCrashReporter {
  SkyCrashReporting._();

  /// Unified singleton instance of the crash reporting coordinator.
  static final SkyCrashReporting instance = SkyCrashReporting._();

  final List<SkyCrashReporter> _reporters = [];

  /// Returns a read-only list of currently registered crash reporters.
  List<SkyCrashReporter> get reporters => List.unmodifiable(_reporters);

  /// Registers a new crash [reporter] adapter.
  void registerReporter(SkyCrashReporter reporter) {
    if (!_reporters.contains(reporter)) {
      _reporters.add(reporter);
    }
  }

  /// Unregisters an active crash [reporter] adapter.
  void unregisterReporter(SkyCrashReporter reporter) {
    _reporters.remove(reporter);
  }

  /// Clears all registered crash reporting adapters.
  void clearReporters() {
    _reporters.clear();
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, dynamic>? context,
  }) async {
    await Future.wait(
      _reporters.map(
        (reporter) => reporter.recordError(
          error,
          stackTrace,
          reason: reason,
          fatal: fatal,
          context: context,
        ),
      ),
    );
  }

  @override
  Future<void> logBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? metadata,
  }) async {
    await Future.wait(
      _reporters.map(
        (reporter) => reporter.logBreadcrumb(
          message,
          category: category,
          metadata: metadata,
        ),
      ),
    );
  }

  @override
  Future<void> setUserId(String userId) async {
    await Future.wait(
      _reporters.map((reporter) => reporter.setUserId(userId)),
    );
  }

  @override
  Future<void> setUserProperty(String key, String value) async {
    await Future.wait(
      _reporters.map((reporter) => reporter.setUserProperty(key, value)),
    );
  }

  @override
  Future<void> clearUser() async {
    await Future.wait(
      _reporters.map((reporter) => reporter.clearUser()),
    );
  }
}
