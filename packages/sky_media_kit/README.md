# sky_media_kit

A robust media and file system toolkit for Sky Core applications. This package provides interfaces and wrappers for picking files, capturing media via the system camera, selecting images from the gallery, and managing local filesystem persistence.

## Features

* **Unified Media & File Selection:** Capture photos via camera, select images from gallery, and pick single or multiple files with extension filters and byte size limits via `MediaPickerService`.
* **File System Persistence:** Helpers to write, read, and delete files in temporary or document folders via `FileStorageService`.
* **Domain Failure Hierarchy:** Exhaustive sealed failure hierarchies (`MediaPickerFailure` and `FileStorageFailure`) for compile-time safe pattern matching.

## Getting Started / Installation

Add `sky_media_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  sky_media_kit: ^0.1.0
```

## Permissions & Setup

### Android (Zero Permissions Required)

No manifest declarations or storage/camera permissions are required in `AndroidManifest.xml`. The package operates via Android's Storage Access Framework (SAF) and system picker intents.

---

### iOS

While Android operates via scoped system intents and SAF without manifest keys, iOS requires explicit privacy usage descriptions in `ios/Runner/Info.plist` when accessing hardware or system libraries:

* **`NSCameraUsageDescription` (Required for Camera):** If your application uses `MediaPickerService.pickImage(source: ImageSource.camera)`, you **must** add this key with a user-facing explanation:
  ```xml
  <key>NSCameraUsageDescription</key>
  <string>This app requires camera access to take photos.</string>
  ```
* **`NSPhotoLibraryUsageDescription` (Photo Library Selection):** Depending on the iOS version and underlying picker implementation, declare this key if selecting images or videos from the user's gallery:
  ```xml
  <key>NSPhotoLibraryUsageDescription</key>
  <string>This app requires access to the photo library to select media.</string>
  ```
* **`NSPhotoLibraryAddUsageDescription` (Optional - Saving Media):** Required only if your application saves captured or processed photos directly to the user's photo album/camera roll.

---

### macOS (App Sandbox)

If your Flutter macOS application uses the App Sandbox, add user-selected file read/write entitlements to `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:

```xml
<dict>
    <key>com.apple.security.files.user-selected.read-write</key>
    <true/>
</dict>
```

## Usage

### 1. Picking an Image & Handling Permission Denials

```dart
import 'package:sky_media_kit/sky_media_kit.dart';

final mediaPickerService = MediaPickerServiceImpl();

// Capture an image using the camera with 5MB maximum size limit
final Either<MediaPickerFailure, XFile> result =
    await mediaPickerService.pickImage(
  source: ImageSource.camera,
  maxSizeBytes: 5 * 1024 * 1024,
);

result.fold(
  (failure) => switch (failure) {
    MediaPermissionDeniedFailure(:final permission) =>
      print('Permission denied for $permission. Please grant access in settings.'),
    MediaPickerCancelledFailure() =>
      print('User cancelled camera capture.'),
    FileSizeExceededFailure(:final actualSizeBytes, :final maxSizeBytes) =>
      print('Image too large ($actualSizeBytes > $maxSizeBytes bytes).'),
    CameraCaptureFailure(:final message) =>
      print('Camera capture failed: $message'),
    InvalidFileTypeFailure() =>
      print('Invalid file type.'),
    UnknownMediaFailure(:final message) =>
      print('Error: $message'),
  },
  (image) => print('Captured photo path: ${image.path}'),
);
```

### 2. Picking Files with Type Filtering

```dart
import 'package:sky_media_kit/sky_media_kit.dart';

final mediaPickerService = MediaPickerServiceImpl();

// Pick PDF or Word documents
final Either<MediaPickerFailure, XFile> result =
    await mediaPickerService.pickFile(
  allowedFileTypes: [MimeType.pdf, MimeType.doc],
  maxSizeBytes: 10 * 1024 * 1024, // 10 MB limit
);

result.fold(
  (failure) => switch (failure) {
    MediaPermissionDeniedFailure(:final permission) =>
      print('Storage permission denied: $permission.'),
    InvalidFileTypeFailure(:final actualMimeType, :final allowedFileTypes) =>
      print('Invalid file type: $actualMimeType. Allowed: $allowedFileTypes'),
    MediaPickerCancelledFailure() =>
      print('File selection cancelled.'),
    FileSizeExceededFailure(:final actualSizeBytes) =>
      print('File size exceeded: $actualSizeBytes bytes.'),
    CameraCaptureFailure() =>
      print('Camera error.'),
    UnknownMediaFailure(:final message) =>
      print('File pick error: $message'),
  },
  (file) => print('Picked file: ${file.name} (${file.path})'),
);
```

### 3. Saving a File with System Dialog

```dart
import 'dart:typed_data';
import 'package:sky_media_kit/sky_media_kit.dart';

final fileStorageService = const FileStorageServiceImpl();

final Either<FileStorageFailure, String> saveResult =
    await fileStorageService.saveFile(
  fileName: 'report.pdf',
  bytes: Uint8List.fromList([/* pdf bytes */]),
  allowedFileTypes: [MimeType.pdf],
);

saveResult.fold(
  (failure) => switch (failure) {
    FileStoragePermissionDeniedFailure() =>
      print('Permission denied to save file.'),
    FileStorageCancelledFailure() =>
      print('Save dialog was cancelled by user.'),
    FileStorageIOFailure(:final filePath, :final message) =>
      print('I/O error saving to $filePath: $message'),
    UnknownFileStorageFailure(:final message) =>
      print('Error saving file: $message'),
  },
  (savedPath) => print('Saved file successfully to: $savedPath'),
);
```

## Additional information

For bug reports, feature requests, or queries, please open an issue in the main GitHub repository.
