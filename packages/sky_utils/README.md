# sky_utils

A rich suite of reusable, high-performance Dart and Flutter utility extensions, string transformations, async helpers, and concurrency locks to supercharge productivity and write clean, expressive code.

## Features

* **Expressive Extensions:** Type-safe extensions on `BuildContext`, `String`, `DateTime`, and collections to eliminate boilerplate code.
* **Concurrency Controls:** Simple, reliable `Mutex` and `Semaphore` locks to coordinate async operations and avoid race conditions.
* **Case Helpers:** Fast string case converters wrapping `recase` to format text into camelCase, snake_case, PascalCase, and more.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_utils: ^1.0.0
```

## Usage

Leverage the extensions and lock primitives:

```dart
import 'package:sky_utils/sky_utils.dart';

void main() async {
  // 1. Recase values elegantly
  final label = "sky core framework".toPascalCase(); // SkyCoreFramework
  print(label);

  // 2. Protect critical sections with Mutex
  final mutex = Mutex();
  
  await mutex.protect(() async {
    // Critical async database/network operation
    print('Safely executing within Mutex context.');
  });
}
```
