import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sky_network/src/options/network_options.dart';

abstract interface class DioFactory {
  Dio create({
    required NetworkOptions options,
    List<Interceptor> interceptors,
  });
}

class DioFactoryImpl implements DioFactory {
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
