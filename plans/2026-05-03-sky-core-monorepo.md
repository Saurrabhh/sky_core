# Sky Core Monorepo Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform the `sky_design_system` repository into a `sky_core` monorepo containing micro-packages for UI, networking, storage, error handling, and DI.

**Architecture:** A Melos-managed monorepo following Clean Architecture. Infrastructure is decoupled via abstract interfaces, and errors are handled explicitly using the `Either` pattern from `fpdart`.

**Tech Stack:** Flutter, Melos, fpdart, Retrofit, Dio, Isar, GetIt, Injectable, very_good_analysis.

---

## File Structure Overview

```text
/
├── melos.yaml                  # Monorepo configuration
├── packages/
│   ├── sky_lints/              # Shared linting rules
│   ├── sky_error/              # Result/Either types and Failure classes
│   ├── sky_storage/            # Abstract storage interfaces
│   ├── sky_storage_isar/       # Isar implementation of sky_storage
│   ├── sky_network/            # Retrofit/Dio network layer
│   ├── sky_design_system/      # (Existing) UI components and themes
│   └── sky_di/                 # Dependency Injection setup
```

---

### Task 1: Monorepo Initialization with Melos

**Files:**
- Create: `melos.yaml`
- Modify: `.gitignore`

- [ ] **Step 1: Create melos.yaml**
```yaml
name: sky_core
packages:
  - packages/**
```

- [ ] **Step 2: Update .gitignore to ignore melos generated files**
Add `.melos/` and `melos_sky_core.iml` (if any).

- [ ] **Step 3: Create packages directory**
Run: `mkdir packages`

- [ ] **Step 4: Commit**
```bash
git add melos.yaml .gitignore
git commit -m "feat: initialize melos monorepo"
```

---

### Task 2: Restructure Existing Design System

**Files:**
- Move: `lib/`, `test/`, `pubspec.yaml`, etc. to `packages/sky_design_system/`

- [ ] **Step 1: Move files into package directory**
```bash
mkdir packages/sky_design_system
mv lib packages/sky_design_system/
mv test packages/sky_design_system/
mv pubspec.yaml packages/sky_design_system/
mv README.md packages/sky_design_system/
mv CHANGELOG.md packages/sky_design_system/
mv analysis_options.yaml packages/sky_design_system/
```

- [ ] **Step 2: Update paths in packages/sky_design_system/pubspec.yaml if necessary**
(Existing code might have relative paths that need updating).

- [ ] **Step 3: Run melos bootstrap**
Run: `dart pub global activate melos && melos bootstrap`
Expected: Successfully links the design system package.

- [ ] **Step 4: Commit**
```bash
git add packages/sky_design_system
git commit -m "refactor: move design system to packages/sky_design_system"
```

---

### Task 3: Create sky_lints Package

**Files:**
- Create: `packages/sky_lints/pubspec.yaml`
- Create: `packages/sky_lints/lib/analysis_options.yaml`

- [ ] **Step 1: Create sky_lints pubspec.yaml**
```yaml
name: sky_lints
description: Shared lint rules for Sky Core.
version: 0.0.1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  very_good_analysis: ^6.0.0
```

- [ ] **Step 2: Create analysis_options.yaml**
```yaml
include: package:very_good_analysis/analysis_options.yaml
linter:
  rules:
    public_member_api_docs: true
```

- [ ] **Step 3: Update existing design system to use sky_lints**
Modify `packages/sky_design_system/analysis_options.yaml`:
```yaml
include: package:sky_lints/analysis_options.yaml
```

- [ ] **Step 4: Commit**
```bash
git add packages/sky_lints
git commit -m "feat: add sky_lints package"
```

---

### Task 4: Create sky_error Package

**Files:**
- Create: `packages/sky_error/pubspec.yaml`
- Create: `packages/sky_error/lib/sky_error.dart`

- [ ] **Step 1: Create sky_error pubspec.yaml**
```yaml
name: sky_error
description: Result and Failure types for Sky Core.
version: 0.0.1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  fpdart: ^0.6.0
  equatable: ^2.0.5
```

- [ ] **Step 2: Implement Failure classes**
```dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
```

- [ ] **Step 3: Commit**
```bash
git add packages/sky_error
git commit -m "feat: add sky_error package with fpdart"
```

---

### Task 5: Create sky_storage (Interfaces)

**Files:**
- Create: `packages/sky_storage/pubspec.yaml`
- Create: `packages/sky_storage/lib/sky_storage.dart`

- [ ] **Step 1: Create sky_storage pubspec.yaml**
```yaml
name: sky_storage
description: Abstract storage interfaces for Sky Core.
version: 0.0.1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  sky_error:
    path: ../sky_error
```

- [ ] **Step 2: Define Storage interfaces**
```dart
import 'package:fpdart/fpdart.dart';
import 'package:sky_error/sky_error.dart';

abstract class SkyStorage {
  Future<Either<Failure, void>> write(String key, String value);
  Future<Either<Failure, String?>> read(String key);
  Future<Either<Failure, void>> delete(String key);
  Future<Either<Failure, void>> clear();
}
```

- [ ] **Step 3: Commit**
```bash
git add packages/sky_storage
git commit -m "feat: add sky_storage interface package"
```

---

### Task 6: Create sky_network Package

**Files:**
- Create: `packages/sky_network/pubspec.yaml`
- Create: `packages/sky_network/lib/sky_network.dart`

- [ ] **Step 1: Create sky_network pubspec.yaml**
```yaml
name: sky_network
description: Network layer for Sky Core.
version: 0.0.1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  dio: ^5.4.0
  retrofit: ^4.1.0
  sky_error:
    path: ../sky_error
dev_dependencies:
  retrofit_generator: ^8.1.0
  build_runner: ^2.4.8
```

- [ ] **Step 2: Create Base Dio Client with Interceptors**
```dart
import 'dart:io';
import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    ),
  );
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  return dio;
}
```

- [ ] **Step 3: Commit**
```bash
git add packages/sky_network
git commit -m "feat: add sky_network package with dio and retrofit"
```

---

### Task 7: Create sky_storage_isar (Implementation)

**Files:**
- Create: `packages/sky_storage_isar/pubspec.yaml`
- Create: `packages/sky_storage_isar/lib/sky_storage_isar.dart`

- [ ] **Step 1: Create sky_storage_isar pubspec.yaml**
```yaml
name: sky_storage_isar
description: Isar implementation for sky_storage.
version: 0.0.1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  sky_storage:
    path: ../sky_storage
  sky_error:
    path: ../sky_error
dev_dependencies:
  isar_generator: ^3.1.0+1
  build_runner: ^2.4.8
```

- [ ] **Step 2: Implement Isar wrapper for SkyStorage**
```dart
import 'package:isar/isar.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sky_error/sky_error.dart';
import 'package:sky_storage/sky_storage.dart';

class IsarStorage implements SkyStorage {
  final Isar isar;
  IsarStorage(this.isar);

  @override
  Future<Either<Failure, void>> write(String key, String value) async {
    // Concrete Isar implementation
    return right(null);
  }

  @override
  Future<Either<Failure, String?>> read(String key) async {
     // Concrete Isar implementation
     return right(null);
  }
  
  // ... delete and clear
}
```

- [ ] **Step 3: Commit**
```bash
git add packages/sky_storage_isar
git commit -m "feat: add sky_storage_isar implementation package"
```

---

### Task 8: Create sky_di Package

**Files:**
- Create: `packages/sky_di/pubspec.yaml`
- Create: `packages/sky_di/lib/sky_di.dart`

- [ ] **Step 1: Create sky_di pubspec.yaml**
```yaml
name: sky_di
description: Dependency injection setup for Sky Core.
version: 0.0.1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  get_it: ^7.6.7
  injectable: ^2.3.2
dev_dependencies:
  injectable_generator: ^2.4.1
  build_runner: ^2.4.8
```

- [ ] **Step 2: Initialize GetIt and Injectable**
```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
```

- [ ] **Step 3: Commit**
```bash
git add packages/sky_di
git commit -m "feat: add sky_di package with get_it and injectable"
```
