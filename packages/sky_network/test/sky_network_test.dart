import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/sky_network.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

/// A custom [HttpClientAdapter] for mocking network responses in Dio.
class MockAdapter implements HttpClientAdapter {
  MockAdapter({required this.handler});

  final Future<ResponseBody> Function(RequestOptions options) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<void>? cancelToken,
    Future<void>? connectionTimeout,
  ) {
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

/// A simple mock of [SkyLogger] to inspect logging activity.
class MockSkyLogger extends SkyLogger {
  final List<Map<String, dynamic>> logged = [];

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    logged.add({
      'level': level,
      'message': message,
      'error': error,
      'stackTrace': stackTrace,
      'context': context,
    });
  }
}

/// A simple mock of [Connectivity] to test offline pre-flight checks.
class MockConnectivity implements Connectivity {
  MockConnectivity({required this.results});
  List<ConnectivityResult> results;

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return results;
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      Stream.value(results);
}

/// A concrete test implementation of [BaseAuthInterceptor].
class TestAuthInterceptor extends BaseAuthInterceptor {
  TestAuthInterceptor({
    required super.dio,
    required this.onRefresh,
    this.token,
  });

  String? token;
  final Future<bool> Function() onRefresh;
  int refreshCalls = 0;

  @override
  Future<String?> getAccessToken() async => token;

  @override
  Future<bool> refreshToken() async {
    refreshCalls++;
    final success = await onRefresh();
    if (success) {
      token = 'new_token';
    }
    return success;
  }
}

void main() {
  group('DioExceptionX Failure Mapping', () {
    test('maps timeout exceptions to NetworkFailure', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
        message: 'Timeout occured',
      );

      final failure = dioError.toFailure();
      expect(failure, isA<NetworkFailure>());
      expect(failure.code, equals('TIMEOUT'));
    });

    test('maps connection exceptions to NetworkFailure', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
        message: 'No route to host',
      );

      final failure = dioError.toFailure();
      expect(failure, isA<NetworkFailure>());
      expect(failure.code, equals('NO_CONNECTION'));
    });

    test('maps 4xx/5xx responses to ServerFailure with custom messages', () {
      final responseData = {
        'message': 'Invalid data passed',
        'code': 'VAL_ERR',
      };
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
          data: responseData,
        ),
      );

      final failure = dioError.toFailure();
      expect(failure, isA<ServerFailure>());
      expect(failure.code, equals('VAL_ERR'));
      expect(failure.message, equals('Invalid data passed'));
      expect((failure as ServerFailure).statusCode, equals(422));
    });
  });

  group('ConnectivityService', () {
    test('checkConnection completes when connection exists', () async {
      final mock = MockConnectivity(results: [ConnectivityResult.wifi]);
      final service = ConnectivityService(connectivity: mock);

      await expectLater(service.checkConnection(), completes);
      expect(await service.hasConnection(), isTrue);
    });

    test('checkConnection throws NetworkFailure when offline', () async {
      final mock = MockConnectivity(results: [ConnectivityResult.none]);
      final service = ConnectivityService(connectivity: mock);

      await expectLater(
        service.checkConnection(),
        throwsA(isA<NetworkFailure>()),
      );
      expect(await service.hasConnection(), isFalse);
    });
  });

  group('NetworkLoggingInterceptor', () {
    test('logs requests, responses, and errors cleanly', () async {
      final mockLogger = MockSkyLogger();
      final dio = Dio();
      dio.interceptors.add(NetworkLoggingInterceptor(logger: mockLogger));

      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          if (options.path == '/success') {
            return ResponseBody.fromString(
              jsonEncode({'status': 'ok'}),
              200,
              headers: {
                Headers.contentTypeHeader: [Headers.jsonContentType],
              },
            );
          } else {
            return ResponseBody.fromString('Not Found', 404);
          }
        },
      );

      // Perform a successful request
      await dio.get<dynamic>('/success', queryParameters: {'q': 'flutter'});

      expect(mockLogger.logged, hasLength(2));
      expect(mockLogger.logged[0]['level'], equals(LogLevel.info));
      expect(mockLogger.logged[0]['message'], contains('GET'));
      final context0 =
          mockLogger.logged[0]['context'] as Map<String, dynamic>?;
      expect(context0?['query_parameters'], isNotNull);

      expect(mockLogger.logged[1]['level'], equals(LogLevel.info));
      expect(mockLogger.logged[1]['message'], contains('200'));

      // Perform a failing request
      mockLogger.logged.clear();
      try {
        await dio.get<dynamic>('/fail');
      } on DioException catch (_) {}

      expect(mockLogger.logged, hasLength(2));
      expect(mockLogger.logged[1]['level'], equals(LogLevel.error));
      expect(mockLogger.logged[1]['message'], contains('404'));
      expect(mockLogger.logged[1]['error'], isA<DioException>());
    });
  });

  group('BaseAuthInterceptor', () {
    test(
      'injects token and performs sequential 401 refresh and retry',
      () async {
      final dio = Dio();
      var requestIndex = 0;
      var hasRefreshed = false;

      final authInterceptor = TestAuthInterceptor(
        dio: dio,
        token: 'initial_token',
        onRefresh: () async {
          hasRefreshed = true;
          return true;
        },
      );

      dio.interceptors.add(authInterceptor);
      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          requestIndex++;
          final authHeader = options.headers['Authorization'] as String?;

          if (requestIndex == 1) {
            // First request fails with 401. Verify it had the initial token.
            expect(authHeader, equals('Bearer initial_token'));
            return ResponseBody.fromString('Unauthorized', 401);
          } else {
            // Second request succeeds. Verify it has the refreshed token.
            expect(authHeader, equals('Bearer new_token'));
            return ResponseBody.fromString(
              jsonEncode({'status': 'ok'}),
              200,
              headers: {
                Headers.contentTypeHeader: [Headers.jsonContentType],
              },
            );
          }
        },
      );

      final response = await dio.get<dynamic>('/secure');
      expect(response.statusCode, equals(200));
      expect(hasRefreshed, isTrue);
      expect(authInterceptor.refreshCalls, equals(1));
    });
  });

  group('SkyNetworkClient Integration', () {
    test(
      'pre-flight connectivity throws NetworkFailure and skips request',
      () async {
        final mockConnectivity = MockConnectivity(
          results: [ConnectivityResult.none],
        );
      final service = ConnectivityService(connectivity: mockConnectivity);
      final client = SkyNetworkClient(connectivityService: service);

      var didExecuteNetwork = false;
      client.dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          didExecuteNetwork = true;
          return ResponseBody.fromString('Ok', 200);
        },
      );

      await expectLater(
        client.get<dynamic>('/posts'),
        throwsA(
          isA<NetworkFailure>().having(
            (f) => f.code,
            'code',
            equals('NO_CONNECTION'),
          ),
        ),
      );

      expect(didExecuteNetwork, isFalse);
    });
  });
}
