/// Analytics and behavioral event tracking interface definition.
library;

/// {@template sky_analytics}
/// Abstract contract defining the analytics tracking system.
///
/// Implementations of [SkyAnalytics] publish analytical events, screen views,
/// and user traits to backend services like Firebase Analytics or Mixpanel.
/// {@endtemplate}
abstract class SkyAnalytics {
  /// {@macro sky_analytics}
  const SkyAnalytics();

  /// Publishes a custom behavioral tracking [name] event with optional
  /// [parameters].
  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  });

  /// Tracks a screen transition or view page.
  ///
  /// Maps to the [name] of the screen, optional [screenClass] category,
  /// and any payload analytical [parameters].
  Future<void> trackScreen(
    String name, {
    String? screenClass,
    Map<String, dynamic>? parameters,
  });

  /// Associates subsequent analytical events with a distinct [userId].
  Future<void> setUserId(String userId);

  /// Binds a persistent analytical characteristic [key] to [value].
  Future<void> setUserProperty(String key, String value);

  /// Clears user identity bindings on logout.
  Future<void> clearUser();
}
