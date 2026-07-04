import 'package:dio/dio.dart';
import 'package:sky_architecture/sky_architecture.dart';

/// Extension on [DioException] to map HTTP client exceptions.
extension DioExceptionX on DioException {
  /// Converts this [DioException] into a domain-specific [BaseException].
  ///
  /// Maps timeouts to [NetworkException], bad responses to [ServerException],
  /// and cancellation or cert errors to [UnknownException].
  BaseException toException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return NetworkException(
          message: 'Connection timeout. Please check your internet connection.',
          code: 'TIMEOUT',
          error: error,
          stackTrace: stackTrace,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network status.',
          code: 'NO_CONNECTION',
          error: error,
          stackTrace: stackTrace,
        );
      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        final responseData = response?.data;
        var message = 'A server error occurred';
        String? code;

        if (responseData is Map<String, dynamic>) {
          message =
              responseData['message'] as String? ??
              responseData['error'] as String? ??
              message;
          code = responseData['code'] as String?;
        } else if (responseData is String && responseData.isNotEmpty) {
          message = responseData;
        }

        return ServerException(
          message: message,
          code: code ?? 'SERVER_ERROR',
          statusCode: statusCode,
          error: error,
          stackTrace: stackTrace,
        );
      case DioExceptionType.cancel:
        return UnknownException(
          message: 'Request was cancelled.',
          code: 'CANCELLED',
          error: error,
          stackTrace: stackTrace,
        );
      case DioExceptionType.badCertificate:
        return UnknownException(
          message: 'Invalid server certificate.',
          code: 'BAD_CERTIFICATE',
          error: error,
          stackTrace: stackTrace,
        );
      case DioExceptionType.unknown:
        return UnknownException(
          message: message ?? 'An unexpected network error occurred.',
          code: 'UNKNOWN',
          error: error,
          stackTrace: stackTrace,
        );
    }
  }
}
