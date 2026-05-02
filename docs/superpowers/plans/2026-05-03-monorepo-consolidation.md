# Sky Core Monorepo Consolidation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Consolidate all packages into a root-level `packages/` directory and configure Melos at the project root.

**Architecture:** Standard Melos Monorepo with a flat `packages/` directory.

**Tech Stack:** Flutter, Dart, Melos.

---

### Task 1: Migration Preparation

**Files:**
- Create: `packages/`

- [ ] **Step 1: Create the root packages directory**

Run: `mkdir packages`

- [ ] **Step 2: Commit preparation**

Run: `git add packages && git commit -m "chore: prepare packages directory for consolidation"`

---

### Task 2: Move Packages to Root

**Files:**
- Move: `sky_design_system/packages/*` to `packages/`

- [ ] **Step 1: Move packages from nested location to root**

Run: `mv sky_design_system/packages/* packages/`

- [ ] **Step 2: Verify packages are moved**

Run: `ls packages`
Expected: Lists all 7 packages (sky_design_system, sky_di, sky_error, sky_lints, sky_network, sky_storage, sky_storage_isar).

- [ ] **Step 3: Commit migration**

Run: `git add packages && git commit -m "refactor: move all packages to root-level packages directory"`

---

### Task 3: Root Workspace Configuration

**Files:**
- Move: `sky_design_system/melos.yaml` to root
- Move: `sky_design_system/pubspec.yaml` to root

- [ ] **Step 1: Move melos.yaml to root**

Run: `mv sky_design_system/melos.yaml .`

- [ ] **Step 2: Update melos.yaml name**

Modify: `melos.yaml`
```yaml
name: sky_core
packages:
  - packages/**
```

- [ ] **Step 3: Move pubspec.yaml to root**

Run: `mv sky_design_system/pubspec.yaml .`

- [ ] **Step 4: Update root pubspec.yaml**

Modify: `pubspec.yaml`
```yaml
name: sky_core
environment:
  sdk: ^3.11.5
dev_dependencies:
  melos: ^6.0.0
```

- [ ] **Step 5: Commit workspace configuration**

Run: `git add melos.yaml pubspec.yaml && git commit -m "feat: configure melos at project root"`

---

### Task 4: Gitignore and Cleanup

**Files:**
- Modify: `.gitignore`
- Delete: Redundant directories

- [ ] **Step 1: Verify root .gitignore**
Ensure it contains standard Flutter/Dart ignores and `.melos/`.

```text
.dart_tool/
.packages
.pub/
build/
.melos/
melos_sky_core.iml
```

- [ ] **Step 2: Remove empty placeholder directories at root**

Run: `rmdir sky_di, sky_error, sky_network, sky_storage, sky_storage_isar`

- [ ] **Step 3: Remove redundant sky_design_system folder (if empty)**

Run: `rmdir sky_design_system`
*Note: If it still contains files after migration, audit and move them or delete if redundant.*

- [ ] **Step 4: Commit cleanup**

Run: `git add .gitignore && git commit -m "chore: cleanup redundant directories and update gitignore"`

---

### Task 5: Verification

- [ ] **Step 1: Run melos bootstrap**

Run: `melos bootstrap`
Expected: Successful linkage of all packages.

- [ ] **Step 2: Run analysis**

Run: `melos run analyze`
Expected: No errors (after fixing any relative paths if found).

- [ ] **Step 3: Final Commit**

Run: `git add . && git commit -m "chore: final verification and path fixes"`
