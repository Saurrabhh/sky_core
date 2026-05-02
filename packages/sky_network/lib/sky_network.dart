import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sky_error/sky_error.dart';

/// Factory to create a pre-configured [Dio] instance.
Dio createDio({
  String? baseUrl,
  Map<String, dynamic>? headers,
  List<Interceptor>? interceptors,
  Duration connectTimeout = const Duration(seconds: 30),
  Duration receiveTimeout = const Duration(seconds: 30),
  bool enableLogging = true,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        ...?headers,
      },
    ),
  );

  if (interceptors != null && interceptors.isNotEmpty) {
    dio.interceptors.addAll(interceptors);
  }

  if (enableLogging) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  return dio;
}

/// Extension to map [DioException] to [Failure].
extension DioExceptionExtension on DioException {
  /// Converts a [DioException] into a [Failure].
  Failure toFailure() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure('Connection timed out');
      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        return ServerFailure('Server returned error: $statusCode');
      case DioExceptionType.cancel:
        return const UnexpectedFailure('Request was cancelled');
      case DioExceptionType.badCertificate:
        return const NetworkFailure('Bad certificate');
      case DioExceptionType.unknown:
        return UnexpectedFailure(message ?? 'Unknown network error');
    }
  }
}

/// Wrapper for safe network calls that returns a [FutureResult].
FutureResult<T> safeNetworkCall<T>(Future<T> Function() call) async {
  try {
    final response = await call();
    return right(response);
  } on DioException catch (e) {
    return left(e.toFailure());
  } catch (e) {
    return left(UnexpectedFailure(e.toString()));
  }
}
