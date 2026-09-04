# sky_media_kit

A robust media and file system toolkit for Sky Core applications. This package provides interfaces and wrappers for picking files, capturing media via the system camera, selecting images from the gallery, and managing local filesystem persistence.

## Features

* **File Selection:** Pick single or multiple files with extension filters and byte size limits.
* **Image & Photo Picking:** Capture photos via camera or pick from gallery with quality, dimension, and size limits.
* **File System Persistence:** Helpers to write, read, and delete files in temporary or document folders.
* **Domain Failure Hierarchy:** Specific failure types (`MediaPickerCancelledFailure`, `FileSizeExceededFailure`, `InvalidFileTypeFailure`, `MediaPermissionDeniedFailure`, `FileStorageFailure`, `CameraCaptureFailure`).

## Getting Started / Installation

Add `sky_media_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  sky_media_kit: ^0.1.0
```

### Platform Permissions

#### iOS

Add the following to your application's `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs gallery access to select files.</string>
```

#### Android

Add the following to your application's `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

## Usage

### Picking an Image with Size Limit & Specific Failure Handling

```dart
import 'package:sky_media_kit/sky_media_kit.dart';

final imagePickerService = ImagePickerServiceImpl();

// Pick an image from gallery with 5MB maximum size limit
final EitherFailure<XFile> result = await imagePickerService.pickImage(
  source: ImageSource.gallery,
  maxSizeBytes: 5 * 1024 * 1024,
);

result.fold(
  (failure) => switch (failure) {
    MediaPickerCancelledFailure() => print('User cancelled selection.'),
    FileSizeExceededFailure(:final actualSizeBytes, :final maxSizeBytes) =>
      print('Image too large ($actualSizeBytes > $maxSizeBytes bytes).'),
    MediaPermissionDeniedFailure(:final permission) =>
      print('Permission denied for $permission.'),
    _ => print('Error: ${failure.message}'),
  },
  (image) => print('Picked image path: ${image.path}'),
);
```

### Saving a File

```dart
import 'dart:typed_data';
import 'package:sky_media_kit/sky_media_kit.dart';

final fileStorageService = FileStorageServiceImpl();

final saveResult = await fileStorageService.saveFile(
  fileName: 'example.txt',
  bytes: Uint8List.fromList('Hello World'.codeUnits),
  allowedFileTypes: [MimeType.txt],
);

saveResult.fold(
  (failure) => print('Error saving file: ${failure.message}'),
  (savedPath) => print('Saved file to: $savedPath'),
);
```

## Additional information

For bug reports, feature requests, or queries, please open an issue in the main GitHub repository.
