import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'package:sky_storage/sky_storage.dart';

/// {@template hive_adapter_registerer}
/// An interface for registering Hive type adapters.
///
/// Implemented by modules to declare and register their custom adapters before
/// boxes are opened.
/// {@endtemplate}
abstract interface class HiveAdapterRegisterer {
  /// Registers the type adapters for Hive.
  void registerAdapters();
}

/// {@template hive_database_initializer}
/// A production-grade implementation of [DatabaseInitializer] for Hive.
///
/// Dispatches adapter registration to all provided [HiveAdapterRegisterer]s
/// and initializes the local disk paths.
/// {@endtemplate}
class HiveDatabaseInitializer implements DatabaseInitializer {
  /// {@macro hive_database_initializer}
  HiveDatabaseInitializer({
    required this.registerers,
    this.subDir,
  });

  /// The list of registerers called during initialization.
  final List<HiveAdapterRegisterer> registerers;

  /// Optional subdirectory path under the default storage folder.
  final String? subDir;

  @override
  Future<void> initialize() async {
    await Hive.initFlutter(subDir);
    for (final registerer in registerers) {
      registerer.registerAdapters();
    }
  }

  @override
  Future<void> close() async {
    await Hive.close();
  }
}
