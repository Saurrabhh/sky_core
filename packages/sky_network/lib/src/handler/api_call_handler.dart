import 'package:dio/dio.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/src/error/network_error_mapper.dart';

/// {@template api_call_handler}
/// An abstract interface class responsible for executing network calls
/// and converting raw network exceptions into structured [SkyException]s.
/// {@endtemplate}
abstract interface class ApiCallHandler {
  /// Executes the given [call] safely.
  ///
  /// Catching any [DioException] and throwing the corresponding [SkyException].
  Future<T> handle<T>(Future<T> Function() call);
}

/// {@template api_call_handler_impl}
/// A concrete implementation of [ApiCallHandler] that performs safety wrapping
/// and automatic [DioException] mapping to data-layer [SkyException] models.
/// {@endtemplate}
class ApiCallHandlerImpl implements ApiCallHandler {
  /// {@macro api_call_handler_impl}
  const ApiCallHandlerImpl();

  @override
  Future<T> handle<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw e.toException();
    }
  }
}
