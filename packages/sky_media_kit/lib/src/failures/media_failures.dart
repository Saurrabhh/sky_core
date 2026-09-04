import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_media_kit/src/pickers/mime_type.dart';

/// {@template media_kit_failure}
/// Base failure class for all errors originating within the `sky_media_kit`
/// package.
/// {@endtemplate}
abstract class MediaKitFailure extends Failure {
  /// {@macro media_kit_failure}
  const MediaKitFailure({
    required super.message,
    super.code,
  });
}

/// {@template media_picker_cancelled_failure}
/// Failure returned when the user cancels media/file selection or does not
/// pick any file.
/// {@endtemplate}
class MediaPickerCancelledFailure extends MediaKitFailure {
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
class FileSizeExceededFailure extends MediaKitFailure {
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
class InvalidFileTypeFailure extends MediaKitFailure {
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
class MediaPermissionDeniedFailure extends MediaKitFailure {
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
class CameraCaptureFailure extends MediaKitFailure {
  /// {@macro camera_capture_failure}
  const CameraCaptureFailure({
    required super.message,
    super.code,
  });
}

/// {@template file_storage_failure}
/// Failure returned when reading, writing, creating, or deleting a file in
/// local storage fails.
/// {@endtemplate}
class FileStorageFailure extends MediaKitFailure {
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

/// {@template unknown_media_failure}
/// Failure returned when an unhandled or unexpected error occurs during a
/// media or filesystem operation.
/// {@endtemplate}
class UnknownMediaFailure extends MediaKitFailure {
  /// {@macro unknown_media_failure}
  const UnknownMediaFailure({
    required super.message,
    super.code,
  });
}
