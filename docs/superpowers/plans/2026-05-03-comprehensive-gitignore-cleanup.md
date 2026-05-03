# Comprehensive .gitignore Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Clean up the repository by standardizing `.gitignore` files, adding missing patterns, and untracking files that should be ignored but are currently tracked.

**Architecture:** Use a hierarchical `.gitignore` strategy. The root `.gitignore` handles global patterns, while package-level `.gitignore` files handle package-specific patterns (like ignoring `pubspec.lock` in libraries but keeping it in apps).

**Tech Stack:** Bash, Git, Dart/Flutter

---

### Task 1: Update Root .gitignore

**Files:**
- Modify: `.gitignore`

- [ ] **Step 1: Update the root `.gitignore` with comprehensive patterns**

```gitignore
# https://dart.dev/guides/libraries/private-files
.dart_tool/
.packages
.pub/
.pub-cache/
build/

# Melos
.melos/
pubspec_overrides.yaml

# Flutter/Dart
.flutter-plugins
.flutter-plugins-dependencies
.metadata

# IDE files
.idea/
*.iml
*.iws
*.ipr
.vscode/

# Logs
*.log

# OS files
.DS_Store
```

- [ ] **Step 2: Commit root .gitignore**

```bash
git add .gitignore
git commit -m "chore: update root .gitignore with comprehensive patterns"
```

### Task 2: Standardize Package-level .gitignore Files

**Files:**
- Modify: `packages/sky_design_system/.gitignore`
- Modify: `packages/sky_di/.gitignore`
- Modify: `packages/sky_error/.gitignore`
- Modify: `packages/sky_lints/.gitignore`
- Modify: `packages/sky_network/.gitignore`
- Modify: `packages/sky_storage/.gitignore`
- Modify: `packages/sky_storage_isar/.gitignore`

- [ ] **Step 1: Create a template for library packages**

```bash
cat << 'EOF' > library.gitignore
# https://dart.dev/guides/libraries/private-files
.dart_tool/

# Avoid committing pubspec.lock for library packages
pubspec.lock

# Melos overrides
pubspec_overrides.yaml

# Flutter/Dart artifacts
.flutter-plugins
.flutter-plugins-dependencies
.metadata

doc/api/
.buildlog/
build/

# IDE files
*.iml
.idea/
EOF
```

- [ ] **Step 2: Apply the template to all library packages**

```bash
cp library.gitignore packages/sky_design_system/.gitignore
cp library.gitignore packages/sky_di/.gitignore
cp library.gitignore packages/sky_error/.gitignore
cp library.gitignore packages/sky_lints/.gitignore
cp library.gitignore packages/sky_network/.gitignore
cp library.gitignore packages/sky_storage/.gitignore
cp library.gitignore packages/sky_storage_isar/.gitignore
rm library.gitignore
```

- [ ] **Step 3: Commit package-level .gitignore files**

```bash
git add packages/**/.gitignore
git commit -m "chore: standardize package-level .gitignore files for libraries"
```

### Task 3: Untrack Ignored Files

**Files:**
- Modify: Git Index

- [ ] **Step 1: Untrack files that should be ignored**

```bash
# Untrack root files
git rm --cached .flutter-plugins-dependencies
git rm --cached .metadata

# Untrack package-level overrides and locks
git rm --cached **/pubspec_overrides.yaml
git rm --cached **/pubspec.lock

# (Re-add the one we want to keep)
git add packages/sky_design_system/example/pubspec.lock
```

- [ ] **Step 2: Commit untracked files**

```bash
git commit -m "chore: untrack files that are now ignored"
```

### Task 4: Final Validation

- [ ] **Step 1: Verify no unwanted files are untracked but present**

Run: `git status`
Expected: "nothing to commit, working tree clean"

- [ ] **Step 2: Verify specific files are ignored**

Run: `git check-ignore -v .metadata packages/sky_di/pubspec.lock`
Expected: Output showing the ignore rules.
