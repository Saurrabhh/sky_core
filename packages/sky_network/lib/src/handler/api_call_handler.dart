import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/src/error/network_error_mapper.dart';

/// {@template api_call_handler}
/// An abstract interface class responsible for executing network calls
/// and wrapping raw responses and exceptions into functional [Either] values.
/// {@endtemplate}
abstract interface class ApiCallHandler {
  /// Executes the given [call] safely.
  ///
  /// Returns a [Right] on success, or a [Left] wrapping the corresponding
  /// [Failure] on exceptions.
  Future<Either<Failure, T>> handle<T>(Future<T> Function() call);
}

/// {@template api_call_handler_impl}
/// A concrete implementation of [ApiCallHandler] that performs safety wrapping
/// and converts [DioException] errors directly into Domain [Failure] models.
/// {@endtemplate}
class ApiCallHandlerImpl implements ApiCallHandler {
  /// {@macro api_call_handler_impl}
  const ApiCallHandlerImpl();

  @override
  Future<Either<Failure, T>> handle<T>(Future<T> Function() call) async {
    try {
      final response = await call();
      return Right(response);
    } on DioException catch (e) {
      final exception = e.toException();
      final failure = exception.toFailure();
      return Left(failure);
    } on Object catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
