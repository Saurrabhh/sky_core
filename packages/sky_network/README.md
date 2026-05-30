# sky_network

A robust, type-safe, and fully decoupled remote network client wrapper around `Dio` and connectivity detection. It provides automatic error interception, standardized logging, and clean functional error returns.

## Features

* **Advanced Error Interceptors:** Translates HTTP response codes and network failures (timeouts, dns resolution issues) into core domain `Failure` abstractions automatically.
* **Connectivity Aware:** Integrated offline/online detection systems preventing unnecessary network calls when the device is disconnected.
* **Logging Pipeline:** Ready-made, highly structured `pretty_dio_logger` support for debugging network requests in staging environments.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_network: ^1.0.0
```

## Usage

Instantiate and configure the type-safe client:

```dart
import 'package:sky_network/sky_network.dart';

void main() async {
  // 1. Initialize Network Client
  final networkClient = SkyNetworkClient(
    baseUrl: 'https://api.example.com/',
    interceptors: [
      PrettyDioLogger(requestHeader: true, requestBody: true),
    ],
  );

  // 2. Perform safe GET requests returning functional results
  final response = await networkClient.get<Map<String, dynamic>>('users/1');
  
  response.fold(
    (failure) => print('Failed with message: ${failure.message}'),
    (data) => print('Successfully retrieved user: $data'),
  );
}
```
