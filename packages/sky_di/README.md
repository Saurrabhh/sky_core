# sky_di

Dependency injection setup for Sky Core using [get_it](https://pub.dev/packages/get_it) and [injectable](https://pub.dev/packages/injectable).

## Usage

```dart
final getIt = GetIt.instance;

void configureDependencies() => getIt.init();
```
