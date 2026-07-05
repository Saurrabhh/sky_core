# sky_router

Reusable, high-performance routing library for Sky Core wrapping `go_router`.

## Features

* **CustomNavigatorObserver**: Auto-observes screen navigation transitions and logs them to telemetry.
* **GoRouter wrapper**: Convenient shell routing and page transit defaults.

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_router: ^1.1.0
```

## Usage

```dart
import 'package:sky_router/sky_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
  ],
  observers: [
    CustomNavigatorObserver(logger: myLogger),
  ],
);
```
