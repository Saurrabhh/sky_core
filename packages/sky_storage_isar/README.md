# sky_storage_isar

A premium local storage implementation for Flutter, wrapping `isar_community` and `isar_community_flutter_libs` to implement the `sky_storage` interfaces. It is highly optimized for rich relational data and complex schemas.

## Features

* **Isar Engines:** Direct realization of `Dao` and `DaoSync` interfaces using Isar collections.
* **IsarCacheable Mixin:** Automatic `lastSyncedAt` timestamp tracking and Time-To-Live (TTL) expiration checking for cached models.
* **Type-Safe Queries:** Leveraging Isar's query compiler to perform advanced filters, sorts, and limits.
* **Watchers:** Native reactive watchers to automatically update Flutter components when database tables change.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_storage_isar: ^1.1.0
```

## Usage

### 1. Basic Dao Usage
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

### 2. TTL Expiration with IsarCacheable

Apply `IsarCacheable` mixin to any `@collection` model to enable automatic TTL expiration checks:

```dart
@collection
class GroupIsarModel with IsarCacheable {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? id;

  String? name;
}

// Check expiration before triggering network fetch
final model = await isar.groupIsarModels.filter().idEqualTo('123').findFirst();
if (model == null || model.isExpired(const Duration(minutes: 15))) {
  // Fetch fresh data from network
}
```
