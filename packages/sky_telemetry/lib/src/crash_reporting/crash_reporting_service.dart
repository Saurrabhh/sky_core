import 'package:sky_telemetry/src/crash_reporting/crash_reporter.dart';

/// Registry for crash reporters that multiplexes error recording operations.
class AppCrashReporting implements AppCrashReporter {
  AppCrashReporting._();

  /// The shared singleton instance of the crash reporting registry.
  static final AppCrashReporting instance = AppCrashReporting._();

  final List<AppCrashReporter> _reporters = [];

  /// Returns an unmodifiable list of currently registered crash reporters.
  List<AppCrashReporter> get reporters => List.unmodifiable(_reporters);

  /// Registers a crash [reporter].
  void registerReporter(AppCrashReporter reporter) {
    if (!_reporters.contains(reporter)) {
      _reporters.add(reporter);
    }
  }

  /// Unregisters a crash [reporter].
  void unregisterReporter(AppCrashReporter reporter) {
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
  Future<void> setUserIdentifier(String userId) async {
    await Future.wait(
      _reporters.map((reporter) => reporter.setUserIdentifier(userId)),
    );
  }

  @override
  Future<void> setCustomMetadata(String key, Object value) async {
    await Future.wait(
      _reporters.map((reporter) => reporter.setCustomMetadata(key, value)),
    );
  }

  @override
  Future<void> clearUserIdentifier() async {
    await Future.wait(
      _reporters.map((reporter) => reporter.clearUserIdentifier()),
    );
  }

  @override
  Future<void> removeCustomMetadata(String key) async {
    await Future.wait(
      _reporters.map((reporter) => reporter.removeCustomMetadata(key)),
    );
  }
}
