import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sky_network/src/factory/background_transformer.dart';
import 'package:sky_network/src/interceptors/dynamic_url_interceptor.dart';
import 'package:sky_network/src/interceptors/retry_interceptor.dart';
import 'package:sky_network/src/options/network_options.dart';

/// Factory interface for creating and configuring [Dio] HTTP clients.
abstract interface class DioFactory {
  /// Creates a [Dio] client configured with [options] and [interceptors].
  Dio create({
    required NetworkOptions options,
    List<Interceptor> interceptors,
  });
}

/// Default implementation of [DioFactory] configuring common settings.
class DioFactoryImpl implements DioFactory {
  /// Creates a [DioFactoryImpl].
  const DioFactoryImpl();

  @override
  Dio create({
    required NetworkOptions options,
    List<Interceptor> interceptors = const [],
  }) {
    final dio = Dio();

    dio.options
      ..baseUrl = options.baseUrl
      ..connectTimeout = options.connectTimeout
      ..receiveTimeout = options.receiveTimeout
      ..sendTimeout = options.sendTimeout
      ..headers = options.headers ?? {};

    dio.transformer = SkyBackgroundTransformer(
      thresholdBytes: options.jsonBgParserThresholdBytes,
    );

    if (options.baseUrlResolver != null) {
      dio.interceptors.add(DynamicUrlInterceptor(options));
    }

    dio.interceptors.add(
      RetryInterceptor(dio: dio, options: options),
    );

    if (!kIsWeb && options.sslFingerprints.isNotEmpty) {
      dio.interceptors.add(
        CertificatePinningInterceptor(
          allowedSHAFingerprints: options.sslFingerprints,
        ),
      );
    }

    if (options.enableLogging) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          maxWidth: 80,
        ),
      );
    }

    if (interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }

    return dio;
  }
}
