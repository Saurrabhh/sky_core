import 'package:mocktail/mocktail.dart';
import 'package:sky_telemetry/sky_telemetry.dart';
import 'package:test/test.dart';

class MockCrashlytics extends Mock implements AppCrashlytics {}

void main() {
  group('Crash Reporting (AppCrashlyticsRegistry)', () {
    late MockCrashlytics mockReporter;

    setUp(() {
      mockReporter = MockCrashlytics();
      AppCrashlyticsRegistry.instance.clear();
      AppCrashlyticsRegistry.instance.register(mockReporter);
    });

    tearDown(AppCrashlyticsRegistry.instance.clear);

    test('multiplexes errors and breadcrumbs correctly', () async {
      when(() => mockReporter.recordError(
            any(),
            any(),
            reason: any(named: 'reason'),
            fatal: any(named: 'fatal'),
            context: any(named: 'context'),
          )).thenAnswer((_) async {});

      when(() => mockReporter.logBreadcrumb(
            any(),
            category: any(named: 'category'),
            metadata: any(named: 'metadata'),
          )).thenAnswer((_) async {});

      await AppCrashlyticsRegistry.instance.recordError(
        'DatabaseCorruptionException',
        StackTrace.empty,
        reason: 'Failed reading cache',
        fatal: true,
      );

      await AppCrashlyticsRegistry.instance.logBreadcrumb(
        'User entered profile screen',
        category: 'navigation',
      );

      verify(() => mockReporter.recordError(
            'DatabaseCorruptionException',
            StackTrace.empty,
            reason: 'Failed reading cache',
            fatal: true,
          )).called(1);

      verify(() => mockReporter.logBreadcrumb(
            'User entered profile screen',
            category: 'navigation',
          )).called(1);
    });

    test('propagates user metadata functions correctly', () async {
      when(() => mockReporter.setUserIdentifier(any()))
          .thenAnswer((_) async {});
      when(() => mockReporter.setCustomMetadata(any(), any()))
          .thenAnswer((_) async {});
      when(() => mockReporter.clearUserIdentifier()).thenAnswer((_) async {});
      when(() => mockReporter.removeCustomMetadata(any()))
          .thenAnswer((_) async {});

      await AppCrashlyticsRegistry.instance.setUserIdentifier('user_999');
      await AppCrashlyticsRegistry.instance.setCustomMetadata(
        'user_role',
        'admin',
      );

      verify(() => mockReporter.setUserIdentifier('user_999')).called(1);
      verify(() => mockReporter.setCustomMetadata('user_role', 'admin'))
          .called(1);

      await AppCrashlyticsRegistry.instance.clearUserIdentifier();
      verify(() => mockReporter.clearUserIdentifier()).called(1);

      await AppCrashlyticsRegistry.instance.removeCustomMetadata('user_role');
      verify(() => mockReporter.removeCustomMetadata('user_role')).called(1);
    });
  });

  group('BreadcrumbLogger Decoupled Mediator', () {
    late MockCrashlytics mockReporter;
    late BreadcrumbLogger breadcrumbLogger;

    setUp(() {
      mockReporter = MockCrashlytics();
      AppCrashlyticsRegistry.instance.clear();
      AppCrashlyticsRegistry.instance.register(mockReporter);

      breadcrumbLogger = const BreadcrumbLogger();
      AppLoggerRegistry.instance.clear();
      AppLoggerRegistry.instance.register(breadcrumbLogger);
    });

    tearDown(() {
      AppLoggerRegistry.instance.clear();
      AppCrashlyticsRegistry.instance.clear();
    });

    test('forwards messages above minLevel to crash breadcrumbs', () {
      when(() => mockReporter.logBreadcrumb(
            any(),
            category: any(named: 'category'),
            metadata: any(named: 'metadata'),
          )).thenAnswer((_) async {});

      AppLoggerRegistry.instance.debug('Debug is below minLevel info');
      AppLoggerRegistry.instance.warning(
        'Warning is above minLevel info',
        context: {
          'code': 500,
        },
      );

      verify(() => mockReporter.logBreadcrumb(
            'Warning is above minLevel info',
            category: 'log_warning',
            metadata: {'code': 500},
          )).called(1);
    });
  });
}
