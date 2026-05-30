# sky_storage_hive

A premium local storage implementation for Flutter, wrapping `hive_ce` and `hive_ce_flutter` to implement the `sky_storage` interfaces. It is highly optimized for fast, simple key-value lookups and secure encryption.

## Features

* **Hive Engines:** Direct realization of `KeyValueDao` and `ObjectDao` matching standard contracts.
* **Secured Encryption:** Out-of-the-box configuration and box setup using secure encryption keys.
* **Auto-Initialization:** Automated Flutter directory binding and adapter registrations.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_storage_hive: ^1.0.0
```

## Usage

Initialize Hive and declare your Hive-backed DAOs:

```dart
import 'package:sky_storage_hive/sky_storage_hive.dart';

void main() async {
  // 1. Initialize Hive DB
  await SkyHiveInitializer.initialize();

  // 2. Open box using secure key (optional)
  final taskBox = await SkyHiveInitializer.openEncryptedBox<String>('secure_tasks');
  
  // 3. Perform write & read actions
  await taskBox.put('task_1', 'Implement publishing workflow');
  final taskValue = taskBox.get('task_1');
  print('Task: $taskValue');
}
```
