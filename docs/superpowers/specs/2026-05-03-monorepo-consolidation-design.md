# Sky Core Monorepo Consolidation Design

**Goal:** Correct the project structure by consolidating all micro-packages into a root-level `packages/` directory and properly configuring Melos at the workspace root.

**Context:** The current workspace is nested inside `sky_design_system/`, and redundant empty packages exist at the root.

## Proposed Structure

```text
/
├── melos.yaml                  # Workspace configuration
├── pubspec.yaml                # Workspace pubspec
├── .gitignore                  # Root gitignore
└── packages/
    ├── sky_lints/              # Shared linting rules
    ├── sky_error/              # Result/Either types and Failure classes
    ├── sky_storage/            # Abstract storage interfaces
    ├── sky_storage_isar/       # Isar implementation of sky_storage
    ├── sky_network/            # Retrofit/Dio network layer
    ├── sky_design_system/      # UI components and themes
    └── sky_di/                 # Dependency Injection setup
```

## Migration Plan

1.  **Preparation:**
    *   Create a root-level `packages/` directory.
2.  **Package Migration:**
    *   Move all packages from `sky_design_system/packages/*` to `/packages/`.
    *   Delete empty placeholder directories at the root (`sky_di`, `sky_error`, etc.).
3.  **Workspace Configuration:**
    *   Move `sky_design_system/melos.yaml` and `sky_design_system/pubspec.yaml` to the root.
    *   Update root `melos.yaml` name to `sky_core`.
    *   Verify and merge `.gitignore` files into a single root-level `.gitignore`.
4.  **Verification:**
    *   Run `melos bootstrap` at the root.
    *   Run `melos run analyze` to ensure all paths are correct.

## Persistence & Commits
*   Changes will be committed in logical steps (Initialization, Migration, Configuration, Cleanup).
*   `.gitignore` will be verified to include standard Flutter/Dart ignores plus `.melos/`.

## Success Criteria
*   A flat `packages/` directory containing all 7 core packages.
*   Melos successfully bootstraps from the root.
*   No redundant or empty directories remain.
