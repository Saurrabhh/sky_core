# App Icon Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ensure all components within the design system and its showcase/tests use the standard `AppIcon` component instead of the base Flutter `Icon` widget.

**Architecture:** We will first expand `AppIconSize` to include a `large` (32px) variant to accommodate usages found in the showcase app. Then, we will replace `Icon` usages in `app_button.dart`, showcase components, and tests with `AppIcon`.

**Tech Stack:** Flutter, Dart

---

### Task 1: Expand AppIconSize

**Files:**
- Modify: `packages/sky_design_system/lib/src/components/atoms/app_icon.dart`

- [ ] **Step 1: Write the minimal implementation**

```dart
enum AppIconSize {
  /// 18px icon size
  small(18),

  /// 24px icon size
  medium(24),

  /// 32px icon size
  large(32);

  const AppIconSize(this.value);
  final double value;
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/sky_design_system/lib/src/components/atoms/app_icon.dart
git commit -m "feat(design_system): add large size variant to AppIconSize"
```

### Task 2: Migrate app_button.dart

**Files:**
- Modify: `packages/sky_design_system/lib/src/components/atoms/app_button.dart`

- [ ] **Step 1: Write the minimal implementation**

Replace `Icon(iconData)` with `AppIcon(iconData!)` in the FAB variant.
Replace `Icon(iconData, size: 18)` with `AppIcon(iconData, size: AppIconSize.small)`.
Ensure `app_icon.dart` is imported.

- [ ] **Step 2: Commit**

```bash
git add packages/sky_design_system/lib/src/components/atoms/app_button.dart
git commit -m "refactor(design_system): use AppIcon in AppButton"
```

### Task 3: Migrate showcase components

**Files:**
- Modify: `apps/sky_showcase/lib/components/atoms/indicators_use_cases.dart`
- Modify: `apps/sky_showcase/lib/components/molecules/feedback_molecules_use_cases.dart`
- Modify: `apps/sky_showcase/lib/components/organisms/navigation_use_cases.dart`

- [ ] **Step 1: Write the minimal implementation**

Replace `Icon(Icons.notifications, size: 32)` with `AppIcon(Icons.notifications, size: AppIconSize.large)`.
Replace `Icon(Icons.info, size: 32)` with `AppIcon(Icons.info, size: AppIconSize.large)`.
Replace `Icon(Icons.home)` with `AppIcon(Icons.home)`.
Replace `Icon(Icons.search)` with `AppIcon(Icons.search)`.
Replace `Icon(Icons.person)` with `AppIcon(Icons.person)`.

- [ ] **Step 2: Commit**

```bash
git add apps/sky_showcase/lib/components/
git commit -m "refactor(showcase): use AppIcon in showcase examples"
```

### Task 4: Migrate test cases

**Files:**
- Modify: `packages/sky_design_system/test/sky_design_system_test.dart`

- [ ] **Step 1: Write the minimal implementation**

Replace `Icon(Icons.mail)` with `AppIcon(Icons.mail)`.
Replace `Icon(Icons.notifications)` with `AppIcon(Icons.notifications)`.
Replace `Icon(Icons.settings)` with `AppIcon(Icons.settings)`.
Replace `Icon(Icons.info)` with `AppIcon(Icons.info)`.
Replace `Icon(Icons.home)` with `AppIcon(Icons.home)`.

- [ ] **Step 2: Run test to verify it passes**

Run tests in the `sky_design_system` package.

- [ ] **Step 3: Commit**

```bash
git add packages/sky_design_system/test/sky_design_system_test.dart
git commit -m "test(design_system): migrate tests to use AppIcon"
```