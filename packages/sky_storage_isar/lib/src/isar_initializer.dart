import 'package:isar_community/isar.dart';

import 'package:sky_storage/sky_storage.dart';

/// Interface for providing database schemas to Isar.
abstract interface class IsarSchemaProvider {
  /// Collection schemas to register.
  List<CollectionSchema<dynamic>> get schemas;
}

/// A [DatabaseInitializer] for preparing an Isar-based local database.
class IsarDatabaseInitializer implements DatabaseInitializer {
  /// Creates an [IsarDatabaseInitializer] with schema providers and config.
  IsarDatabaseInitializer({
    required this.providers,
    required this.directory,
    this.name = 'isar',
    this.inspector = true,
  });

  /// Providers supplying database schemas.
  final List<IsarSchemaProvider> providers;

  /// File directory path where database files are saved.
  final String directory;

  /// Database instance name.
  final String name;

  /// Indicates if the visual database inspector should be enabled.
  final bool inspector;

  Isar? _isar;

  /// Returns the active [Isar] instance.
  ///
  /// Throws a [StateError] if accessed before calling [initialize].
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
