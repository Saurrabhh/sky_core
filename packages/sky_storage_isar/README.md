# sky_storage_isar

A premium local storage implementation for Flutter, wrapping `isar_community` and `isar_community_flutter_libs` to implement the `sky_storage` interfaces. It is highly optimized for rich relational data and complex schemas.

## Features

* **Isar Engines:** Direct realization of `ObjectDao` matching standard contracts.
* **Type-Safe Queries:** Leveraging Isar's query compiler to perform advanced filters, sorts, and limits.
* **Watchers:** Native reactive watchers to automatically update Flutter components when database tables change.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_storage_isar: ^1.0.0
```

## Usage

Initialize Isar and register schemas:

```dart
import 'package:sky_storage_isar/sky_storage_isar.dart';

void main() async {
  // 1. Initialize Isar DB with your schemas
  final isarInstance = await SkyIsarInitializer.initialize(
    schemas: [TaskSchema],
    directory: '/path/to/documents',
  );

  // 2. Query collections reactively
  isarInstance.tasks.where().watch().listen((updatedTasks) {
    print('Tasks database modified: ${updatedTasks.length} total tasks');
  });
}
```
