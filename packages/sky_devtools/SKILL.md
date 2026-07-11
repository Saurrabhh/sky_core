---
name: sky-devtools
description: Debugging overlay, Talker logger registries, and network monitors
---

# sky_devtools Guidelines

Handles debugging overlay controls, Talker logging integrations, and network activity logging.

## Guidelines & Checklists

### 1. Logging Interceptors
* In development-only environments (e.g. `Env.dev`), inject logging interceptors via `StructuredTalkerDioInterceptor` inside the network module:
  ```dart
  if (appConfig.env == Env.dev) {
    final talkerLogger = AppLoggerRegistry.instance.loggers
        .whereType<TalkerAppLogger>()
        .firstOrNull;

    if (talkerLogger != null) {
      interceptors.add(
        StructuredTalkerDioInterceptor(
          talkerLogger.talker,
        ),
      );
    }
  }
  ```

### 2. Logging Registry
* Register standard logging modules via `TalkerAppLogger` to intercept app activity and stack traces.
* `TalkerAppLogger` wraps the underlying `Talker` instance and bridges it to the `AppLogger` interface.

### 3. DevTools UI Components
* Wrap the root widget layout with `DevToolsOverlay` to toggle diagnostic tools in local developer builds.
* Inspect complex payloads dynamically using the `JsonTreeView` panel.
* Use `DevToolsOptions` to configure which debug panels are visible at runtime.
