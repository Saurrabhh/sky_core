# sky_telemetry_firebase

Firebase Analytics and Firebase Crashlytics implementations of `AppAnalytics` and `AppCrashReporter` contracts from `sky_telemetry`.

## Features

* **FirebaseAnalyticsTracker**: Concrete implementation of `AppAnalytics` to log custom events, screen transitions, and user profile properties.
* **FirebaseCrashlyticsReporter**: Concrete implementation of `AppCrashReporter` to record fatal/non-fatal errors, attach context, and record structured breadcrumbs.

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_telemetry_firebase: ^1.0.0
```

## Usage

Register the concrete engines in your application setup (e.g., in `main.dart` after initializing Firebase):

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:sky_telemetry/sky_telemetry.dart';
import 'package:sky_telemetry_firebase/sky_telemetry_firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Register trackers
  AppAnalyticsRegistry.instance.registerProvider(
    FirebaseAnalyticsTracker(analytics: FirebaseAnalytics.instance),
  );

  AppCrashReporting.instance.registerReporter(
    FirebaseCrashlyticsReporter(crashlytics: FirebaseCrashlytics.instance),
  );
}
```
