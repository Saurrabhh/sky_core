/// A highly optimized, Clean Architecture and DDD core library
/// for Sky applications.
library;

// Data Exceptions
export 'src/data/exceptions/exception.dart';
export 'src/data/exceptions/exception_mapper.dart';
export 'src/data/exceptions/exceptions.dart';

// DDD Primitives
export 'src/domain/ddd/entity.dart';
export 'src/domain/ddd/value_object.dart';

// Domain Failures
export 'src/domain/failures/failure.dart';
export 'src/domain/failures/failures.dart';

// Domain Query Utilities
export 'src/domain/query/pagination_params.dart';

// UseCases
export 'src/domain/usecase/no_params.dart';
export 'src/domain/usecase/usecase.dart';

// Functional Utilities
export 'src/utils/functional_extensions.dart';
