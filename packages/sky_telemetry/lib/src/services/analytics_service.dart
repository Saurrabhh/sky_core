import 'package:sky_telemetry/src/interfaces/analytics.dart';

/// {@template sky_analytics_registry}
/// The registry and coordinator for all analytics tracking.
///
/// Implements [SkyAnalytics] to act as a unified analytics router,
/// multiplexing events, screens, and characteristics to active providers.
/// {@endtemplate}
class SkyAnalyticsRegistry extends SkyAnalytics {
  SkyAnalyticsRegistry._();

  /// Unified singleton instance of the analytics registry coordinator.
  static final SkyAnalyticsRegistry instance = SkyAnalyticsRegistry._();

  final List<SkyAnalytics> _providers = [];

  /// Returns a read-only list of currently registered analytics providers.
  List<SkyAnalytics> get providers => List.unmodifiable(_providers);

  /// Registers a new analytics [provider] adapter.
  void registerProvider(SkyAnalytics provider) {
    if (!_providers.contains(provider)) {
      _providers.add(provider);
    }
  }

  /// Unregisters an active analytics [provider] adapter.
  void unregisterProvider(SkyAnalytics provider) {
    _providers.remove(provider);
  }

  /// Clears all registered analytics adapters.
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
}
