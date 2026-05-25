import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'package:sky_storage/sky_storage.dart';

abstract interface class HiveAdapterRegisterer {
  void registerAdapters();
}

class HiveDatabaseInitializer implements DatabaseInitializer {
  HiveDatabaseInitializer({
    required this.registerers,
    this.subDir,
  });

  final List<HiveAdapterRegisterer> registerers;

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
