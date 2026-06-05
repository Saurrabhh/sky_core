import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'package:sky_storage/sky_storage.dart';

/// Interface for registering Hive type adapters.
abstract interface class HiveAdapterRegisterer {
  /// Registers type adapters with Hive.
  void registerAdapters();
}

/// A [DatabaseInitializer] for initializing a Hive-based local database.
class HiveDatabaseInitializer implements DatabaseInitializer {
  /// Creates a [HiveDatabaseInitializer] with adapters and a storage directory.
  HiveDatabaseInitializer({
    required this.registerers,
    this.subDir,
  });

  /// Registry handlers for custom data adapters.
  final List<HiveAdapterRegisterer> registerers;

  /// Subdirectory under the default storage folder for Hive box files.
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
