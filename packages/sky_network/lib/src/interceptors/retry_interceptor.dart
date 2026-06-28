import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:sky_network/src/options/network_options.dart';

/// Interceptor that automatically retries failed requests due to transient
/// errors using exponential backoff with randomized jitter.
class RetryInterceptor extends Interceptor {
  /// Creates a [RetryInterceptor] with the specified [dio] client and
  /// [options].
  RetryInterceptor({
    required this.dio,
    required this.options,
  });

  /// The [Dio] client instance used to dispatch the retried request.
  final Dio dio;

  /// The configuration options detailing retry counts, delays, and status
  /// codes.
  final NetworkOptions options;

  final _random = Random();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    // Check if retry is explicitly disabled for this request via extra
    if (requestOptions.extra['disableRetry'] == true) {
      super.onError(err, handler);
      return;
    }

    final currentAttempt = requestOptions.extra['_retryAttempt'] as int? ?? 0;

    if (currentAttempt < options.maxRetries && _shouldRetry(err)) {
      final nextAttempt = currentAttempt + 1;
      requestOptions.extra['_retryAttempt'] = nextAttempt;

      // Calculate exponential backoff delay: initial * factor ^ attempt
      final backoffDelayMs =
          (options.initialRetryDelay.inMilliseconds *
                  pow(options.retryBackoffFactor, currentAttempt))
              .round();

      // Add randomized jitter to prevent thundering herd
      // (e.g. up to 25% random adjustment)
      final jitter = (backoffDelayMs * 0.25 * _random.nextDouble()).round();
      final finalDelayMs =
          backoffDelayMs + (_random.nextBool() ? jitter : -jitter);

      await Future<void>.delayed(Duration(milliseconds: max(0, finalDelayMs)));

      try {
        // Re-dispatch the request
        final response = await dio.fetch<dynamic>(requestOptions);
        return handler.resolve(response);
      } on DioException catch (retryErr) {
        return super.onError(retryErr, handler);
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    final statusCode = err.response?.statusCode;
    if (statusCode != null && options.retryableStatuses.contains(statusCode)) {
      return true;
    }

    return false;
  }
}
