# sky_storage_isar

A premium local storage implementation for Flutter, wrapping `isar_community` and `isar_community_flutter_libs` to implement the `sky_storage` interfaces. It is highly optimized for rich relational data and complex schemas.

## Features

* **Isar Engines:** Direct realization of `Dao` and `DaoSync` interfaces using Isar collections.
* **Type-Safe Queries:** Leveraging Isar's query compiler to perform advanced filters, sorts, and limits.
* **Watchers:** Native reactive watchers to automatically update Flutter components when database tables change.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_storage_isar: ^1.0.4
```

## Usage

Initialize Isar and use `IsarDao` or `IsarDaoSync` to interact with collections:

```dart
import 'package:sky_storage/sky_storage.dart';
import 'package:sky_storage_isar/sky_storage_isar.dart';

// 1. Initialize Isar DB during app startup
final initializer = IsarDatabaseInitializer(
  providers: [MySchemaProvider()],
  directory: '/path/to/documents',
);
await initializer.initialize();

// 2. Instantiate and use the DAO (async or sync)
final taskDao = IsarDao<Task>(collection: initializer.isar.tasks);
await taskDao.put(1, Task(id: 1, name: 'Learn Isar'));

final taskDaoSync = IsarDaoSync<Task>(collection: initializer.isar.tasks);
taskDaoSync.put(2, Task(id: 2, name: 'Use Isar sync'));
```
