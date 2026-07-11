---
name: sky-storage
description: Abstraction layers for key-value and document persistence
---

# sky_storage Guidelines

Enforces decoupling of database backends from business logic repositories.

## Guidelines & Checklists

### 1. Use Dao Abstractions
* Code all database caching actions against the standard `Dao<T>` interface. Implementations provide `put`, `get`, `getAll`, and `delete` operations.
* Do **not** import raw database engines (Hive, Isar) directly inside repositories or use cases.

### 2. DatabaseInitializer
* Call `DatabaseInitializer.init()` (or the appropriate implementation) during app startup to set up the database environment before any DAOs are accessed.

### 3. Implementation Selection
* Choose `sky_storage_hive` for simple key-value or small object caching.
* Choose `sky_storage_isar` for relational, indexed, or large-volume data requirements.
