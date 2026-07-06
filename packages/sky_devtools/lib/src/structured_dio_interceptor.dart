import 'package:dio/dio.dart';
import 'package:sky_devtools/src/structured_log.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// A custom Dio interceptor that formats API logs into type-safe
/// [StructuredNetworkLog] items.
class StructuredTalkerDioInterceptor extends Interceptor {
  /// Creates a [StructuredTalkerDioInterceptor] with a given [Talker] logger.
  StructuredTalkerDioInterceptor(this.talker);

  /// The active [Talker] instance.
  final Talker talker;

  // Track request start time using Expando to prevent leaks
  final Expando<DateTime> _startTimes = Expando<DateTime>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTimes[options] = DateTime.now();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final startTime = _startTimes[response.requestOptions];
    final durationMs = startTime != null
        ? DateTime.now().difference(startTime).inMilliseconds
        : 0;

    final req = response.requestOptions;
    final message =
        '''${req.method} ${req.uri.path} | Status: ${response.statusCode} | ${durationMs}ms''';

    talker.logCustom(
      StructuredNetworkLog(
        message,
        url: req.uri.toString(),
        method: req.method,
        requestHeaders: req.headers,
        responseHeaders: response.headers.map,
        requestBody: req.data,
        responseBody: response.data,
        statusCode: response.statusCode,
        durationMs: durationMs,
      ),
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = _startTimes[err.requestOptions];
    final durationMs = startTime != null
        ? DateTime.now().difference(startTime).inMilliseconds
        : 0;

    final req = err.requestOptions;
    final status = err.response?.statusCode;
    final message =
        '''${req.method} ${req.uri.path} | Error: ${err.message ?? err.type.toString()} | Status: $status | ${durationMs}ms''';

    talker.logCustom(
      StructuredNetworkLog(
        message,
        url: req.uri.toString(),
        method: req.method,
        requestHeaders: req.headers,
        responseHeaders: err.response?.headers.map ?? const {},
        requestBody: req.data,
        responseBody: err.response?.data,
        statusCode: status,
        durationMs: durationMs,
      ),
    );

    super.onError(err, handler);
  }
}
