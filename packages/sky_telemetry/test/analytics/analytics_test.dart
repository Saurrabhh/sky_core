import 'package:mocktail/mocktail.dart';
import 'package:sky_telemetry/sky_telemetry.dart';
import 'package:test/test.dart';

class MockAnalytics extends Mock implements AppAnalytics {}

void main() {
  group('Analytics (AppAnalyticsRegistry)', () {
    late MockAnalytics mockAnalytics;

    setUp(() {
      mockAnalytics = MockAnalytics();
      AppAnalyticsRegistry.instance.clearProviders();
      AppAnalyticsRegistry.instance.registerProvider(mockAnalytics);
    });

    tearDown(AppAnalyticsRegistry.instance.clearProviders);

    test('routes events and screen tracking correctly', () async {
      when(() => mockAnalytics.trackEvent(
            any(),
            parameters: any(named: 'parameters'),
          )).thenAnswer((_) async {});
      when(() => mockAnalytics.trackScreen(
            any(),
            screenClass: any(named: 'screenClass'),
            parameters: any(named: 'parameters'),
          )).thenAnswer((_) async {});

      await AppAnalyticsRegistry.instance.trackEvent(
        'purchase_completed',
        parameters: {'amount': 49.99},
      );

      await AppAnalyticsRegistry.instance.trackScreen(
        'CartScreen',
        screenClass: 'ShoppingFlow',
      );

      verify(() => mockAnalytics.trackEvent(
            'purchase_completed',
            parameters: {'amount': 49.99},
          )).called(1);

      verify(() => mockAnalytics.trackScreen(
            'CartScreen',
            screenClass: 'ShoppingFlow',
          )).called(1);
    });

    test('propagates user identifiers correctly', () async {
      when(() => mockAnalytics.setUserId(any())).thenAnswer((_) async {});
      when(() => mockAnalytics.setUserProperty(any(), any()))
          .thenAnswer((_) async {});
      when(() => mockAnalytics.clearUser()).thenAnswer((_) async {});
      when(() => mockAnalytics.clearUserProperty(any()))
          .thenAnswer((_) async {});

      await AppAnalyticsRegistry.instance.setUserId('user_555');
      await AppAnalyticsRegistry.instance.setUserProperty('tier', 'premium');

      verify(() => mockAnalytics.setUserId('user_555')).called(1);
      verify(() => mockAnalytics.setUserProperty('tier', 'premium')).called(1);

      await AppAnalyticsRegistry.instance.clearUser();
      verify(() => mockAnalytics.clearUser()).called(1);

      await AppAnalyticsRegistry.instance.clearUserProperty('tier');
      verify(() => mockAnalytics.clearUserProperty('tier')).called(1);
    });
  });
}
