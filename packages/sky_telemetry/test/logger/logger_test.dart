import 'package:mocktail/mocktail.dart';
import 'package:sky_telemetry/sky_telemetry.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements AppLogger {}

void main() {
  setUpAll(() {
    registerFallbackValue(LogLevel.info);
  });

  group('Diagnostic Logging (AppLoggerRegistry)', () {
    late MockLogger mockLogger;

    setUp(() {
      mockLogger = MockLogger();
      AppLoggerRegistry.instance.clear();
      AppLoggerRegistry.instance.register(mockLogger);
    });

    tearDown(AppLoggerRegistry.instance.clear);

    test('multiplexes logs correctly to registered adapters', () {
      when(() => mockLogger.log(
            any(),
            any(),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
            context: any(named: 'context'),
          )).thenAnswer((_) {});

      AppLoggerRegistry.instance.info(
        'System Booted',
        context: {'env': 'prod'},
      );

      verify(() => mockLogger.log(
            LogLevel.info,
            'System Booted',
            context: {'env': 'prod'},
          )).called(1);
    });

    test('supports unregistering logger adapters', () {
      AppLoggerRegistry.instance.unregister(mockLogger);
      AppLoggerRegistry.instance.info('Unregistered');

      verifyNever(() => mockLogger.log(
            any(),
            any(),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
            context: any(named: 'context'),
          ));
    });

    test('supports standard logging levels', () {
      when(() => mockLogger.log(
            any(),
            any(),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
            context: any(named: 'context'),
          )).thenAnswer((_) {});

      AppLoggerRegistry.instance.debug('debug log');
      AppLoggerRegistry.instance.warning('warning log');
      AppLoggerRegistry.instance.error('error log');
      AppLoggerRegistry.instance.fatal('fatal log');

      verify(() => mockLogger.log(LogLevel.debug, 'debug log')).called(1);
      verify(() => mockLogger.log(LogLevel.warning, 'warning log')).called(1);
      verify(() => mockLogger.log(LogLevel.error, 'error log')).called(1);
      verify(() => mockLogger.log(LogLevel.fatal, 'fatal log')).called(1);
    });
  });

  group('ConsoleLogger Printer Verification', () {
    test('instantiates and formats log calls without crashing', () {
      final consoleLogger = ConsoleLogger();

      expect(
        () => consoleLogger.info(
          'Console Logger Test Message',
          context: {'build': 'debug'},
        ),
        returnsNormally,
      );
    });
  });
}
