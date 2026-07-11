---
name: sky-lints
description: Static analysis rule profiles for the sky_core monorepo
---

# sky_lints Guidelines

Centralized static analysis rule configuration.

## Guidelines & Checklists

### 1. Include in Analysis Options
* All packages must include `sky_lints` in their `analysis_options.yaml`:
  ```yaml
  include: package:sky_lints/analysis_options.yaml
  ```

### 2. Run Analysis Before Commit
* Ensure code is lint-clean before committing by running:
  ```
  dart analyze
  ```
* Use `dart fix --apply` for mechanical lint auto-fixes (import sorting, etc.).

### 3. No Suppressions Without Justification
* Do not use `// ignore:` annotations unless the lint is a known false positive. Always add a comment explaining why the suppression is justified.
