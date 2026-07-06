# sky_devtools

A draggable, resizable, overlay-based developer diagnostics tool and log viewer for Flutter
applications. Integrates seamlessly with `sky_telemetry` and `talker` to provide live application
insights directly on top of your running app — without navigating away.

---

## Features

### 🪟 Floating Overlay Panel
- **Draggable bubble** — Tap to expand into the full diagnostics panel.
- **Picture-in-Picture (PiP) ticker** — A compact log stream shown while you continue using the app.
- **Full-screen mode** — Toggle to expand the panel to fill the entire screen.
- **Resizable panel** — Drag from any **corner** or **edge** (left, right, top, bottom) to resize the floating window to any dimension.
- **SafeArea aware** — The overlay respects notches, status bars, and system navigation areas.

### 📋 Logs Dashboard

Five category filter chips let you view exactly the logs you need:

| Tab | Content |
|------|---------|
| **ALL** | Every log event from the full talker history |
| **NETWORK** | HTTP requests and responses from `StructuredNetworkLog` |
| **BLOC** | State transition events from `StructuredBlocLog` |
| **CONSOLE** | General print, info, warning, and debug logs (excludes errors and network/bloc) |
| **ERRORS** | Uncaught exceptions, Flutter framework errors, platform crashes, and logs tagged as `error` or `critical` |

- Full-text search filter with clear button.
- One-tap to clear the entire log history.

### 🌐 Network Inspector

Tap any network log to open an inline detail view with four sub-tabs:

- **General** — Method, URL, status code, timing, and content type with a one-tap cURL copy.
- **Headers** — Request and Response headers displayed in an interactive JSON tree with copy-all buttons.
  - Single-element list header values are automatically flattened (e.g. `["application/json"]` → `"application/json"`).
- **Request Body** — Formatted JSON editor view with line numbers and code folding.
- **Response Body** — Formatted JSON editor view with line numbers and code folding.

### 🗂️ JSON Tree Editor

All JSON data is rendered in an **Android Studio-style** code editor with:

- **Line numbers** on the left.
- **Collapse/Expand** buttons for objects and arrays — click the `▶` / `▼` icon to fold entire blocks.
- **Syntax highlighting** — keys in orange, strings in green, numbers in blue.
- **Long-press context menu** — opens a native popup at the exact touch position with options:
  - Copy Key
  - Copy Value
  - Copy Key-Value Pair
  - Copy Full Line Text
  - Copy JSON Path
  - Collapse / Expand Block
- **Copy Full Body** button at the top of each section.
- **Horizontal scroll** for long lines — content exceeding the width scrolls independently without switching tabs.

### 💥 Crash & Error Logging

Wire up Flutter's two error hooks in `main.dart` to automatically capture all uncaught errors and
route them into the **ERRORS** tab:

```dart
// Synchronous Flutter framework errors (layout overflows, gesture errors, etc.)
FlutterError.onError = (details) {
  FlutterError.presentError(details);
  try {
    getIt<AppLogger>().error(
      details.exceptionAsString(),
      error: details.exception,
      stackTrace: details.stack,
    );
  } on Object catch (_) {}
};

// Asynchronous platform/zone errors (unhandled Futures, native bridge errors, etc.)
WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
  try {
    getIt<AppLogger>().error(
      'Uncaught asynchronous error',
      error: error,
      stackTrace: stack,
    );
  } on Object catch (_) {}
  return true;
};
```

### ⚙️ Actions Tab
- **Environment Switcher** — Toggle between backend base URLs at runtime.
- **Cache Controller** — Trigger custom cache-clearing callbacks on demand.

### 📊 System Info Tab
- Screen resolution and device pixel ratio.
- Platform and OS version.
- Locale and orientation.
- Memory pressure and diagnostics metadata.

---

## Getting Started

### 1. Register the Logger in Dependency Injection

Wrap `Talker` inside `TalkerAppLogger` and register it as an implementation of `AppLogger`:

```dart
import 'package:sky_devtools/sky_devtools.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    useConsoleLogs: false,
  ),
);

final devLogger = TalkerAppLogger(talker);
AppLoggerRegistry.instance.register(devLogger);
```

### 2. Add the Overlay to your MaterialApp

Wrap your app's main content with `DevToolsOverlay` using the `builder` parameter. Only activate it
in development environments:

```dart
import 'package:flutter/material.dart';
import 'package:sky_devtools/sky_devtools.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      builder: (context, child) {
        if (isDevEnvironment) {
          final talkerLogger = AppLoggerRegistry.instance.loggers
              .whereType<TalkerAppLogger>()
              .firstOrNull;

          if (talkerLogger != null) {
            return DevToolsOverlay(
              talkerLogger: talkerLogger,
              options: DevToolsOptions(
                navigatorKey: rootNavigatorKey,
                environments: const [
                  DevEnvironment(name: 'Dev', baseUrl: 'https://api-dev.example.com'),
                  DevEnvironment(name: 'Staging', baseUrl: 'https://api-staging.example.com'),
                ],
                currentEnvironment: const DevEnvironment(
                  name: 'Dev',
                  baseUrl: 'https://api-dev.example.com',
                ),
                onEnvironmentChanged: (env) {
                  // Update your Dio/http client base URL here
                },
                onClearCache: () async {
                  // Reset your Hive boxes or SharedPreferences here
                },
              ),
              child: child!,
            );
          }
        }
        return child!;
      },
      home: const MyHomePage(),
    );
  }
}
```

### 3. Wire up Crash & Error Logging

Add the two error hooks in your `mainCommon` function **after** `configureDependencies` but **before** `runApp`:

```dart
Future<void> mainCommon(Env env) async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(env);

  // Synchronous framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    try {
      getIt<AppLogger>().error(
        details.exceptionAsString(),
        error: details.exception,
        stackTrace: details.stack,
      );
    } on Object catch (_) {}
  };

  // Asynchronous zone errors
  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    try {
      getIt<AppLogger>().error(
        'Uncaught asynchronous error',
        error: error,
        stackTrace: stack,
      );
    } on Object catch (_) {}
    return true;
  };

  runApp(const MyApp());
}
```

---

## Widget Reference

### `DevToolsOverlay`

| Property | Type | Description |
|----------|------|-------------|
| `talkerLogger` | `TalkerAppLogger` | The talker logger instance to stream logs from |
| `options` | `DevToolsOptions` | Configuration for environments, cache actions, and navigator key |
| `child` | `Widget` | Your application widget tree |

### `DevToolsOptions`

| Property | Type | Description |
|----------|------|-------------|
| `navigatorKey` | `GlobalKey<NavigatorState>?` | Root navigator key (needed for dialog routing) |
| `environments` | `List<DevEnvironment>` | List of available backend environments |
| `currentEnvironment` | `DevEnvironment?` | The initially selected environment |
| `onEnvironmentChanged` | `void Function(DevEnvironment)?` | Called when the user switches environments |
| `onClearCache` | `Future<void> Function()?` | Called when the user taps "Clear Cache" |

---

## Additional Information

For issues, feature requests, or contribution guidelines, please open a ticket in the main
`sky_core` monorepo repository.
