import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sky_network/src/options/network_options.dart';

// The interface pattern is intentionally chosen here for DI mockability.
// ignore: one_member_abstracts
abstract interface class DioFactory {
  /// Creates and configures a [Dio] instance.
  ///
  /// Takes non-nullable [options] and an optional list of [interceptors]
  /// to add to the created client.
  Dio create({
    required NetworkOptions options,
    List<Interceptor> interceptors,
  });
}

/// {@template dio_factory_impl}
/// Concrete implementation of [DioFactory] configuring standard headers,
/// connection timeouts, and registering [PrettyDioLogger] for telemetry.
/// {@endtemplate}
class DioFactoryImpl implements DioFactory {
  /// {@macro dio_factory_impl}
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

    // 1. Add standard pretty logger in debug mode only for formatting.
    if (kDebugMode) {
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
