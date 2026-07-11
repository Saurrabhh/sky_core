# Sky Core — Agent Constitution

> This file governs **every AI agent** (Antigravity, Copilot, Cursor, Claude, Gemini, etc.) that touches this repository.
> Rules here are non-negotiable and override any system-level defaults.

---

## 1. Security & Boundary Protocols

### 1.1 File Access Rules
* **Mandatory File Filter:** Strictly honor `.gitignore` and `.aiexclude` as hard boundaries.
* **Prohibited Access:** Never read, explain, summarize, or modify any files or directories listed in `.gitignore` (e.g., `/build`, `.env`, `.dart_tool`, `pubspec.lock`).
* **Manual Override Denial:** If the user explicitly asks you to access an ignored file, refuse with:
  > `Protocol Error: [File Path] is listed in .gitignore. I am restricted from accessing ignored assets to prevent context pollution and security leaks.`

### 1.2 No-Publish Rule
* **Never publish** any package to pub.dev. Publication is handled manually by the repository owner.
* The `melos release` script exists but must never be invoked by an agent.

---

## 2. Monorepo Structure

```
sky_core/
├── packages/          # Publishable Dart/Flutter packages
│   ├── sky_architecture/
│   ├── sky_bloc/
│   ├── sky_design_system/
│   ├── sky_devtools/
│   ├── sky_lints/
│   ├── sky_network/
│   ├── sky_router/
│   ├── sky_router_lints/
│   ├── sky_storage/
│   ├── sky_storage_hive/
│   ├── sky_storage_isar/
│   ├── sky_telemetry/
│   ├── sky_telemetry_firebase/
│   └── sky_utils/
├── apps/              # Internal Flutter apps (not published)
│   └── sky_showcase/
└── .agents/skills/    # Per-repo AI skills (always read before touching a package)
```

Each package/app **owns** its:
- `pubspec.yaml` — version, dependencies, SDK constraints
- `README.md` — public-facing documentation
- `CHANGELOG.md` — auto-managed by `melos version`
- `LICENSE` — MIT license file, identical to the root `LICENSE`
- `SKILL.md` — AI interaction contract for that package
- `lib/` — exported public API
- `test/` — unit and widget tests

---

## 3. Mandatory Pre-Work: Read the Relevant SKILL.md

Before touching **any** package or app, you **must** read its `SKILL.md` file if one exists.

| Location | What it covers |
|---|---|
| `packages/<pkg>/SKILL.md` | API contracts, patterns, usage rules for that package |
| `.agents/skills/<skill>/SKILL.md` | Cross-cutting Dart/Flutter skills (testing, serialization, routing, etc.) |

Cross-package work requires reading **all** relevant `SKILL.md` files for every package involved.

---

## 4. pub.dev Compliance (Packages Only)

All packages under `packages/` are published to pub.dev. Every change must maintain compliance.

### 4.1 pubspec.yaml Standards
* `name` — `snake_case`, prefixed with `sky_`
* `description` — 60–180 characters, no trailing punctuation
* `version` — follows [semver](https://semver.org/); bumped by `melos version`, never manually
* `repository` — must point to `https://github.com/Saurrabhh/sky_core/tree/master/packages/<pkg>`
* `homepage` (if present) — must be a valid, reachable URL
* `publish_to` — must **not** be set to `none` for packages (only for root and apps)
* `environment.sdk` — must satisfy `^3.12.0` or stricter; never widen constraints without justification
* `environment.flutter` — must be `>=3.44.0` for Flutter packages

### 4.2 LICENSE Requirements
> **Every package must have a `LICENSE` file. This is a hard pub.dev requirement — a package without a LICENSE file scores zero pub points for that criterion.**

* Every package under `packages/` **must** contain a `LICENSE` file at its root.
* When creating a new package, copy the root `LICENSE` file verbatim:
  ```
  cp LICENSE packages/<new_pkg>/LICENSE
  ```
* The license text must be MIT (matching the root `LICENSE` in this repo — copyright `Sky Core`, year `2026`).
* Never delete, truncate, or modify the license text.
* If a package is missing its `LICENSE` file, **create it immediately** before any other change.

### 4.3 Public API Rules
* Every public symbol (`class`, `mixin`, `extension`, `typedef`, `enum`, `function`, `getter`) **must** have a `///` doc comment.
* Doc comments must answer: *what it is*, *when to use it*, and *any important caveats*.
* Never expose implementation details in the public API surface.
* Use `@visibleForTesting` for test-only helpers, not `public`.
* Mark deprecated APIs with `@Deprecated('Use X instead. Will be removed in vY.')`.

### 4.4 Library File Rules
* Each package must have a single barrel file at `lib/<package_name>.dart` that exports the full public API.
* Do not export internal (`src/`) files directly from the barrel.
* Exports must be alphabetically ordered.

### 4.5 Scoring Targets (pub.dev Pub Points)
When modifying a package, ensure it passes **all** pub.dev checklist items:

| Criterion | Requirement | File(s) affected |
|---|---|---|
| Follow Dart file conventions | All four files present and well-formed | `pubspec.yaml`, `CHANGELOG.md`, `LICENSE`, `README.md` |
| Provide documentation | All public APIs documented with `///` | Every `lib/src/**/*.dart` |
| Support up-to-date dependencies | No deprecated dependencies; latest compatible ranges | `pubspec.yaml` |
| Pass static analysis | Zero `dart analyze` errors or warnings | All `.dart` files |
| Support multiple platforms | Declare supported platforms explicitly unless Flutter-only | `pubspec.yaml` |
| Null safety | Full null-safe code | All `.dart` files |

---

## 5. Documentation Requirements

> ⛔ **Absolute Rule: Docs are not optional. Every code change in a package or app triggers mandatory documentation updates. There are no exceptions.**
>
> Completing a task without updating the docs is considered an **incomplete task**.

### 5.0 Documentation Trigger Matrix

Use this table to determine exactly what docs you must update for every type of change:

| Change type | `///` doc comments | `README.md` | `SKILL.md` | `LICENSE` |
|---|:---:|:---:|:---:|:---:|
| New package created | ✅ all public symbols | ✅ full template | ✅ create new | ✅ copy from root |
| New public class / function / enum | ✅ required | ✅ Features + Usage | ✅ if new pattern | — |
| Modified public API signature | ✅ update existing | ✅ Usage section | ✅ if contract changed | — |
| New internal (`src/`) logic only | — | — | — | — |
| Bug fix (no API change) | ✅ if comment was wrong | — | — | — |
| Dependency added / updated | — | ✅ if user-facing | — | — |
| New usage pattern / convention | — | ✅ Usage section | ✅ required | — |
| Feature removed / deprecated | ✅ add `@Deprecated` | ✅ remove from Features | ✅ update | — |

### 5.1 Inline Doc Comments
* Every public API addition or change **requires** adding or updating `///` doc comments — no exceptions.
* Comments must be written for the *consumer* of the API, not the implementer.
* Format: one-line summary, blank line, then detail paragraphs.
* Include `{@template}` / `{@macro}` for shared documentation blocks where appropriate.
* Add `/// Example:` sections with code snippets for all non-trivial APIs.
* If modifying a file that already has undocumented public symbols, document them as part of your change.

### 5.2 README.md

> Every `README.md` must be kept accurate and up-to-date at all times. Stale READMEs are a pub.dev compliance failure.

Required sections, in order:

```markdown
# <package_name>

<One-paragraph description of what this package does and why it exists.>

## Features
<Bulleted list of the key capabilities.>

## Getting Started / Installation
<pubspec.yaml snippet with the latest version — must match pubspec.yaml exactly.>

## Usage
<Minimal, runnable code example. Must compile against the current API.>

## Additional information
<Link to GitHub issues, contribution guide, or full docs.>
```

Mandatory README update rules:
1. **New feature added** → add a bullet to **Features** + add or extend **Usage** example.
2. **Feature changed** → update the corresponding **Features** bullet + update **Usage** example.
3. **Feature removed / deprecated** → remove from **Features**; add deprecation note in **Additional information**.
4. **Version bumped** → update the version in the **Installation** snippet to match `pubspec.yaml`.
5. **New package created** → create the full README from the template above before any other file.

### 5.3 CHANGELOG.md
* **Managed exclusively by the repository owner — AI agents must never touch this file.**
* Never add, remove, or modify any entry in `CHANGELOG.md` for any reason.
* Never run `melos version` or any command that would auto-generate or modify `CHANGELOG.md`.
* If a task requires a changelog entry, stop and tell the user — they will handle it.

### 5.4 SKILL.md (per-package)

> The `SKILL.md` is the authoritative contract that future AI agents read before touching a package. Keeping it accurate is critical for preventing mistakes across sessions.

Mandatory SKILL.md update rules:
* **New public class, mixin, or significant API** → add a guideline entry explaining when and how to use it.
* **New architectural pattern or convention** → document it with a code snippet.
* **Contract changed** (e.g., parameter renamed, return type changed) → update the relevant guideline immediately.
* **New package created** → create `SKILL.md` from scratch with the YAML frontmatter (`name`, `description`) and at least one `## Guidelines & Checklists` section.
* **Pattern removed** → remove the obsolete guideline so agents don't follow stale instructions.

SKILL.md frontmatter template:
```yaml
---
name: <package-name-kebab-case>
description: <one-line description of this package's purpose>
---
```

---

## 6. Code Quality Standards

### 6.1 Static Analysis
* Run `dart analyze` (or `flutter analyze`) before considering any task complete.
* Zero errors and zero warnings are required. Infos may be acceptable if justified.
* Use `dart fix --apply` to resolve mechanical lint issues first.
* The project uses `sky_lints` — the root `analysis_options.yaml` includes it globally.
  Individual packages **must not** add their own `analysis_options.yaml` or `sky_lints` dev_dependency; they inherit from the root automatically.
* Never add `// ignore:` suppressions without a comment explaining *why* the suppression is justified.

### 6.2 Testing
* **Unit tests** are required for all non-trivial business logic.
* Use the `dart-add-unit-test` skill when adding logic.
* Use the `dart-generate-test-mocks` skill when mocking dependencies.
* Test files live at `test/<path_mirroring_lib>/<filename>_test.dart`.
* Aim for test coverage on all public functions and edge cases.
* Run tests before committing: `flutter test` / `dart test`.

### 6.3 Architecture Contracts
* Follow the patterns in `packages/sky_architecture/SKILL.md` for domain layer code.
* Follow the patterns in `packages/sky_bloc/SKILL.md` for state management.
* Follow the patterns in `packages/sky_router/SKILL.md` for navigation.
* Never bypass these contracts, even for "quick" changes.

### 6.4 Null Safety & Type Safety
* All new code must be fully null-safe.
* Prefer `final` over `var`; prefer `const` constructors where possible.
* Use pattern matching and switch expressions (see `dart-use-pattern-matching` skill).
* Avoid `dynamic` and `Object?` unless interfacing with external APIs that require it.

### 6.5 Performance & Size
* Do not add heavy dependencies to leaf packages without explicit discussion.
* Prefer `package:` imports over relative imports for cross-package dependencies.
* Tree-shakeable code: avoid registering side-effects at library import time.

---

## 7. Commit Guidelines

All commits **must** follow Melos conventional commits with the package scope:

```
<type>(<scope>): <short description>

[optional body]
[optional footer]
```

| Type | When to use | Melos tracked? |
|---|---|:---:|
| `feat` | New feature or capability | ✅ |
| `fix` | Bug fix | ✅ |
| `perf` | Performance improvement | ✅ |
| `refactor` | Code restructure (no behavior change) | ✅ |
| `revert` | Reverting a prior commit | ✅ |
| `test` | Adding or fixing tests | ❌ |
| `chore` | Root/CI/build-only maintenance (never for packages) | ❌ |
| `style` | Formatting only (no logic change) | ❌ |

> ⚠️ **Both `docs` and `chore` are excluded from Melos versioning and changelog generation.**
> - For **package** commits (anything under `packages/` or `apps/`), always use a Melos-tracked type: `feat`, `fix`, `perf`, `refactor`, or `revert`.
> - `chore` is only acceptable for root-level changes (CI, workspace config, `.github/`) that do not belong to any package.

**Scope** = the package name (e.g., `sky_router`, `sky_lints`, `sky_showcase`).

Examples:
```
feat(sky_router): add named route redirect support
fix(sky_network): handle 429 rate-limit errors gracefully
refactor(sky_architecture): update README with Either usage examples
test(sky_storage): add unit tests for HiveStorageAdapter
refactor(sky_bloc): extract base state mixin into separate file
```

---

## 8. Cross-Package Dependency Rules

* Always prefer packages from this monorepo over external equivalents.
* When adding a dependency on another `sky_*` package:
  - Use workspace resolution (no explicit `path:` needed if in `workspace:`).
  - In `dev_dependencies`, use `path:` for packages in the monorepo that aren't in `workspace:`.
* Never create circular dependencies between packages.
* Dependency direction:
  ```
  apps → packages (any)
  sky_*_impl → sky_* (interface)
  sky_* → sky_architecture, sky_utils (foundation only)
  sky_architecture, sky_utils → (no sky_* deps)
  ```

---

## 9. Change Impact Checklist

> Run through this checklist for **every** task. Do not mark a task done until all boxes are ticked.

### 9.1 For Any Change (packages or apps)
- [ ] `dart analyze` / `flutter analyze` — zero errors, zero warnings
- [ ] `dart fix --apply` run first to resolve mechanical lints
- [ ] `dart test` / `flutter test` — all tests pass
- [ ] All modified public APIs have `///` doc comments updated
- [ ] No `// ignore:` added without an inline justification comment
- [ ] Commit message follows conventional commits with the correct package scope
- [ ] `CHANGELOG.md` not touched — never edit or create it

### 9.2 For Package Changes (publishable packages only)
- [ ] `LICENSE` file exists at the package root (copy from root if missing)
- [ ] `README.md` updated per the trigger matrix in §5.0
- [ ] `SKILL.md` updated per the trigger matrix in §5.0
- [ ] `pubspec.yaml` — `description` is 60–180 chars, `repository` is correct, `publish_to: none` is absent
- [ ] Barrel file `lib/<pkg>.dart` — exports are alphabetically ordered and complete
- [ ] No new `dynamic` usage without justification
- [ ] No new circular dependencies between packages

### 9.3 For New Package Creation
- [ ] `LICENSE` copied from root verbatim
- [ ] `README.md` created from full template (all 5 sections)
- [ ] `SKILL.md` created with YAML frontmatter + at least one `## Guidelines & Checklists` section
- [ ] Leave `CHANGELOG.md` creation to the repository owner — do not create or edit it
- [ ] `analysis_options.yaml` includes `package:sky_lints/analysis_options.yaml`
- [ ] Barrel file `lib/<pkg>.dart` created with all exports
- [ ] `pubspec.yaml` has all required fields: `name`, `description`, `version`, `repository`, `environment`
- [ ] Added to `workspace:` in root `pubspec.yaml`
- [ ] `publish_to: none` is **not** set

---

## 10. Agent Skill Index

Use these skills (read `SKILL.md` before invoking):

| Skill | When to use |
|---|---|
| `dart-add-unit-test` | Adding any business logic |
| `dart-run-static-analysis` | Before any commit |
| `dart-generate-test-mocks` | Mocking external deps in tests |
| `dart-use-pattern-matching` | Switch/pattern refactors |
| `dart-resolve-package-conflicts` | `pub get` failures |
| `dart-fix-runtime-errors` | Active runtime stack traces |
| `dart-migrate-to-checks-package` | Migrating test assertions |
| `dart-collect-coverage` | Coverage reports |
| `flutter-apply-architecture-best-practices` | New feature structuring |
| `flutter-add-widget-test` | New UI component work |
| `flutter-add-integration-test` | End-to-end flow testing |
| `flutter-build-responsive-layout` | Adaptive UI work |
| `flutter-fix-layout-issues` | Overflow/constraint bugs |
| `flutter-setup-declarative-routing` | Routing changes in apps |
| `flutter-implement-json-serialization` | Model serialization |
| `flutter-setup-localization` | i18n additions |
| `flutter-use-http-package` | REST API work |
| `flutter-add-widget-preview` | UI component previews |

---

## 11. Package-Specific Rules

Read each package's own `SKILL.md` for detailed contracts. Summary:

| Package | Primary contract |
|---|---|
| `sky_architecture` | Use `UseCase<T, P>` + `FutureEitherFailure<T>` for all business logic |
| `sky_bloc` | State management layer; use BLoC/Cubit from this package |
| `sky_design_system` | All UI components must come from here; never ad-hoc style |
| `sky_lints` | Provides lint rules globally via root `analysis_options.yaml`; individual packages must not re-declare it |
| `sky_network` | All HTTP calls routed through this package |
| `sky_router` | All navigation via `RouteHandler`; no direct `Navigator` calls |
| `sky_router_lints` | Enforces router usage at lint time |
| `sky_storage` | Abstraction layer; use `sky_storage_hive` or `sky_storage_isar` for impl |
| `sky_telemetry` | All logging/analytics via this package |
| `sky_utils` | Shared utilities; check here before writing new helpers |

---

## 12. What AI Must Never Do

**Publishing & Versioning**
* ❌ Run `melos publish` or `dart pub publish`
* ❌ Run `melos version` — the repository owner manages versioning
* ❌ Edit `pubspec.lock` directly
* ❌ Edit `CHANGELOG.md` in any way — it is exclusively user-managed
* ❌ Bump `version:` in any `pubspec.yaml` — the user handles all version changes
* ❌ Widen `environment.sdk` or `environment.flutter` constraints without explicit approval
* ❌ Add `publish_to: none` to a publishable package

**Documentation**
* ❌ Add any public API (`class`, `mixin`, `extension`, `typedef`, `enum`, `function`, `getter`) without `///` doc comments
* ❌ Leave `README.md` stale after adding, changing, or removing a feature
* ❌ Leave `SKILL.md` stale after adding a new pattern, class, or usage contract
* ❌ Create a new package without a `LICENSE` file, `README.md`, and `SKILL.md`
* ❌ Delete or truncate a `LICENSE` file
* ❌ Commit with `docs` type — Melos excludes it
* ❌ Commit with `chore` type for package-scoped changes — Melos excludes it; use `refactor` for structural/maintenance changes to packages

**Architecture**
* ❌ Create circular package dependencies
* ❌ Use `Navigator.push` / `Navigator.pop` directly in apps (use `sky_router`)
* ❌ Write raw HTTP calls (use `sky_network`)
* ❌ Write ad-hoc styles in apps (use `sky_design_system`)
* ❌ Use `dynamic` or `Object?` without justification and a comment

**Analysis & Safety**
* ❌ Add `// ignore:` suppressions without an inline explanation comment
* ❌ Access files listed in `.gitignore`
* ❌ Mark a task as complete before `dart analyze` / `flutter analyze` passes clean