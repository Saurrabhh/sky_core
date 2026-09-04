---
name: sky-media-kit
description: Guidelines on using and extending the sky_media_kit package
---

# sky_media_kit Guidelines

This package provides interfaces and wrappers for device media operations (camera, image picking, file picking) and local file storage using standard cross-platform `XFile` representation.

## Guidelines & Checklists

### 1. Unified Cross-Platform File Abstraction & Non-Nullable Returns
* Use `XFile` (from `package:cross_file/cross_file.dart`) as the unified file abstraction for all media and file selection returns, as it is highly robust across multiple platforms (mobile, web, and desktop).
* Export `package:cross_file/cross_file.dart` from the main barrel file so clients can access the `XFile` type without manual external imports.
* Selection APIs return non-nullable `FutureEitherFailure<XFile>` or `FutureEitherFailure<List<XFile>>`.

### 2. Service Implementation Naming
* Services must have an abstract interface class (e.g., `ImagePickerService`) and a concrete implementation class prefixed with the same name and postfixed with `Impl` (e.g., `ImagePickerServiceImpl`).

### 3. Domain Failures & Error Handling
* All services return `FutureEitherFailure<T>` using exhaustive `sealed class` hierarchies defined in `src/failures/media_failures.dart`:
  - `FilePickerFailure` (sealed):
    - `MediaPickerCancelledFailure`: Returned when a user dismisses a picker or does not select a file/image.
    - `FileSizeExceededFailure`: Returned when a selected file exceeds `maxSizeBytes`.
    - `InvalidFileTypeFailure`: Returned when a selected file's type is not in `allowedFileTypes`.
    - `MediaPermissionDeniedFailure`: Returned when camera, gallery, or storage permissions are denied.
    - `CameraCaptureFailure`: Returned on camera device or capture initialization errors.
    - `UnknownFilePickerFailure`: Returned on unexpected picker errors.
  - `FileStorageFailure` (sealed):
    - `FileStorageCancelledFailure`: Returned when a save dialog is cancelled.
    - `FileStoragePermissionDeniedFailure`: Returned when storage permission is denied.
    - `FileStorageIOFailure`: Returned on filesystem write/read/directory errors.
    - `UnknownFileStorageFailure`: Returned on unexpected storage errors.

### 4. File Storage Service
* Use `FileStorageService.saveFile` to prompt the system save dialog and save binary data using `FilePicker.saveFile`, returning `FutureEitherFailure<String>`.
* Use `FileStorageService.deleteFile(filePath)` for filesystem cleanup.
* Use `FileStorageService.getTemporaryDirectory()` and `FileStorageService.getDocumentsDirectory()` to resolve device directories for local storage paths.

### 5. Custom Camera (Future Expansion)
* The placeholder directory `lib/src/camera` is reserved for camera-feed custom views (e.g. viewfinder widget overlays). Do not mix camera view widgets with the standard image-picking logic.

### 6. File Filtering & Size Validation
* Always filter file picking options using the `MimeType` enum instead of raw strings.
* Convert input file names/paths to `MimeType` using `MimeType.fromFileNameOrPath()` or `MimeType.fromExtension()`.
* Compare against `Set<MimeType>` directly via `allowedFileTypes` rather than raw string sets. Return `InvalidFileTypeFailure` if a mismatch is detected.
* Support `maxSizeBytes` filtering on pickers, returning `FileSizeExceededFailure` if a file is too large.
