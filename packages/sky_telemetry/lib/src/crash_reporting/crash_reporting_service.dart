import 'package:sky_telemetry/src/crash_reporting/crash_reporter.dart';

/// Registry for crash reporters that multiplexes error recording operations.
class SkyCrashReporting implements SkyCrashReporter {
  SkyCrashReporting._();

  /// The shared singleton instance of the crash reporting registry.
  static final SkyCrashReporting instance = SkyCrashReporting._();

  final List<SkyCrashReporter> _reporters = [];

  /// Returns an unmodifiable list of currently registered crash reporters.
  List<SkyCrashReporter> get reporters => List.unmodifiable(_reporters);

  /// Registers a crash [reporter].
  void registerReporter(SkyCrashReporter reporter) {
    if (!_reporters.contains(reporter)) {
      _reporters.add(reporter);
    }
  }

  /// Unregisters a crash [reporter].
  void unregisterReporter(SkyCrashReporter reporter) {
    _reporters.remove(reporter);
  }

  /// Removes all registered crash reporters.
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
