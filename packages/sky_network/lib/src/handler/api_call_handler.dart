import 'package:dio/dio.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/src/error/network_error_mapper.dart';

/// Utility interface to safely execute API calls and handle network exceptions.
abstract interface class ApiCallHandler {
  /// Executes [call], mapping exceptions to a [Failure].
  Future<Either<Failure, T>> handle<T>(Future<T> Function() call);
}

/// Default [ApiCallHandler] mapping exceptions to domain failures.
class ApiCallHandlerImpl implements ApiCallHandler {
  /// Creates an [ApiCallHandlerImpl].
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
      return Left(e.toFailure());
    }
  }
}
