import 'package:sky_error/sky_error.dart';

/// Interface for key-value storage.
abstract class SkyStorage {
  /// Writes a [value] to the storage associated with [key].
  FutureResult<void> write(String key, String value);

  /// Reads the value associated with [key] from the storage.
  FutureResult<String?> read(String key);

  /// Checks if the storage contains a value for the given [key].
  FutureResult<bool> containsKey(String key);

  /// Deletes the value associated with [key] from the storage.
  FutureResult<void> delete(String key);

  /// Clears all entries from the storage.
  FutureResult<void> clear();
}
