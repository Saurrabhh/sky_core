import 'dart:async';
import 'package:dio/dio.dart';

/// {@template base_auth_interceptor}
/// An abstract [Interceptor] that handles Bearer token injection and automatic
/// token refresh on `401 Unauthorized` responses.
/// {@endtemplate}
abstract class BaseAuthInterceptor extends Interceptor {
  /// {@macro base_auth_interceptor}
  BaseAuthInterceptor({required this.dio});

  /// The underlying Dio instance.
  final Dio dio;
  Future<bool>? _refreshFuture;

  /// Retrieves the current access token.
  ///
  /// Returns null if no token exists.
  Future<String?> getAccessToken();

  /// Refreshes the access token when expired.
  ///
  /// Returns true if the refresh succeeded, false otherwise.
  Future<bool> refreshToken();

  /// Gets the token header name. Defaults to 'Authorization'.
  String get tokenHeaderName => 'Authorization';

  /// Formats the token string. Defaults to 'Bearer $token'.
  String formatToken(String token) => 'Bearer $token';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
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
          // Retry the failed request with the new access token.
          final token = await getAccessToken();
          final options = err.requestOptions;
          if (token != null) {
            options.headers[tokenHeaderName] = formatToken(token);
          }

          // Retry request
          final retryResponse = await dio.fetch<dynamic>(options);
          return handler.resolve(retryResponse);
        }
      } on DioException catch (retryErr) {
        return handler.reject(retryErr);
      } on Object catch (e) {
        // Fallback for non-Dio errors during refresh/retry.
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

    _refreshFuture = refreshToken().then((value) {
      _refreshFuture = null;
      return value;
    }).catchError((Object error) {
      _refreshFuture = null;
      return false;
    });

    return _refreshFuture!;
  }
}
