---
name: sky-storage-hive
description: Local caching using Hive CE
---

# sky_storage_hive Guidelines

Hive CE integration rules for key-value local storage.

## Guidelines & Checklists

### 1. HiveDao Usage
* Local data sources must use `HiveDao<T>` wrappers to query Hive boxes:
  ```dart
  final box = await Hive.openBox<bool>(_boxName);
  final dao = HiveDao<bool>(box: box);
  await dao.put(_myKey, true);
  final value = await dao.get(_myKey);
  ```

### 2. Adapter Registration
* All generated Hive adapters must be registered via `hive_registrar.g.dart` during app initialization.
* Use `@HiveType` and `@HiveField` annotations on models, then run `build_runner` to generate the adapters.

### 3. Box Naming
* Use feature-namespaced constants for box names to avoid key collisions (e.g., `auth_local_box`, `settings_box`).
