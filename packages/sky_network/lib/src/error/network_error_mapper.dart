import 'package:dio/dio.dart';
import 'package:sky_architecture/sky_architecture.dart';

extension DioExceptionX on DioException {
  Failure toFailure() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          message: 'Connection timeout. Please check your internet connection.',
          code: 'TIMEOUT',
        );
      case DioExceptionType.connectionError:
        return const NetworkFailure(
          message: 'No internet connection. Please check your network status.',
          code: 'NO_CONNECTION',
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

        return ServerFailure(
          message: message,
          code: code ?? 'SERVER_ERROR',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return const UnknownFailure(
          message: 'Request was cancelled.',
          code: 'CANCELLED',
        );
      case DioExceptionType.badCertificate:
        return const UnknownFailure(
          message: 'Invalid server certificate.',
          code: 'BAD_CERTIFICATE',
        );
      case DioExceptionType.unknown:
        return UnknownFailure(
          message: message ?? 'An unexpected network error occurred.',
          code: 'UNKNOWN',
        );
    }
  }
}
