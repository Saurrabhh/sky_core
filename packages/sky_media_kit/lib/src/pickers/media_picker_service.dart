import 'package:image_picker/image_picker.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_media_kit/src/failures/media_failures.dart';
import 'package:sky_media_kit/src/pickers/mime_type.dart';

/// Convenient type alias for asynchronous operations that return either a
/// [MediaPickerFailure] on the left or a value of type [T] on the right.
typedef FutureEitherMediaPicker<T> = Future<Either<MediaPickerFailure, T>>;

/// {@template media_picker_service}
/// Service interface for selecting images from the gallery, capturing photos
/// using the device camera, and selecting single or multiple files from the
/// device filesystem.
/// {@endtemplate}
abstract interface class MediaPickerService {
  /// Picks an image from the gallery or captures a new photo using the camera.
  ///
  /// Defaults to [ImageSource.camera].
  /// Optionally restricts dimensions with [maxWidth] and [maxHeight], image
  /// encoding quality with [imageQuality], and maximum file size in bytes with
  /// [maxSizeBytes].
  ///
  /// Returns an [XFile] on success, or a [MediaPickerFailure] if the selection
  /// was cancelled or an error occurred.
  Future<Either<MediaPickerFailure, XFile>> pickImage({
    ImageSource source = ImageSource.camera,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    int? maxSizeBytes,
  });

  /// Picks a single file from the device filesystem.
  ///
  /// Optionally filters by [allowedFileTypes] and restricts the maximum size
  /// with [maxSizeBytes].
  ///
  /// Returns an [XFile] on success, or a [MediaPickerFailure] if the selection
  /// was cancelled or an error occurred.
  Future<Either<MediaPickerFailure, XFile>> pickFile({
    List<MimeType>? allowedFileTypes,
    int? maxSizeBytes,
  });

  /// Picks multiple files concurrently from the device filesystem.
  ///
  /// Optionally filters by [allowedFileTypes] and restricts the maximum size
  /// per file with [maxSizeBytes].
  ///
  /// Returns a list of [XFile]s on success, or a [MediaPickerFailure] if the
  /// selection was cancelled or an error occurred.
  Future<Either<MediaPickerFailure, List<XFile>>> pickMultipleFiles({
    List<MimeType>? allowedFileTypes,
    int? maxSizeBytes,
  });
}
