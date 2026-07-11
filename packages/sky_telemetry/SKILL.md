---
name: sky-telemetry
description: Logging, crash reporting, analytics, and structured diagnostics
---

# sky_telemetry Guidelines

Logging and tracking infrastructure for runtime observability.

## Guidelines & Checklists

### 1. Structured Logging
* All logs must use `AppLogger` instead of `print` or `debugPrint`:
  ```dart
  logger.debug('BLoC Event | ${bloc.runtimeType}');
  logger.info('User signed in');
  logger.warning('Cache miss for key: $key');
  logger.error('Request failed', error: error, stackTrace: stackTrace);
  ```
* Register `AppLogger` implementations through `AppLoggerRegistry.instance`.

### 2. BLoC Observer Integration
* Pipe all BLoC lifecycle events (events, transitions, errors) to `AppLogger` via `AppBlocObserver`:
  ```dart
  Bloc.observer = AppBlocObserver(logger);
  ```

### 3. Analytics
* Track user actions via `Analytics` and `AnalyticsRegistry`.
* Log named events with structured parameter maps — avoid raw string event names scattered across the codebase.

### 4. Crashlytics
* Record non-fatal errors with `Crashlytics.instance.recordError(error, stackTrace)`.
* Add breadcrumb logs via `BreadcrumbLogger` before critical operations to aid crash investigation.
