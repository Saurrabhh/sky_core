import 'dart:async';

import 'package:dio/dio.dart';

abstract class BaseAuthInterceptor extends Interceptor {
  BaseAuthInterceptor({required this.dio});

  final Dio dio;
  Future<bool>? _refreshFuture;

  Future<String?> getAccessToken();

  Future<bool> refreshToken();

  String get tokenHeaderName => 'Authorization';

  String formatToken(String token) => 'Bearer $token';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.containsKey('No-Authentication')) {
      options.headers.remove('No-Authentication');
      super.onRequest(options, handler);
      return;
    }

    final token = await getAccessToken();
    if (token != null) {
      options.headers[tokenHeaderName] = formatToken(token);
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    if (response != null && response.statusCode == 401) {
      try {
        final success = await _executeTokenRefresh();
        if (success) {
          final token = await getAccessToken();
          final options = err.requestOptions;
          if (token != null) {
            options.headers[tokenHeaderName] = formatToken(token);
          }

          final retryResponse = await dio.fetch<dynamic>(options);
          return handler.resolve(retryResponse);
        }
      } on DioException catch (retryErr) {
        return handler.reject(retryErr);
      } on Object catch (e) {
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: e,
          ),
        );
      }
    }

    super.onError(err, handler);
  }

  Future<bool> _executeTokenRefresh() {
    if (_refreshFuture != null) {
      return _refreshFuture!;
    }

    _refreshFuture = refreshToken()
        .then((value) {
          _refreshFuture = null;
          return value;
        })
        .catchError((Object error) {
          _refreshFuture = null;
          return false;
        });

    return _refreshFuture!;
  }
}
