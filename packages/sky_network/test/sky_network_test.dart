import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/sky_network.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

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
  group('DioExceptionX Exception Mapping', () {
    test('maps timeout exceptions to NetworkException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
        message: 'Timeout occured',
      );

      final exception = dioError.toException();
      expect(exception, isA<NetworkException>());
      expect(exception.code, equals('TIMEOUT'));
    });

    test('maps transformTimeout exceptions to NetworkException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.transformTimeout,
        message: 'Transform timeout occurred',
      );

      final exception = dioError.toException();
      expect(exception, isA<NetworkException>());
      expect(exception.code, equals('TIMEOUT'));
    });

    test('maps connection exceptions to NetworkException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
        message: 'No route to host',
      );

      final exception = dioError.toException();
      expect(exception, isA<NetworkException>());
      expect(exception.code, equals('NO_CONNECTION'));
    });

    test('maps 4xx/5xx responses to ServerException with custom messages', () {
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

      final exception = dioError.toException();
      expect(exception, isA<ServerException>());
      expect(exception.code, equals('VAL_ERR'));
      expect(exception.message, equals('Invalid data passed'));
      expect((exception as ServerException).statusCode, equals(422));
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
              expect(authHeader, equals('Bearer initial_token'));
              return ResponseBody.fromString('Unauthorized', 401);
            } else {
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
      },
    );

    test(
      'bypasses access token injection when '
      'No-Authentication header is present',
      () async {
        final dio = Dio();
        final authInterceptor = TestAuthInterceptor(
          dio: dio,
          token: 'initial_token',
          onRefresh: () async => true,
        );

        dio.interceptors.add(authInterceptor);
        dio.httpClientAdapter = MockAdapter(
          handler: (options) async {
            final authHeader = options.headers['Authorization'] as String?;

            expect(options.headers.containsKey('No-Authentication'), isFalse);
            expect(authHeader, isNull);

            return ResponseBody.fromString(jsonEncode({'status': 'ok'}), 200);
          },
        );

        final response = await dio.get<dynamic>(
          '/public',
          options: Options(headers: {'No-Authentication': true}),
        );
        expect(response.statusCode, equals(200));
      },
    );
  });

  group('DioFactory Implementation', () {
    test(
      'creates configured Dio instance without pretty logger by default',
      () {
        const dioFactory = DioFactoryImpl();
        final dio = dioFactory.create(
          options: const NetworkOptions(
            baseUrl: 'https://api.example.com',
            connectTimeout: Duration(seconds: 15),
          ),
        );

        expect(dio.options.baseUrl, equals('https://api.example.com'));
        expect(dio.options.connectTimeout, equals(const Duration(seconds: 15)));

        final prettyLogger = dio.interceptors.where(
          (i) => i.runtimeType.toString() == 'PrettyDioLogger',
        );
        expect(prettyLogger, isEmpty);
      },
    );

    test(
      'creates configured Dio instance with pretty logger when enableLogging '
      'is true',
      () {
        const dioFactory = DioFactoryImpl();
        final dio = dioFactory.create(
          options: const NetworkOptions(
            baseUrl: 'https://api.example.com',
            connectTimeout: Duration(seconds: 15),
            enableLogging: true,
          ),
        );

        expect(dio.options.baseUrl, equals('https://api.example.com'));
        expect(dio.options.connectTimeout, equals(const Duration(seconds: 15)));

        final prettyLogger = dio.interceptors.where(
          (i) => i.runtimeType.toString() == 'PrettyDioLogger',
        );
        expect(prettyLogger, isNotEmpty);
      },
    );

    test(
      'creates configured Dio instance with CertificatePinningInterceptor when '
      'sslFingerprints is not empty',
      () {
        const dioFactory = DioFactoryImpl();
        final dio = dioFactory.create(
          options: const NetworkOptions(
            baseUrl: 'https://api.example.com',
            connectTimeout: Duration(seconds: 15),
            sslFingerprints: ['9A:3D:5F:8B'],
          ),
        );

        final pinLogger = dio.interceptors
            .whereType<CertificatePinningInterceptor>();
        expect(pinLogger, isNotEmpty);
      },
    );
  });

  group('SkyBackgroundTransformer', () {
    test(
      'parses json correctly and uses background decoding fallback',
      () async {
        final transformer = SkyBackgroundTransformer(thresholdBytes: 10);
        final jsonMap = {'message': 'hello', 'status': 'ok'};
        final responseBody = ResponseBody.fromString(
          jsonEncode(jsonMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );

        final result = await transformer.transformResponse(
          RequestOptions(path: '/test', responseType: ResponseType.json),
          responseBody,
        );

        expect(result, equals(jsonMap));
      },
    );

    test('ignores non-json response type', () async {
      final transformer = SkyBackgroundTransformer(thresholdBytes: 10);
      const rawText = 'plain text response';
      final responseBody = ResponseBody.fromString(
        rawText,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.textPlainContentType],
        },
      );

      final result = await transformer.transformResponse(
        RequestOptions(path: '/test', responseType: ResponseType.plain),
        responseBody,
      );

      expect(result, equals(rawText));
    });
  });

  group('RetryInterceptor', () {
    test(
      'retries transient 503 error and succeeds on second attempt',
      () async {
        final dio = Dio();
        var attempts = 0;
        dio.interceptors.add(
          RetryInterceptor(
            dio: dio,
            options: const NetworkOptions(
              maxRetries: 2,
              initialRetryDelay: Duration(milliseconds: 5),
              retryBackoffFactor: 1.5,
              retryableStatuses: [503],
            ),
          ),
        );

        dio.httpClientAdapter = MockAdapter(
          handler: (options) async {
            attempts++;
            if (attempts == 1) {
              return ResponseBody.fromString('', 503);
            } else {
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

        final response = await dio.get<dynamic>('/test');
        expect(response.statusCode, equals(200));
        expect(attempts, equals(2));
      },
    );

    test('gives up after max retries are exhausted', () async {
      final dio = Dio();
      var attempts = 0;
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          options: const NetworkOptions(
            maxRetries: 2,
            initialRetryDelay: Duration(milliseconds: 1),
            retryBackoffFactor: 1,
            retryableStatuses: [503],
          ),
        ),
      );

      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          attempts++;
          return ResponseBody.fromString('', 503);
        },
      );

      try {
        await dio.get<dynamic>('/test');
        fail('Should have failed');
      } on DioException catch (e) {
        expect(e.response?.statusCode, equals(503));
      }
      expect(
        attempts,
        equals(3),
      ); // 1 initial request + 2 retries = 3 total attempts
    });

    test('respects disableRetry flag and does not retry', () async {
      final dio = Dio();
      var attempts = 0;
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          options: const NetworkOptions(
            maxRetries: 2,
            initialRetryDelay: Duration(milliseconds: 1),
            retryBackoffFactor: 1,
            retryableStatuses: [503],
          ),
        ),
      );

      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          attempts++;
          return ResponseBody.fromString('', 503);
        },
      );

      try {
        await dio.get<dynamic>(
          '/test',
          options: Options(extra: {'disableRetry': true}),
        );
        fail('Should have failed');
      } on DioException catch (e) {
        expect(e.response?.statusCode, equals(503));
      }
      expect(
        attempts,
        equals(1),
      ); // should only be 1 attempt because retries are disabled
    });
  });

  group('DynamicUrlInterceptor', () {
    test('resolves dynamic base URL when resolver is provided', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://initial.example.com'));
      dio.interceptors.add(
        DynamicUrlInterceptor(
          NetworkOptions(
            baseUrl: 'https://initial.example.com',
            baseUrlResolver: () => 'https://dynamic.example.com',
          ),
        ),
      );

      var resolvedUrl = '';
      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          resolvedUrl = options.baseUrl;
          return ResponseBody.fromString(jsonEncode({'status': 'ok'}), 200);
        },
      );

      await dio.get<dynamic>('/data');
      expect(resolvedUrl, equals('https://dynamic.example.com'));
    });

    test('ignores resolver if path is an absolute URL', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://initial.example.com'));
      dio.interceptors.add(
        DynamicUrlInterceptor(
          NetworkOptions(
            baseUrl: 'https://initial.example.com',
            baseUrlResolver: () => 'https://dynamic.example.com',
          ),
        ),
      );

      var resolvedUrl = '';
      var resolvedPath = '';
      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          resolvedUrl = options.baseUrl;
          resolvedPath = options.path;
          return ResponseBody.fromString(jsonEncode({'status': 'ok'}), 200);
        },
      );

      await dio.get<dynamic>('https://external.example.com/api');
      expect(resolvedUrl, equals('https://initial.example.com'));
      expect(resolvedPath, equals('https://external.example.com/api'));
    });

    test('ignores resolver if bypass flag is present', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://initial.example.com'));
      dio.interceptors.add(
        DynamicUrlInterceptor(
          NetworkOptions(
            baseUrl: 'https://initial.example.com',
            baseUrlResolver: () => 'https://dynamic.example.com',
          ),
        ),
      );

      var resolvedUrl = '';
      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          resolvedUrl = options.baseUrl;
          return ResponseBody.fromString(jsonEncode({'status': 'ok'}), 200);
        },
      );

      await dio.get<dynamic>(
        '/data',
        options: Options(extra: {'bypassBaseUrlResolver': true}),
      );
      expect(resolvedUrl, equals('https://initial.example.com'));
    });
  });

  group('UserAgentEnrichmentInterceptor', () {
    test('injects default and custom headers correctly', () async {
      final dio = Dio();
      dio.interceptors.add(
        UserAgentEnrichmentInterceptor(
          const NetworkOptions(userAgent: 'CustomAgent/2.0.0'),
        ),
      );

      var headers = <String, dynamic>{};
      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          headers = options.headers;
          return ResponseBody.fromString(jsonEncode({'status': 'ok'}), 200);
        },
      );

      await dio.get<dynamic>('/test');
      expect(headers['User-Agent'], equals('CustomAgent/2.0.0'));
      expect(headers['Accept-Language'], isNotEmpty);
      expect(headers['X-Client-Timezone'], isNotEmpty);
    });
  });

  group('TelemetryInterceptor & NetworkTime Sync', () {
    late List<Map<String, dynamic>> trackedEvents;
    late SkyAnalytics mockAnalytics;

    setUp(() {
      trackedEvents = [];
      mockAnalytics = _TestAnalytics(
        onTrack: (name, params) {
          trackedEvents.add({'name': name, 'params': params});
        },
      );
      SkyAnalyticsRegistry.instance.registerProvider(mockAnalytics);
    });

    tearDown(() {
      SkyAnalyticsRegistry.instance.unregisterProvider(mockAnalytics);
    });

    test('captures latency and formats HTTP response size correctly', () async {
      final dio = Dio();
      dio.interceptors.add(TelemetryInterceptor());

      dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          return ResponseBody.fromString(
            jsonEncode({'message': 'success'}),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
              'date': ['Wed, 21 Oct 2015 07:28:00 GMT'],
            },
          );
        },
      );

      await dio.get<dynamic>('/users/123/posts/abc-uuid-hash-value-123456');

      // Verify event was logged to analytics
      final performanceEvent = trackedEvents.firstWhere(
        (e) => e['name'] == 'api_performance',
      );
      final params = performanceEvent['params'] as Map<String, dynamic>;

      expect(params['method'], equals('GET'));
      expect(params['path'], equals('/users/:id/posts/:id'));
      expect(params['statusCode'], equals(200));
      expect(params['latencyMs'], isNot(equals(-1)));

      // Verify timezone drift sync
      expect(NetworkTime.clockDriftMs, isNot(equals(0)));
    });
  });

  group('ApiCallHandler & ApiCallHandlerImpl Integration', () {
    test('executes successful request and resolves Right data', () async {
      const apiHandler = ApiCallHandlerImpl();

      final result = await apiHandler.handle(() async {
        return 'success_response';
      });

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Should have succeeded'),
        (data) => expect(data, equals('success_response')),
      );
    });

    test('returns Left wrapping mapped Failure upon DioException', () async {
      const apiHandler = ApiCallHandlerImpl();

      final dioError = DioException(
        requestOptions: RequestOptions(path: '/secure'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/secure'),
          statusCode: 403,
          data: {'message': 'Forbidden access'},
        ),
      );

      final result = await apiHandler.handle(() async {
        throw dioError;
      });

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, equals('Forbidden access'));
        },
        (data) => fail('Should have failed'),
      );
    });
  });
}

class _TestAnalytics implements SkyAnalytics {
  _TestAnalytics({required this.onTrack});

  final void Function(String name, Map<String, dynamic>? parameters) onTrack;

  @override
  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {
    onTrack(name, parameters);
  }

  @override
  Future<void> trackScreen(
    String name, {
    String? screenClass,
    Map<String, dynamic>? parameters,
  }) async {}

  @override
  Future<void> setUserId(String userId) async {}

  @override
  Future<void> setUserProperty(String key, String value) async {}

  @override
  Future<void> clearUser() async {}
}
