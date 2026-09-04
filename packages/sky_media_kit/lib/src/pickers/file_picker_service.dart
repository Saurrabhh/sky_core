import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_media_kit/src/failures/media_failures.dart';
import 'package:sky_media_kit/src/pickers/mime_type.dart';

/// {@template file_picker_service}
/// Service interface for selecting files from the device's filesystem.
/// {@endtemplate}
abstract interface class FilePickerService {
  /// Picks a single file from the filesystem.
  ///
  /// Optionally filters by [allowedFileTypes] and restricts the maximum size
  /// with [maxSizeBytes].
  /// Returns an [XFile] on success, or a [MediaKitFailure] if the selection
  /// was cancelled or an error occurred.
  FutureEitherFailure<XFile> pickFile({
    List<MimeType>? allowedFileTypes,
    int? maxSizeBytes,
  });

  /// Picks multiple files concurrently from the filesystem.
  ///
  /// Optionally filters by [allowedFileTypes] and restricts the maximum size
  /// per file with [maxSizeBytes].
  /// Returns a list of [XFile]s on success, or a [MediaKitFailure] if the
  /// selection was cancelled or an error occurred.
  FutureEitherFailure<List<XFile>> pickMultipleFiles({
    List<MimeType>? allowedFileTypes,
    int? maxSizeBytes,
  });
}

/// {@template file_picker_service_impl}
/// Implementation of [FilePickerService] wrapping the [FilePicker] plugin.
/// {@endtemplate}
class FilePickerServiceImpl implements FilePickerService {
  /// {@macro file_picker_service_impl}
  const FilePickerServiceImpl();

  @override
  FutureEitherFailure<XFile> pickFile({
    List<MimeType>? allowedFileTypes,
    int? maxSizeBytes,
  }) async {
    try {
      final extensions = allowedFileTypes?.map((e) => e.fileType).toList();
      final file = await FilePicker.pickFile(
        type: extensions != null && extensions.isNotEmpty
            ? FileType.custom
            : FileType.any,
        allowedExtensions: extensions,
      );

      if (file == null) {
        return const Left(
          MediaPickerCancelledFailure(message: 'No file was selected.'),
        );
      }

      final failure = await _validateFile(
        file,
        allowedTypes: allowedFileTypes?.toSet(),
        maxSizeBytes: maxSizeBytes,
      );
      if (failure != null) return Left(failure);

      return Right(file.xFile);
    } on PlatformException catch (e) {
      return _handlePlatformException(e, 'picking file');
    } on Exception catch (e) {
      return Left(UnknownMediaFailure(message: e.toString()));
    } on Object catch (e) {
      return Left(
        UnknownMediaFailure(message: 'An unknown error occurred: $e'),
      );
    }
  }

  @override
  FutureEitherFailure<List<XFile>> pickMultipleFiles({
    List<MimeType>? allowedFileTypes,
    int? maxSizeBytes,
  }) async {
    try {
      final extensions = allowedFileTypes?.map((e) => e.fileType).toList();
      final files = await FilePicker.pickFiles(
        type: extensions != null && extensions.isNotEmpty
            ? FileType.custom
            : FileType.any,
        allowedExtensions: extensions,
      );

      if (files.isEmpty) {
        return const Left(
          MediaPickerCancelledFailure(message: 'No files were selected.'),
        );
      }

      final allowedTypesSet = allowedFileTypes?.toSet();
      final resultFiles = <XFile>[];

      for (final file in files) {
        final failure = await _validateFile(
          file,
          allowedTypes: allowedTypesSet,
          maxSizeBytes: maxSizeBytes,
        );
        if (failure != null) return Left(failure);
        resultFiles.add(file.xFile);
      }

      return Right(resultFiles);
    } on PlatformException catch (e) {
      return _handlePlatformException(e, 'picking files');
    } on Exception catch (e) {
      return Left(UnknownMediaFailure(message: e.toString()));
    } on Object catch (e) {
      return Left(
        UnknownMediaFailure(message: 'An unknown error occurred: $e'),
      );
    }
  }

  Future<MediaKitFailure?> _validateFile(
    PlatformFile file, {
    Set<MimeType>? allowedTypes,
    int? maxSizeBytes,
  }) async {
    if (allowedTypes != null && allowedTypes.isNotEmpty) {
      final actualMimeType =
          MimeType.fromFileNameOrPath(file.name) ??
          MimeType.fromExtension(file.extension);

      if (actualMimeType == null || !allowedTypes.contains(actualMimeType)) {
        return InvalidFileTypeFailure(
          message:
              'Picked file "${file.name}" has an unsupported file type '
              '(${actualMimeType?.mime ?? "unknown"}). '
              'Allowed types: '
              '${allowedTypes.map((m) => m.fileType).join(", ")}',
          actualExtension: file.extension ?? file.name.split('.').lastOrNull,
          allowedFileTypes: allowedTypes.toList(),
          actualMimeType: actualMimeType,
        );
      }
    }

    if (maxSizeBytes != null) {
      final length = await file.xFile.length();
      if (length > maxSizeBytes) {
        return FileSizeExceededFailure(
          message:
              'Selected file "${file.name}" ($length bytes) exceeds the '
              'maximum allowed size of $maxSizeBytes bytes.',
          actualSizeBytes: length,
          maxSizeBytes: maxSizeBytes,
        );
      }
    }

    return null;
  }

  Left<MediaKitFailure, T> _handlePlatformException<T>(
    PlatformException e,
    String operation,
  ) {
    final code = e.code.toLowerCase();
    if (code.contains('permission') || code.contains('denied')) {
      return Left(
        MediaPermissionDeniedFailure(
          message: e.message ?? 'Permission to access files was denied.',
          permission: 'storage',
          code: e.code,
        ),
      );
    }
    return Left(
      UnknownMediaFailure(
        message: e.message ?? 'An error occurred while $operation.',
        code: e.code,
      ),
    );
  }
}
