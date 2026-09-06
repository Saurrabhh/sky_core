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
* Selection APIs return non-nullable `Future<Either<MediaPickerFailure, XFile>>` or `Future<Either<MediaPickerFailure, List<XFile>>>` (or `FutureEitherMediaPicker<T>`).

### 2. Service Implementation Naming
* Services must have an abstract interface class (e.g., `MediaPickerService`) and a concrete implementation class prefixed with the same name and postfixed with `Impl` (e.g., `MediaPickerServiceImpl`).

### 3. Domain Failures & Error Handling
* Services return specific sealed failure hierarchies defined in `src/failures/media_failures.dart`. Instantiate failures using the base sealed class's named factory constructors (subclass constructors are private):
  - `MediaPickerFailure` (sealed):
    - `MediaPickerFailure.cancelled()` (`MediaPickerCancelledFailure`): Returned when a user dismisses a picker or does not select a file/image.
    - `MediaPickerFailure.sizeExceeded()` (`FileSizeExceededFailure`): Returned when a selected file exceeds `maxSizeBytes`.
    - `MediaPickerFailure.invalidType()` (`InvalidFileTypeFailure`): Returned when a selected file's type is not in `allowedFileTypes`.
    - `MediaPickerFailure.permissionDenied()` (`MediaPermissionDeniedFailure`): Returned when camera, gallery, or storage permissions are denied.
    - `MediaPickerFailure.cameraCapture()` (`CameraCaptureFailure`): Returned on camera device or capture initialization errors.
    - `MediaPickerFailure.unknown()` (`UnknownMediaFailure`): Returned on unexpected picker errors.
  - `FileStorageFailure` (sealed):
    - `FileStorageFailure.cancelled()` (`FileStorageCancelledFailure`): Returned when a save dialog is cancelled.
    - `FileStorageFailure.permissionDenied()` (`FileStoragePermissionDeniedFailure`): Returned when storage permission is denied.
    - `FileStorageFailure.io()` (`FileStorageIOFailure`): Returned on filesystem write/read/directory errors.
    - `FileStorageFailure.unknown()` (`UnknownFileStorageFailure`): Returned on unexpected storage errors.

### 4. File Storage Service
* Use `FileStorageService.saveFile` to prompt the system save dialog and save binary data using `FilePicker.saveFile`, returning `Future<Either<FileStorageFailure, String>>` (or `FutureEitherFileStorage<String>`).
* Use `FileStorageService.deleteFile(filePath)` for filesystem cleanup, returning `Future<Either<FileStorageFailure, Unit>>`.
* Use `FileStorageService.getTemporaryDirectory()` to resolve device temporary directory for local storage paths, returning `Future<Either<FileStorageFailure, Directory>>`.

### 5. Custom Camera (Future Expansion)
* The placeholder directory `lib/src/camera` is reserved for camera-feed custom views (e.g. viewfinder widget overlays). Do not mix camera view widgets with the standard image-picking logic.

### 6. File Filtering & Size Validation
* Always filter file picking options using the `MimeType` enum instead of raw strings.
* Convert input file names/paths to `MimeType` using `MimeType.fromFileNameOrPath()` or `MimeType.fromExtension()`.
* Compare against `Set<MimeType>` directly via `allowedFileTypes` rather than raw string sets. Return `InvalidFileTypeFailure` if a mismatch is detected.
* Support `maxSizeBytes` filtering on pickers, returning `FileSizeExceededFailure` if a file is too large.
