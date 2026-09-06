import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_media_kit/src/pickers/mime_type.dart';

// =============================================================================
// File / Media Picker Failures
// =============================================================================

/// {@template media_picker_failure}
/// Base sealed failure class for all errors occurring during media or file
/// selection.
/// {@endtemplate}
sealed class MediaPickerFailure extends Failure {
  /// {@macro media_picker_failure}
  const MediaPickerFailure({
    required super.message,
    super.code,
  });
}

/// {@template media_picker_cancelled_failure}
/// Failure returned when the user cancels media/file selection or does not
/// pick any file.
/// {@endtemplate}
class MediaPickerCancelledFailure extends MediaPickerFailure {
  /// {@macro media_picker_cancelled_failure}
  const MediaPickerCancelledFailure({
    super.message = 'Media selection was cancelled.',
    super.code,
  });
}

/// {@template file_size_exceeded_failure}
/// Failure returned when a selected or processed file exceeds the maximum
/// allowed byte size limit.
/// {@endtemplate}
class FileSizeExceededFailure extends MediaPickerFailure {
  /// {@macro file_size_exceeded_failure}
  const FileSizeExceededFailure({
    required super.message,
    this.actualSizeBytes,
    this.maxSizeBytes,
    super.code,
  });

  /// The actual size of the file in bytes, if known.
  final int? actualSizeBytes;

  /// The maximum permitted size in bytes.
  final int? maxSizeBytes;

  @override
  List<Object?> get props => [...super.props, actualSizeBytes, maxSizeBytes];
}

/// {@template invalid_file_type_failure}
/// Failure returned when a selected file has an unsupported extension or
/// MIME type.
/// {@endtemplate}
class InvalidFileTypeFailure extends MediaPickerFailure {
  /// {@macro invalid_file_type_failure}
  const InvalidFileTypeFailure({
    required super.message,
    this.actualExtension,
    this.allowedFileTypes,
    this.allowedExtensions,
    this.actualMimeType,
    super.code,
  });

  /// The detected extension of the rejected file.
  final String? actualExtension;

  /// The list of allowed [MimeType]s.
  final List<MimeType>? allowedFileTypes;

  /// The list of valid extensions that were expected (alias for
  /// [allowedFileTypes]).
  final List<String>? allowedExtensions;

  /// The detected [MimeType] of the rejected file, if identified.
  final MimeType? actualMimeType;

  @override
  List<Object?> get props => [
    ...super.props,
    actualExtension,
    allowedFileTypes,
    allowedExtensions,
    actualMimeType,
  ];
}

/// {@template media_permission_denied_failure}
/// Failure returned when the app is denied permission to access the camera,
/// photo gallery, or device storage.
/// {@endtemplate}
class MediaPermissionDeniedFailure extends MediaPickerFailure {
  /// {@macro media_permission_denied_failure}
  const MediaPermissionDeniedFailure({
    required super.message,
    this.permission,
    super.code,
  });

  /// The name or identifier of the denied permission (e.g., 'camera').
  final String? permission;

  @override
  List<Object?> get props => [...super.props, permission];
}

/// {@template camera_capture_failure}
/// Failure returned when camera initialization, configuration, or photo/video
/// capture fails.
/// {@endtemplate}
class CameraCaptureFailure extends MediaPickerFailure {
  /// {@macro camera_capture_failure}
  const CameraCaptureFailure({
    required super.message,
    super.code,
  });
}

/// {@template unknown_media_failure}
/// Failure returned when an unhandled or unexpected error occurs during media
/// or file selection.
/// {@endtemplate}
class UnknownMediaFailure extends MediaPickerFailure {
  /// {@macro unknown_media_failure}
  const UnknownMediaFailure({
    required super.message,
    super.code,
  });
}

// =============================================================================
// File Storage Failures
// =============================================================================

/// {@template file_storage_failure}
/// Base sealed failure class for all errors occurring during file system
/// storage operations.
/// {@endtemplate}
sealed class FileStorageFailure extends Failure {
  /// {@macro file_storage_failure}
  const FileStorageFailure({
    required super.message,
    this.filePath,
    super.code,
  });

  /// The path to the file that caused the storage error, if applicable.
  final String? filePath;

  @override
  List<Object?> get props => [...super.props, filePath];
}

/// {@template file_storage_cancelled_failure}
/// Failure returned when a file save dialog is cancelled by the user.
/// {@endtemplate}
class FileStorageCancelledFailure extends FileStorageFailure {
  /// {@macro file_storage_cancelled_failure}
  const FileStorageCancelledFailure({
    super.message = 'File save was cancelled.',
    super.filePath,
    super.code,
  });
}

/// {@template file_storage_permission_denied_failure}
/// Failure returned when permission to save or modify local files is denied.
/// {@endtemplate}
class FileStoragePermissionDeniedFailure extends FileStorageFailure {
  /// {@macro file_storage_permission_denied_failure}
  const FileStoragePermissionDeniedFailure({
    required super.message,
    super.filePath,
    super.code,
  });
}

/// {@template file_storage_io_failure}
/// Failure returned when reading, writing, creating, or deleting a file in
/// local storage fails due to an I/O or filesystem error.
/// {@endtemplate}
class FileStorageIOFailure extends FileStorageFailure {
  /// {@macro file_storage_io_failure}
  const FileStorageIOFailure({
    required super.message,
    super.filePath,
    super.code,
  });
}

/// {@template unknown_file_storage_failure}
/// Failure returned when an unhandled or unexpected error occurs during a
/// file storage operation.
/// {@endtemplate}
class UnknownFileStorageFailure extends FileStorageFailure {
  /// {@macro unknown_file_storage_failure}
  const UnknownFileStorageFailure({
    required super.message,
    super.filePath,
    super.code,
  });
}
