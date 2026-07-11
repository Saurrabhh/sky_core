---
name: sky-storage-isar
description: Local relational caching using Isar DB
---

# sky_storage_isar Guidelines

Isar database integration rules for relational and indexed local storage.

## Guidelines & Checklists

### 1. IsarDao Usage
* Extend `IsarDao<T>` when complex relational mapping, full-text search, or composite indexing is needed.
* Use Isar's built-in query builder for type-safe queries:
  ```dart
  final results = await isar.myModels
      .filter()
      .nameContains('query')
      .sortByCreatedAt()
      .findAll();
  ```

### 2. Schema Annotations
* Declare `@collection` on database model classes (separate from domain entities) with appropriate `@Index` annotations.
* Run code generation via `build_runner` after any schema changes.

### 3. Initialization
* Open the Isar instance during app startup via `DatabaseInitializer` before any DAO is accessed.
