import 'package:dio/dio.dart';
import 'package:sky_network/src/client/network_options.dart';
import 'package:sky_network/src/connectivity/connectivity_service.dart';
import 'package:sky_network/src/error/network_error_mapper.dart';

/// {@template sky_network_client}
/// A highly optimized and robust remote network client wrapped around [Dio].
///
/// Ensures all exceptions are mapped to clean domain failures, preventing
/// HTTP or Dio-specific dependencies from leaking into application layers.
/// {@endtemplate}
class SkyNetworkClient {
  /// {@macro sky_network_client}
  SkyNetworkClient({
    NetworkOptions? options,
    ConnectivityService? connectivityService,
    Dio? dio,
  })  : _connectivityService = connectivityService ?? ConnectivityService(),
        _dio = dio ?? Dio() {
    _applyOptions(options ?? const NetworkOptions());
  }

  final ConnectivityService _connectivityService;
  final Dio _dio;

  /// Exposes the underlying [Dio] client for advanced configurations or
  /// adding custom interceptors.
  Dio get dio => _dio;

  void _applyOptions(NetworkOptions options) {
    _dio.options
      ..baseUrl = options.baseUrl
      ..connectTimeout = options.connectTimeout
      ..receiveTimeout = options.receiveTimeout
      ..sendTimeout = options.sendTimeout
      ..headers = options.headers ?? {};
  }

  /// Sends a GET request to the specified [path].
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _connectivityService.checkConnection();
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }

  /// Sends a POST request to the specified [path].
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _connectivityService.checkConnection();
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }

  /// Sends a PUT request to the specified [path].
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _connectivityService.checkConnection();
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }

  /// Sends a PATCH request to the specified [path].
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _connectivityService.checkConnection();
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }

  /// Sends a DELETE request to the specified [path].
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _connectivityService.checkConnection();
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }
}
