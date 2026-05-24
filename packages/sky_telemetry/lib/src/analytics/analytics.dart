abstract interface class SkyAnalytics {
  const SkyAnalytics();

  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  });

  Future<void> trackScreen(
    String name, {
    String? screenClass,
    Map<String, dynamic>? parameters,
  });

  Future<void> setUserId(String userId);

  Future<void> setUserProperty(String key, String value);

  Future<void> clearUser();
}
