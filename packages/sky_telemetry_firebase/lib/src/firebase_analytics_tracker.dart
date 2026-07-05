import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

/// Concrete implementation of [AppAnalytics] using [FirebaseAnalytics].
class FirebaseAnalyticsTracker implements AppAnalytics {
  /// Creates a [FirebaseAnalyticsTracker] with a required `analytics` instance.
  const FirebaseAnalyticsTracker({
    required this.analytics,
  });

  /// The underlying [FirebaseAnalytics] client instance.
  final FirebaseAnalytics analytics;

  @override
  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  }) {
    return analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  @override
  Future<void> trackScreen(
    String name, {
    String? screenClass,
    Map<String, dynamic>? parameters,
  }) {
    final params = <String, dynamic>{
      'screen_name': name,
      ...?parameters,
    };
    if (screenClass != null) {
      params['screen_class'] = screenClass;
    }
    return analytics.logEvent(
      name: 'screen_view',
      parameters: params,
    );
  }

  @override
  Future<void> setUserId(String userId) {
    return analytics.setUserId(id: userId);
  }

  @override
  Future<void> setUserProperty(String key, String value) {
    return analytics.setUserProperty(name: key, value: value);
  }

  @override
  Future<void> clearUser() {
    return analytics.setUserId();
  }

  @override
  Future<void> clearUserProperty(String key) {
    return analytics.setUserProperty(name: key, value: null);
  }
}
