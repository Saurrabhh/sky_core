/// Interface for tracking analytics events, screen views, and user properties.
abstract interface class AppAnalytics {
  /// Creates a [AppAnalytics] instance.
  const AppAnalytics();

  /// Records an event with a [name] and optional [parameters].
  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  });

  /// Records a screen view event with a screen [name], optional [screenClass],
  /// and optional [parameters].
  Future<void> trackScreen(
    String name, {
    String? screenClass,
    Map<String, dynamic>? parameters,
  });

  /// Associates future telemetry events with a unique [userId].
  Future<void> setUserId(String userId);

  /// Sets a user property [key] to a specific [value].
  Future<void> setUserProperty(String key, String value);

  /// Clears any associated user identity.
  Future<void> clearUser();

  /// Clears a specific user property [key].
  Future<void> clearUserProperty(String key);
}
