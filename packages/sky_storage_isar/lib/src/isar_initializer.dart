import 'package:isar_community/isar.dart';

import 'package:sky_storage/sky_storage.dart';

abstract interface class IsarSchemaProvider {
  List<CollectionSchema<dynamic>> get schemas;
}

class IsarDatabaseInitializer implements DatabaseInitializer {
  IsarDatabaseInitializer({
    required this.providers,
    required this.directory,
    this.name = 'isar',
    this.inspector = true,
  });

  final List<IsarSchemaProvider> providers;

  final String directory;

  final String name;

  final bool inspector;

  Isar? _isar;

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
