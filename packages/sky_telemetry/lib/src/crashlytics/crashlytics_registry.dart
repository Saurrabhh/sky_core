import 'package:sky_telemetry/src/crashlytics/crashlytics.dart';

/// Registry for crashlytics reporters that multiplexes error recording
/// operations.
class AppCrashlyticsRegistry implements AppCrashlytics {
  AppCrashlyticsRegistry._();

  /// The shared singleton instance of the crashlytics registry.
  static final AppCrashlyticsRegistry instance = AppCrashlyticsRegistry._();

  final List<AppCrashlytics> _reporters = [];

  /// Returns an unmodifiable list of currently registered crashlytics
  /// reporters.
  List<AppCrashlytics> get reporters => List.unmodifiable(_reporters);

  /// Registers a crash [reporter].
  void register(AppCrashlytics reporter) {
    if (!_reporters.contains(reporter)) {
      _reporters.add(reporter);
    }
  }

  /// Unregisters a crash [reporter].
  void unregister(AppCrashlytics reporter) {
    _reporters.remove(reporter);
  }

  /// Removes all registered crashlytics reporters.
  void clear() {
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
