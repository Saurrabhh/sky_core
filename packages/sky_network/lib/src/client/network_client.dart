import 'package:dio/dio.dart';
import 'package:sky_network/src/client/network_options.dart';
import 'package:sky_network/src/error/network_error_mapper.dart';

/// {@template network_client}
/// An abstract interface defining HTTP operations for the network client.
/// {@endtemplate}
abstract interface class NetworkClient {
  /// Exposes the underlying [Dio] client.
  Dio get dio;

  /// Sends a GET request to the specified [path].
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Sends a POST request to the specified [path].
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Sends a PUT request to the specified [path].
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Sends a PATCH request to the specified [path].
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Sends a DELETE request to the specified [path].
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });
}

/// {@template dio_network_client}
/// A concrete implementation of [NetworkClient] built around [Dio].
///
/// Requires explicit non-nullable constructor parameters to support strict
/// Dependency Injection.
/// {@endtemplate}
class DioNetworkClient implements NetworkClient {
  /// {@macro dio_network_client}
  DioNetworkClient({
    required this.dio,
    required this.options,
  }) {
    _applyOptions();
  }

  @override
  final Dio dio;

  /// The configuration options applied to [dio].
  final NetworkOptions options;

  void _applyOptions() {
    dio.options
      ..baseUrl = options.baseUrl
      ..connectTimeout = options.connectTimeout
      ..receiveTimeout = options.receiveTimeout
      ..sendTimeout = options.sendTimeout
      ..headers = options.headers ?? {};
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.post<T>(
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

  @override
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.put<T>(
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

  @override
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.patch<T>(
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

  @override
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.delete<T>(
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
