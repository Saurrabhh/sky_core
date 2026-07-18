# sky_storage

Unified local storage core package containing key contracts, abstract repositories, base interfaces, and structured Data Access Object (DAO) templates. It serves as the baseline for specific engine implementations like Hive or Isar.

## Features

* **Engines Decoupling:** Fully abstracts persistence layers so your core logic remains independent of the database library.
* **DAO Pattern Contracts:** Pre-packaged templates for `Dao` (asynchronous) and `DaoSync` (synchronous) to standardize queries, operations, and clean-up tasks.

## Getting Started / Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_storage: ^1.0.4
```

## Usage

Use the core DAO interfaces to abstract local database actions. For example, when consuming a DAO in a repository:

```dart
import 'package:sky_storage/sky_storage.dart';

// 1. Define your data model
class Task {
  const Task({required this.id, required this.title});
  final String id;
  final String title;
}

// 2. Consume the DAO abstraction in your repository
class TaskRepository {
  const TaskRepository({required this.taskDao});

  final Dao<String, Task> taskDao;

  Future<void> saveTask(Task task) async {
    await taskDao.put(task.id, task);
  }

  Future<Task?> getTask(String id) async {
    return taskDao.get(id);
  }
}
```

## Additional information

For more information, bug reports, or contributions, please visit the [GitHub repository](https://github.com/Saurrabhh/sky_core).
