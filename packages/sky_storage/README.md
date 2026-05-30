# sky_storage

Unified local storage core package containing key contracts, abstract repositories, base interfaces, and structured Data Access Object (DAO) templates. It serves as the baseline for specific engine implementations like Hive or Isar.

## Features

* **Engines Decoupling:** Fully abstracts persistence layers so your core logic remains independent of the database library.
* **DAO Pattern Contracts:** Pre-packaged templates for `KeyValueDao` and `ObjectDao` to standardize queries, operations, and clean-up tasks.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_storage: ^1.0.0
```

## Usage

Extend the core DAO definitions to structure your local database actions:

```dart
import 'package:sky_storage/sky_storage.dart';

// 1. Define an entity
class TaskEntity {
  const TaskEntity(this.id, this.title);
  final String id;
  final String title;
}

// 2. Define your DAO interface contract
abstract class TaskDao extends ObjectDao<TaskEntity> {
  Future<List<TaskEntity>> fetchAllActiveTasks();
}
```
