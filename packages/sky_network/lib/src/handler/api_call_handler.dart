import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/src/error/network_error_mapper.dart';

abstract interface class ApiCallHandler {
  Future<Either<Failure, T>> handle<T>(Future<T> Function() call);
}

class ApiCallHandlerImpl implements ApiCallHandler {
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
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
