import 'package:isar/isar.dart';
import 'package:sky_error/sky_error.dart';
import 'package:sky_storage/sky_storage.dart';
import 'package:sky_storage_isar/models/kv_entry.dart';

/// Isar-backed implementation of [SkyStorage].
class IsarStorage implements SkyStorage {
  /// Creates a new [IsarStorage] with the given [isar] instance.
  IsarStorage(this.isar);

  /// The [Isar] instance used for storage.
  final Isar isar;

  @override
  FutureResult<void> write(String key, String value) async {
    try {
      await isar.writeTxn(() async {
        final entry = KvEntry()
          ..key = key
          ..value = value;
        await isar.kvEntrys.put(entry);
      });
      return right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  FutureResult<String?> read(String key) async {
    try {
      final entry = await isar.kvEntrys.filter().keyEqualTo(key).findFirst();
      return right(entry?.value);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  FutureResult<bool> containsKey(String key) async {
    try {
      final count = await isar.kvEntrys.filter().keyEqualTo(key).count();
      return right(count > 0);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  FutureResult<void> delete(String key) async {
    try {
      await isar.writeTxn(() async {
        await isar.kvEntrys.filter().keyEqualTo(key).deleteAll();
      });
      return right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  FutureResult<void> clear() async {
    try {
      await isar.writeTxn(() async {
        await isar.kvEntrys.clear();
      });
      return right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
