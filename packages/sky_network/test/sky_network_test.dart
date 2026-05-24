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
  });

  group('DioNetworkClient Interface Integration', () {
    test('sends successful request and resolves response', () async {
      final dio = Dio();
      final client = DioNetworkClient(
        dio: dio,
        options: const NetworkOptions(baseUrl: 'https://api.example.com'),
      );

      client.dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          expect(options.baseUrl, equals('https://api.example.com'));
          return ResponseBody.fromString(
            jsonEncode({'status': 'ok'}),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            },
          );
        },
      );

      final response = await client.get<Map<String, dynamic>>('/data');
      expect(response.statusCode, equals(200));
      expect(response.data?['status'], equals('ok'));
    });

    test('rethrows mapped Failure upon DioException', () async {
      final dio = Dio();
      final client = DioNetworkClient(
        dio: dio,
        options: const NetworkOptions(),
      );

      client.dio.httpClientAdapter = MockAdapter(
        handler: (options) async {
          return ResponseBody.fromString('Unauthorized', 401);
        },
      );

      await expectLater(
        client.get<dynamic>('/secure'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
