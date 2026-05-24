import 'package:dio/dio.dart';
import 'package:sky_network/src/error/network_error_mapper.dart';

abstract interface class ApiCallHandler {
  Future<T> handle<T>(Future<T> Function() call);
}

class ApiCallHandlerImpl implements ApiCallHandler {
  const ApiCallHandlerImpl();

  @override
  Future<T> handle<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }
}
