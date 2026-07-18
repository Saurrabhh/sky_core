# sky_storage_hive

A premium local storage implementation for Flutter, wrapping `hive_ce` and `hive_ce_flutter` to implement the `sky_storage` interfaces. It is highly optimized for fast, simple key-value lookups and secure encryption.

## Features

* **Hive Engines:** Direct realization of the `Dao` interface using Hive boxes.
* **Secured Encryption:** Out-of-the-box configuration and box setup using secure encryption keys.
* **Auto-Initialization:** Automated Flutter directory binding and adapter registrations.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_storage_hive: ^1.0.4
```

## Usage

Initialize Hive and use `HiveDao` to interact with boxes:

```dart
import 'package:sky_storage/sky_storage.dart';
import 'package:sky_storage_hive/sky_storage_hive.dart';

void main() async {
  // 1. Initialize Hive DB
  final initializer = HiveDatabaseInitializer(
    registerers: [MyAdapterRegisterer()],
  );
  await initializer.initialize();

  // 2. Open a box
  final box = await Hive.openBox<String>('tasks');
  
  // 3. Instantiate and use HiveDao
  final taskDao = HiveDao<String>(box: box);
  await taskDao.put('task_1', 'Implement publishing workflow');
}
```
