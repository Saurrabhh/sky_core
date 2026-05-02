import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_di/sky_di.config.dart';

export 'package:get_it/get_it.dart';

/// Global [GetIt] instance for the ecosystem.
final getIt = GetIt.instance;

/// Global [GetIt] shortcut for brevity.
final di = getIt;

/// Initializes the dependency injection for the ecosystem.
/// 
/// [env] can be used to distinguish between environments (e.g. dev, prod).
@InjectableInit(
  preferRelativeImports: true, // default
)
void configureDependencies({String? env}) => getIt.init(environment: env);
