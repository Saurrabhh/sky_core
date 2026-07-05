import 'package:sky_telemetry/src/analytics/analytics.dart';

/// Registry for analytics providers that multiplexes analytics operations.
class AppAnalyticsRegistry implements AppAnalytics {
  AppAnalyticsRegistry._();

  /// The shared singleton instance of the registry.
  static final AppAnalyticsRegistry instance = AppAnalyticsRegistry._();

  final List<AppAnalytics> _providers = [];

  /// Returns an unmodifiable list of currently registered analytics providers.
  List<AppAnalytics> get providers => List.unmodifiable(_providers);

  /// Registers an analytics [provider].
  void registerProvider(AppAnalytics provider) {
    if (!_providers.contains(provider)) {
      _providers.add(provider);
    }
  }

  /// Unregisters an analytics [provider].
  void unregisterProvider(AppAnalytics provider) {
    _providers.remove(provider);
  }

  /// Removes all registered analytics providers.
  void clearProviders() {
    _providers.clear();
  }

  @override
  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {
    await Future.wait(
      _providers.map(
        (provider) => provider.trackEvent(
          name,
          parameters: parameters,
        ),
      ),
    );
  }

  @override
  Future<void> trackScreen(
    String name, {
    String? screenClass,
    Map<String, dynamic>? parameters,
  }) async {
    await Future.wait(
      _providers.map(
        (provider) => provider.trackScreen(
          name,
          screenClass: screenClass,
          parameters: parameters,
        ),
      ),
    );
  }

  @override
  Future<void> setUserId(String userId) async {
    await Future.wait(
      _providers.map((provider) => provider.setUserId(userId)),
    );
  }

  @override
  Future<void> setUserProperty(String key, String value) async {
    await Future.wait(
      _providers.map((provider) => provider.setUserProperty(key, value)),
    );
  }

  @override
  Future<void> clearUser() async {
    await Future.wait(
      _providers.map((provider) => provider.clearUser()),
    );
  }

  @override
  Future<void> clearUserProperty(String key) async {
    await Future.wait(
      _providers.map((provider) => provider.clearUserProperty(key)),
    );
  }
}
