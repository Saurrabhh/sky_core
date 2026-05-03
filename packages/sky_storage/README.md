# sky_storage

Abstract storage interfaces and key-value store definitions for Sky Core.

## Usage

```dart
abstract class Storage {
  Future<void> write(String key, dynamic value);
  Future<dynamic> read(String key);
}
```
