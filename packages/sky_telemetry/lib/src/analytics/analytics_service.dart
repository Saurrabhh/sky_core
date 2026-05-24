import 'package:sky_telemetry/src/analytics/analytics.dart';

class SkyAnalyticsRegistry implements SkyAnalytics {
  SkyAnalyticsRegistry._();

  static final SkyAnalyticsRegistry instance = SkyAnalyticsRegistry._();

  final List<SkyAnalytics> _providers = [];

  List<SkyAnalytics> get providers => List.unmodifiable(_providers);

  void registerProvider(SkyAnalytics provider) {
    if (!_providers.contains(provider)) {
      _providers.add(provider);
    }
  }

  void unregisterProvider(SkyAnalytics provider) {
    _providers.remove(provider);
  }

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
