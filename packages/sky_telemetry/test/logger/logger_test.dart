import 'package:mocktail/mocktail.dart';
import 'package:sky_telemetry/sky_telemetry.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements AppLogger {}

void main() {
  setUpAll(() {
    registerFallbackValue(LogLevel.info);
  });

  group('Diagnostic Logging (AppLogging)', () {
    late MockLogger mockLogger;

    setUp(() {
      mockLogger = MockLogger();
      AppLogging.instance.clearLoggers();
      AppLogging.instance.registerLogger(mockLogger);
    });

    tearDown(AppLogging.instance.clearLoggers);

    test('multiplexes logs correctly to registered adapters', () {
      when(() => mockLogger.log(
        any(),
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
        context: any(named: 'context'),
      )).thenAnswer((_) {});

      AppLogging.instance.info('System Booted', context: {'env': 'prod'});

      verify(() => mockLogger.log(
        LogLevel.info,
        'System Booted',
        context: {'env': 'prod'},
      )).called(1);
    });

    test('supports unregistering logger adapters', () {
      AppLogging.instance.unregisterLogger(mockLogger);
      AppLogging.instance.info('Unregistered');

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

      AppLogging.instance.debug('debug log');
      AppLogging.instance.warning('warning log');
      AppLogging.instance.error('error log');
      AppLogging.instance.fatal('fatal log');

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
