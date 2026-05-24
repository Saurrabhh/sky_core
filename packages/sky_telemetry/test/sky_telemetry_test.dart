import 'package:sky_telemetry/sky_telemetry.dart';
import 'package:test/test.dart';

// --- Mock Telemetry Adapters ---

class MockLogger extends SkyLogger {
  final List<String> loggedMessages = [];

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    loggedMessages.add('${level.name}: $message (context: $context)');
  }
}

class MockCrashReporter extends SkyCrashReporter {
  final List<String> reportedErrors = [];
  final List<String> loggedBreadcrumbs = [];
  String? userId;
  final Map<String, String> userProperties = {};

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, dynamic>? context,
  }) async {
    reportedErrors.add('error: $error (reason: $reason, fatal: $fatal)');
  }

  @override
  Future<void> logBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? metadata,
  }) async {
    loggedBreadcrumbs.add('breadcrumb: $message (category: $category)');
  }

  @override
  Future<void> setUserId(String userId) async {
    this.userId = userId;
  }

  @override
  Future<void> setUserProperty(String key, String value) async {
    userProperties[key] = value;
  }

  @override
  Future<void> clearUser() async {
    userId = null;
    userProperties.clear();
  }
}

class MockAnalytics extends SkyAnalytics {
  final List<String> trackedEvents = [];
  final List<String> trackedScreens = [];
  String? userId;
  final Map<String, String> userProperties = {};

  @override
  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {
    trackedEvents.add('event: $name (params: $parameters)');
  }

  @override
  Future<void> trackScreen(
    String name, {
    String? screenClass,
    Map<String, dynamic>? parameters,
  }) async {
    trackedScreens.add('screen: $name (class: $screenClass)');
  }

  @override
  Future<void> setUserId(String userId) async {
    this.userId = userId;
  }

  @override
  Future<void> setUserProperty(String key, String value) async {
    userProperties[key] = value;
  }

  @override
  Future<void> clearUser() async {
    userId = null;
    userProperties.clear();
  }
}

void main() {
  group('Diagnostic Logging (SkyLogging)', () {
    late MockLogger mockLogger;

    setUp(() {
      mockLogger = MockLogger();
      SkyLogging.instance.clearLoggers();
      SkyLogging.instance.registerLogger(mockLogger);
    });

    tearDown(SkyLogging.instance.clearLoggers);

    test('multiplexes logs correctly to registered adapters', () {
      SkyLogging.instance.info('System Booted', context: {'env': 'prod'});

      expect(mockLogger.loggedMessages, hasLength(1));
      expect(
        mockLogger.loggedMessages.first,
        equals('info: System Booted (context: {env: prod})'),
      );
    });

    test('supports unregistering logger adapters', () {
      SkyLogging.instance.unregisterLogger(mockLogger);
      SkyLogging.instance.info('Unregistered');

      expect(mockLogger.loggedMessages, isEmpty);
    });

    test('supports standard logging levels', () {
      SkyLogging.instance.debug('debug log');
      SkyLogging.instance.warning('warning log');
      SkyLogging.instance.error('error log');
      SkyLogging.instance.fatal('fatal log');

      expect(mockLogger.loggedMessages, hasLength(4));
      expect(mockLogger.loggedMessages[0], contains('debug: debug log'));
      expect(mockLogger.loggedMessages[1], contains('warning: warning log'));
      expect(mockLogger.loggedMessages[2], contains('error: error log'));
      expect(mockLogger.loggedMessages[3], contains('fatal: fatal log'));
    });
  });

  group('Crash Reporting (SkyCrashReporting)', () {
    late MockCrashReporter mockReporter;

    setUp(() {
      mockReporter = MockCrashReporter();
      SkyCrashReporting.instance.clearReporters();
      SkyCrashReporting.instance.registerReporter(mockReporter);
    });

    tearDown(SkyCrashReporting.instance.clearReporters);

    test('multiplexes errors and breadcrumbs correctly', () async {
      await SkyCrashReporting.instance.recordError(
        'DatabaseCorruptionException',
        StackTrace.empty,
        reason: 'Failed reading cache',
        fatal: true,
      );

      await SkyCrashReporting.instance.logBreadcrumb(
        'User entered profile screen',
        category: 'navigation',
      );

      expect(mockReporter.reportedErrors, hasLength(1));
      expect(
        mockReporter.reportedErrors.first,
        equals(
          'error: DatabaseCorruptionException '
          '(reason: Failed reading cache, fatal: true)',
        ),
      );

      expect(mockReporter.loggedBreadcrumbs, hasLength(1));
      expect(
        mockReporter.loggedBreadcrumbs.first,
        equals(
          'breadcrumb: User entered profile screen '
          '(category: navigation)',
        ),
      );
    });

    test('propagates user metadata functions correctly', () async {
      await SkyCrashReporting.instance.setUserId('user_999');
      await SkyCrashReporting.instance.setUserProperty('user_role', 'admin');

      expect(mockReporter.userId, equals('user_999'));
      expect(mockReporter.userProperties['user_role'], equals('admin'));

      await SkyCrashReporting.instance.clearUser();
      expect(mockReporter.userId, isNull);
      expect(mockReporter.userProperties, isEmpty);
    });
  });

  group('Analytics (SkyAnalyticsRegistry)', () {
    late MockAnalytics mockAnalytics;

    setUp(() {
      mockAnalytics = MockAnalytics();
      SkyAnalyticsRegistry.instance.clearProviders();
      SkyAnalyticsRegistry.instance.registerProvider(mockAnalytics);
    });

    tearDown(SkyAnalyticsRegistry.instance.clearProviders);

    test('routes events and screen tracking correctly', () async {
      await SkyAnalyticsRegistry.instance.trackEvent(
        'purchase_completed',
        parameters: {'amount': 49.99},
      );

      await SkyAnalyticsRegistry.instance.trackScreen(
        'CartScreen',
        screenClass: 'ShoppingFlow',
      );

      expect(mockAnalytics.trackedEvents, hasLength(1));
      expect(
        mockAnalytics.trackedEvents.first,
        equals('event: purchase_completed (params: {amount: 49.99})'),
      );

      expect(mockAnalytics.trackedScreens, hasLength(1));
      expect(
        mockAnalytics.trackedScreens.first,
        equals('screen: CartScreen (class: ShoppingFlow)'),
      );
    });

    test('propagates user identifiers correctly', () async {
      await SkyAnalyticsRegistry.instance.setUserId('user_555');
      await SkyAnalyticsRegistry.instance.setUserProperty('tier', 'premium');

      expect(mockAnalytics.userId, equals('user_555'));
      expect(mockAnalytics.userProperties['tier'], equals('premium'));

      await SkyAnalyticsRegistry.instance.clearUser();
      expect(mockAnalytics.userId, isNull);
      expect(mockAnalytics.userProperties, isEmpty);
    });
  });

  group('BreadcrumbLogger Decoupled Mediator', () {
    late MockCrashReporter mockReporter;
    late BreadcrumbLogger breadcrumbLogger;

    setUp(() {
      mockReporter = MockCrashReporter();
      SkyCrashReporting.instance.clearReporters();
      SkyCrashReporting.instance.registerReporter(mockReporter);

      breadcrumbLogger = const BreadcrumbLogger();
      SkyLogging.instance.clearLoggers();
      SkyLogging.instance.registerLogger(breadcrumbLogger);
    });

    tearDown(() {
      SkyLogging.instance.clearLoggers();
      SkyCrashReporting.instance.clearReporters();
    });

    test('forwards messages above minLevel to crash breadcrumbs', () {
      SkyLogging.instance.debug('Debug is below minLevel info');
      SkyLogging.instance.warning('Warning is above minLevel info', context: {
        'code': 500,
      });

      // The debug log is omitted from breadcrumbs, only the warning remains.
      expect(mockReporter.loggedBreadcrumbs, hasLength(1));
      expect(
        mockReporter.loggedBreadcrumbs.first,
        equals(
          'breadcrumb: Warning is above minLevel info '
          '(category: log_warning)',
        ),
      );
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
