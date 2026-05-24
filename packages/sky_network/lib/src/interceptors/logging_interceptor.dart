import 'package:dio/dio.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

/// {@template network_logging_interceptor}
/// A Dio [Interceptor] that logs HTTP requests, responses, and errors
/// to the injected [SkyLogger].
/// {@endtemplate}
class NetworkLoggingInterceptor extends Interceptor {
  /// {@macro network_logging_interceptor}
  const NetworkLoggingInterceptor({
    required this.logger,
  });

  /// The logger used to output network activity details.
  final SkyLogger logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..write('[Network Request] -> ')
      ..write('${options.method.toUpperCase()} | ')
      ..write('URL: ${options.uri}');

    final context = <String, dynamic>{
      'headers': options.headers,
    };

    if (options.queryParameters.isNotEmpty) {
      context['query_parameters'] = options.queryParameters;
    }

    if (options.data != null) {
      context['body'] = options.data;
    }

    logger.log(
      LogLevel.info,
      buffer.toString(),
      context: context,
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final buffer = StringBuffer()
      ..write('[Network Response] <- ')
      ..write('Status: ${response.statusCode} | ')
      ..write('URL: ${response.requestOptions.uri}');

    final context = <String, dynamic>{};
    final data = response.data;
    if (data != null) {
      if (data is String) {
        context['body_length'] = data.length;
      } else if (data is Map || data is List) {
        context['body'] = data;
      }
    }

    logger.log(
      LogLevel.info,
      buffer.toString(),
      context: context.isNotEmpty ? context : null,
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..write('[Network Error] ! ')
      ..write('Status: ${err.response?.statusCode ?? 'N/A'} | ')
      ..write('URL: ${err.requestOptions.uri} | ')
      ..write('Type: ${err.type.name}');

    final context = <String, dynamic>{
      'message': err.message,
    };

    final responseData = err.response?.data;
    if (responseData != null) {
      context['response_body'] = responseData;
    }

    logger.log(
      LogLevel.error,
      buffer.toString(),
      error: err,
      stackTrace: err.stackTrace,
      context: context,
    );

    super.onError(err, handler);
  }
}
