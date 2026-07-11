---
name: sky-telemetry-firebase
description: Firebase Analytics and Crashlytics registry mapping
---

# sky_telemetry_firebase Guidelines

Bridges the `sky_telemetry` abstractions to Firebase Analytics and Crashlytics.

## Guidelines & Checklists

### 1. Initialization
* Register Firebase implementations during app startup (before any analytics or crash calls):
  ```dart
  // In main.dart or app initializer
  AppLoggerRegistry.instance.register(FirebaseCrashlyticsLogger());
  AnalyticsRegistry.instance.register(FirebaseAnalyticsImpl());
  CrashlyticsRegistry.instance.register(FirebaseCrashlyticsImpl());
  ```

### 2. Analytics Events
* All events must be logged through the `Analytics` interface — never call `FirebaseAnalytics.instance.logEvent(...)` directly.

### 3. Crashlytics
* Non-fatal errors and breadcrumbs must be submitted via the `Crashlytics` interface — never call `FirebaseCrashlytics.instance.recordError(...)` directly.
* This ensures a clean swap-out if the crash reporting provider changes.
