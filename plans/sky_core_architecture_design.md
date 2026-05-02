# Sky Core Architecture Design

## Background & Motivation
The `sky_design_system` project currently houses the foundational UI components and theme logic. To scale development across multiple Flutter applications efficiently, the vision is to evolve this repository into a comprehensive `sky_core` monorepo. This monorepo will provide all foundational elements—UI, networking, local storage, error handling, dependency injection, and linting—enabling fast, consistent, and production-level development based on Clean Architecture principles.

## Scope & Impact
This design encompasses the structural transformation of the repository into a Melos-managed monorepo. It defines the package boundaries, their responsibilities, and the underlying technologies used to implement them. The impact is a highly modular, decoupled architecture where individual applications can consume only the packages they need.

## Proposed Solution
The `sky_core` repository will adopt a "Micro-Package" structure managed by Melos. It will be divided into the following packages within a `packages/` directory:

1. **`sky_lints` (Quality)**
   - **Purpose:** Enforce uniform code quality across all projects.
   - **Implementation:** Provides a shared `analysis_options.yaml` extending `very_good_analysis` for strict, production-ready standards.

2. **`sky_error` / `sky_result` (Foundation)**
   - **Purpose:** Standardized, safe error handling without throwing exceptions across layers.
   - **Implementation:** Utilizes `fpdart` to provide `Either` types and defines base `Failure` classes (e.g., `NetworkFailure`, `CacheFailure`).

3. **`sky_storage` (Infrastructure Interface)**
   - **Purpose:** Pure abstract interfaces for local caching, decoupled from any specific engine.
   - **Implementation:** Defines abstract classes/contracts for key-value and document storage.

4. **`sky_storage_isar` (Infrastructure Implementation)**
   - **Purpose:** Concrete implementation of `sky_storage` using Isar.
   - **Implementation:** Contains Isar schemas, collections, and the concrete repository logic.

5. **`sky_network` (Infrastructure Implementation)**
   - **Purpose:** Standardized network communication.
   - **Implementation:** Uses Retrofit for API definition and Dio as the engine. Includes global interceptors (auth, logging) and error mapping to `sky_error` failures.

6. **`sky_design_system` (UI Layer)**
   - **Purpose:** Visual consistency and theme management.
   - **Implementation:** The existing design system components (Atoms, Molecules, Organisms) and Material 3 theme configuration.

7. **`sky_di` (Dependency Injection)**
   - **Purpose:** Centralized wiring for the monorepo.
   - **Implementation:** Utilizes `get_it` and `injectable` to allow features to register their dependencies seamlessly.

## Alternatives Considered
- **All-in-One Infra Package:** Rejected because it forces apps to inherit dependencies they might not need (e.g., pulling in Isar even if an app only needs networking).
- **Throwing Exceptions for Errors:** Rejected in favor of the `Either` pattern (`fpdart`) to enforce explicit error handling at compile time, aligning with Clean Architecture.
- **Tightly Coupled Storage:** Rejected in favor of an abstract `sky_storage` package to allow swapping the underlying database (e.g., from Isar to Hive) without affecting the consuming applications.

## Implementation Plan
1. **Monorepo Initialization:**
   - Initialize Melos at the root of the repository.
   - Create a `packages/` directory.
   - Move the existing design system code into `packages/sky_design_system`.
2. **Package Creation (Phase 1 - Foundation & Quality):**
   - Create `sky_lints` and configure `very_good_analysis`.
   - Create `sky_error` and implement base `Failure` classes and `fpdart` integration.
3. **Package Creation (Phase 2 - Infrastructure):**
   - Create `sky_storage` with abstract interfaces.
   - Create `sky_network` with Retrofit/Dio setup.
   - Create `sky_storage_isar` implementing the `sky_storage` interfaces.
4. **Package Creation (Phase 3 - Wiring):**
   - Create `sky_di` and configure Injectable/GetIt.
5. **Integration & Documentation:**
   - Ensure all packages have a standard `README.md`.
   - Setup global `melos run` scripts for code generation, testing, and linting.

## Verification
- Run `melos bootstrap` successfully to link all internal dependencies.
- Ensure `melos run analyze` passes across all packages using the strict `sky_lints` rules.
- Write unit tests for the error mapping in `sky_network` and the concrete storage implementation in `sky_storage_isar`.

## Migration & Rollback
- Since this is a structural transformation of a new/existing repository into a monorepo, the migration involves moving the current `sky_design_system` into a subfolder and updating its paths.
- Rollback involves reverting the git history to the state before the Melos initialization.
