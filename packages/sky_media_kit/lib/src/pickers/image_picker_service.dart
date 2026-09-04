import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_media_kit/src/failures/media_failures.dart';

/// {@template image_picker_service}
/// Service interface for selecting images from the gallery or capturing new
/// photos using the device camera.
/// {@endtemplate}
abstract interface class ImagePickerService {
  /// Picks an image from the gallery or captures a new photo using the camera.
  ///
  /// Defaults to [ImageSource.camera].
  /// Optionally restricts the maximum file size with [maxSizeBytes].
  /// Returns an [XFile] on success, or a [MediaKitFailure] if the selection
  /// was cancelled or an error occurred.
  FutureEitherFailure<XFile> pickImage({
    ImageSource source = ImageSource.camera,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    int? maxSizeBytes,
  });
}

/// {@template image_picker_service_impl}
/// Implementation of [ImagePickerService] that wraps the [ImagePicker] plugin.
/// {@endtemplate}
class ImagePickerServiceImpl implements ImagePickerService {
  /// {@macro image_picker_service_impl}
  ImagePickerServiceImpl({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  FutureEitherFailure<XFile> pickImage({
    ImageSource source = ImageSource.camera,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    int? maxSizeBytes,
  }) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      if (file == null) {
        return const Left(
          MediaPickerCancelledFailure(message: 'No image was selected.'),
        );
      }

      if (maxSizeBytes != null) {
        final length = await file.length();
        if (length > maxSizeBytes) {
          return Left(
            FileSizeExceededFailure(
              message:
                  'Selected image ($length bytes) exceeds the maximum allowed '
                  'size of $maxSizeBytes bytes.',
              actualSizeBytes: length,
              maxSizeBytes: maxSizeBytes,
            ),
          );
        }
      }

      return Right(file);
    } on PlatformException catch (e) {
      final code = e.code.toLowerCase();
      if (code.contains('permission') || code.contains('denied')) {
        return Left(
          MediaPermissionDeniedFailure(
            message: e.message ?? 'Permission to access media was denied.',
            permission: source == ImageSource.camera ? 'camera' : 'gallery',
            code: e.code,
          ),
        );
      }

      if (source == ImageSource.camera) {
        return Left(
          CameraCaptureFailure(
            message: e.message ?? 'Failed to capture photo from camera.',
            code: e.code,
          ),
        );
      }

      return Left(
        UnknownMediaFailure(
          message: e.message ?? 'An error occurred while picking image.',
          code: e.code,
        ),
      );
    } on Exception catch (e) {
      return Left(UnknownMediaFailure(message: e.toString()));
    } on Object catch (e) {
      return Left(
        UnknownMediaFailure(message: 'An unknown error occurred: $e'),
      );
    }
  }
}
