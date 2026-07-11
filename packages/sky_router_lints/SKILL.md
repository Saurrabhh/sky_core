---
name: sky-router-lints
description: Static checks for route path definitions in sky_router
---

# sky_router_lints Guidelines

Route-specific lint rules to enforce consistent navigation patterns.

## Guidelines & Checklists

### 1. Route Path Constants
* All route paths must be declared as `static const String` values inside a `RoutePaths` class.
* Never use raw string literals for navigation — always reference the constant:
  ```dart
  // ❌ Avoid raw strings
  RouteHandler.go(context, '/dashboard');

  //  Use RoutePaths constants
  RouteHandler.go(context, RoutePaths.dashboard);
  ```

### 2. Handler Coverage
* The linter checks that every declared route path constant has an associated layout/page handler registered in the router configuration.

### 3. Run Lint Check
* Run `dart analyze` after any routing changes to verify path coverage and naming consistency.
