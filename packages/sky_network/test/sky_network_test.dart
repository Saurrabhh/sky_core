import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/sky_network.dart';

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
            // Verify that No-Authentication is removed and Authorization is
            // null
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
    test('creates configured Dio instance with pretty logger', () {
      const dioFactory = DioFactoryImpl();
      final dio = dioFactory.create(
        options: const NetworkOptions(
          baseUrl: 'https://api.example.com',
          connectTimeout: Duration(seconds: 15),
        ),
      );

      expect(dio.options.baseUrl, equals('https://api.example.com'));
      expect(dio.options.connectTimeout, equals(const Duration(seconds: 15)));
      // Logger interceptor should be added automatically
      expect(dio.interceptors, isNotEmpty);
    });
  });

  group('ApiCallHandler & ApiCallHandlerImpl Integration', () {
    test('executes successful request and resolves data', () async {
      const apiHandler = ApiCallHandlerImpl();

      final result = await apiHandler.handle(() async {
        return 'success_response';
      });

      expect(result, equals('success_response'));
    });

    test('rethrows mapped SkyException upon DioException', () async {
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

      await expectLater(
        apiHandler.handle(() async {
          throw dioError;
        }),
        throwsA(isA<ServerException>().having(
          (f) => f.message,
          'message',
          equals('Forbidden access'),
        )),
      );
    });
  });
}
