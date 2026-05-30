# sky_telemetry

A pure Dart telemetry, logging, and crash-reporting abstraction package. It establishes unified pillars for structured logs, event tracking, performance tracing, and integrates directly with a lightweight local logger implementation.

## Features

* **Logger Pillars:** Standardized levels (verbose, debug, info, warning, error, wtf) to structure logs.
* **Unified Metrics Pipeline:** Interoperable interface for registering multiple analytics exporters (e.g. Firebase, Sentry, local consoles).
* **Crash Abstractions:** Easy-to-hook catch handlers for unhandled isolate errors.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_telemetry: ^1.0.0
```

## Usage

Setup and configure the global logging services:

```dart
import 'package:sky_telemetry/sky_telemetry.dart';

void main() {
  // 1. Configure the telemetry logging engine
  SkyTelemetry.initialize(
    exporters: [
      ConsoleExporter(minLevel: LogLevel.debug),
    ],
  );

  // 2. Log events and exceptions cleanly
  SkyTelemetry.logInfo('Application successfully initialized.');
  
  try {
    throw Exception('Out of memory');
  } catch (e, stackTrace) {
    SkyTelemetry.logError(
      'An unexpected error occurred during startup.',
      error: e,
      stackTrace: stackTrace,
    );
  }
}
```
