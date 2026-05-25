import 'package:isar/isar.dart';
import 'package:sky_storage/sky_storage.dart';

/// {@template isar_schema_provider}
/// An interface for providing Isar collection schemas.
///
/// Implemented by modules to register their schemas centrally before the
/// Isar instance is opened.
/// {@endtemplate}
abstract interface class IsarSchemaProvider {
  /// Returns the list of Isar collection schemas provided by the module.
  List<CollectionSchema<dynamic>> get schemas;
}

/// {@template isar_database_initializer}
/// A production-grade implementation of [DatabaseInitializer] for Isar.
///
/// Collects and flattens schemas from all provided [IsarSchemaProvider]s
/// and opens the [Isar] database instance exactly once.
/// {@endtemplate}
class IsarDatabaseInitializer implements DatabaseInitializer {
  /// {@macro isar_database_initializer}
  IsarDatabaseInitializer({
    required this.providers,
    required this.directory,
    this.name = 'isar',
    this.inspector = true,
  });

  /// The list of schema providers.
  final List<IsarSchemaProvider> providers;

  /// The local storage directory.
  final String directory;

  /// The database name.
  final String name;

  /// Whether the Isar Inspector should be enabled.
  final bool inspector;

  Isar? _isar;

  /// Exposes the initialized [Isar] instance.
  ///
  /// Throws a [StateError] if called before [initialize].
  Isar get isar {
    final instance = _isar;
    if (instance == null) {
      throw StateError(
        'Isar database must be initialized before accessing the instance.',
      );
    }
    return instance;
  }

  @override
  Future<void> initialize() async {
    if (_isar != null) return;

    final schemas = providers.expand((p) => p.schemas).toList();

    _isar = await Isar.open(
      schemas,
      directory: directory,
      name: name,
      inspector: inspector,
    );
  }

  @override
  Future<void> close() async {
    final instance = _isar;
    if (instance != null && instance.isOpen) {
      await instance.close();
      _isar = null;
    }
  }
}
