import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

/// Concrete implementation of [AppCrashlytics] using [FirebaseCrashlytics].
class FirebaseCrashlyticsReporter implements AppCrashlytics {
  /// Creates a [FirebaseCrashlyticsReporter] with a required `crashlytics`
  /// instance.
  const FirebaseCrashlyticsReporter({
    required this.crashlytics,
  });

  /// The underlying [FirebaseCrashlytics] client instance.
  final FirebaseCrashlytics crashlytics;

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, dynamic>? context,
  }) async {
    if (context != null && context.isNotEmpty) {
      for (final entry in context.entries) {
        final val = entry.value;
        if (val != null) {
          await crashlytics.setCustomKey(entry.key, val as Object);
        }
      }
    }
    await crashlytics.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }

  @override
  Future<void> logBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? metadata,
  }) async {
    final buffer = StringBuffer();
    if (category != null) {
      buffer.write('[$category] ');
    }
    buffer.write(message);
    if (metadata != null && metadata.isNotEmpty) {
      buffer.write(' | Metadata: $metadata');
    }
    await crashlytics.log(buffer.toString());
  }

  @override
  Future<void> setUserIdentifier(String userId) {
    return crashlytics.setUserIdentifier(userId);
  }

  @override
  Future<void> setCustomMetadata(String key, Object value) {
    return crashlytics.setCustomKey(key, value);
  }

  @override
  Future<void> clearUserIdentifier() {
    return crashlytics.setUserIdentifier('');
  }

  @override
  Future<void> removeCustomMetadata(String key) {
    // Firebase Crashlytics custom keys are persistent for the session;
    // resetting to an empty string effectively clears the value.
    return crashlytics.setCustomKey(key, '');
  }
}
