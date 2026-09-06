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

### Platform Permissions & Application Usage

The `sky_media_kit` package interacts with device camera hardware, photo libraries, and filesystem storage through platform channels. Depending on the service method invoked, specific runtime and manifest permissions are required by the host application.

#### Permission Mapping Summary

| Service & Method | Target / Operation | Android Permission | iOS Info.plist Key | macOS Entitlement | Denied Failure Returned |
|---|---|---|---|---|---|
| `MediaPickerService.pickImage(source: ImageSource.camera)` | Capture a photo using the device camera | `android.permission.CAMERA` | `NSCameraUsageDescription` | N/A | `MediaPermissionDeniedFailure(permission: 'camera')` |
| `MediaPickerService.pickImage(source: ImageSource.gallery)` | Pick photo/image from device photo library | `android.permission.READ_MEDIA_IMAGES` (API 33+)<br>`android.permission.READ_EXTERNAL_STORAGE` (API ≤ 32) | `NSPhotoLibraryUsageDescription` | N/A | `MediaPermissionDeniedFailure(permission: 'gallery')` |
| `MediaPickerService.pickFile()` / `pickMultipleFiles()` | Select single or multiple files/documents | `android.permission.READ_MEDIA_IMAGES` / `VIDEO` / `AUDIO` (API 33+)<br>`android.permission.READ_EXTERNAL_STORAGE` (API ≤ 32) | `NSPhotoLibraryUsageDescription` (if picking media from gallery) | `com.apple.security.files.user-selected.read-write` | `MediaPermissionDeniedFailure(permission: 'storage')` |
| `FileStorageService.saveFile()` | Save binary data to storage via system save dialog | `android.permission.WRITE_EXTERNAL_STORAGE` (API ≤ 28) | `NSPhotoLibraryAddUsageDescription` (if saving to photo library) | `com.apple.security.files.user-selected.read-write` | `FileStoragePermissionDeniedFailure()` |

---

#### Android Configuration

Add the required permissions to your application's `android/app/src/main/AndroidManifest.xml` within the `<manifest>` tag:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Camera: Required when using MediaPickerService with ImageSource.camera -->
    <uses-permission android:name="android.permission.CAMERA" />

    <!-- Storage (Android 13+ / API 33+): Granular media permissions for MediaPickerService -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
    <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />

    <!-- Legacy Storage (Android 12 and below / API <= 32): For reading external files/media -->
    <uses-permission
        android:name="android.permission.READ_EXTERNAL_STORAGE"
        android:maxSdkVersion="32" />

    <!-- Legacy Storage (Android 9 and below / API <= 28): For saving files directly to shared external storage -->
    <uses-permission
        android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="28" />

</manifest>
```

##### Where Permissions Are Used on Android
* **Camera (`android.permission.CAMERA`):** Checked when launching `MediaPickerService.pickImage(source: ImageSource.camera)`. If camera hardware permission is denied by the user, the service returns a `Left(MediaPermissionDeniedFailure(permission: 'camera'))`.
* **Media & Images (`android.permission.READ_MEDIA_IMAGES` & `READ_EXTERNAL_STORAGE`):** Checked when accessing the gallery via `MediaPickerService.pickImage(source: ImageSource.gallery)` or picking files via `MediaPickerService.pickFile()`. If denied, returns `Left(MediaPermissionDeniedFailure(permission: 'gallery'))` or `Left(MediaPermissionDeniedFailure(permission: 'storage'))`.
* **File Saving (`android.permission.WRITE_EXTERNAL_STORAGE`):** Required on older Android releases when `FileStorageService.saveFile()` writes to shared storage paths. If denied, returns `Left(FileStoragePermissionDeniedFailure())`.

---

#### iOS Configuration

Add the following usage description keys to your application's `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Camera: Required when taking photos using MediaPickerService (ImageSource.camera) -->
    <key>NSCameraUsageDescription</key>
    <string>This app requires camera access to take photos.</string>

    <!-- Photo Library: Required when picking images/media using MediaPickerService -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app requires access to the photo library to select photos and media.</string>

    <!-- Photo Library Additions: Required if saving captured or generated media to the photo album -->
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>This app requires permission to save photos to your photo library.</string>
</dict>
```

##### Where Permissions Are Used on iOS
* **`NSCameraUsageDescription`:** Triggered when `MediaPickerService.pickImage(source: ImageSource.camera)` displays the system camera view.
* **`NSPhotoLibraryUsageDescription`:** Triggered when `MediaPickerService.pickImage(source: ImageSource.gallery)` presents the iOS photo picker sheet or when media files are accessed via `MediaPickerService.pickFile()`.
* **`NSPhotoLibraryAddUsageDescription`:** Triggered when saving photos or files to the user's camera roll/photo album.

---

#### macOS Configuration (App Sandbox)

If your Flutter macOS application uses the App Sandbox, add file access entitlements to `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:

```xml
<dict>
    <!-- Allows user-selected file open/save dialogs via MediaPickerService and FileStorageService -->
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
final EitherFailure<XFile> result = await mediaPickerService.pickImage(
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
    _ => print('Error: ${failure.message}'),
  },
  (image) => print('Captured photo path: ${image.path}'),
);
```

### 2. Picking Files with Type Filtering

```dart
import 'package:sky_media_kit/sky_media_kit.dart';

final mediaPickerService = MediaPickerServiceImpl();

// Pick PDF or Word documents
final EitherFailure<XFile> result = await mediaPickerService.pickFile(
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
    _ => print('File pick error: ${failure.message}'),
  },
  (file) => print('Picked file: ${file.name} (${file.path})'),
);
```

### 3. Saving a File with System Dialog

```dart
import 'dart:typed_data';
import 'package:sky_media_kit/sky_media_kit.dart';

final fileStorageService = const FileStorageServiceImpl();

final saveResult = await fileStorageService.saveFile(
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
    _ => print('Error saving file: ${failure.message}'),
  },
  (savedPath) => print('Saved file successfully to: $savedPath'),
);
```

## Additional information

For bug reports, feature requests, or queries, please open an issue in the main GitHub repository.
