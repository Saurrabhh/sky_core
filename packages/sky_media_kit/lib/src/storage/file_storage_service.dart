import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_media_kit/src/failures/media_failures.dart';
import 'package:sky_media_kit/src/pickers/mime_type.dart';

/// {@template file_storage_service}
/// Service interface for saving files, deleting files, and resolving device
/// directories.
/// {@endtemplate}
abstract interface class FileStorageService {
  /// Saves binary data to a file using the system save dialog via [FilePicker].
  ///
  /// Takes [fileName], [bytes], optional [dialogTitle], [initialDirectory],
  /// and [allowedFileTypes].
  /// Returns the saved file path on success, or a [FileStorageFailure] on error
  /// or cancellation.
  FutureEitherFailure<String> saveFile({
    required String fileName,
    required Uint8List bytes,
    String? dialogTitle,
    String? initialDirectory,
    List<MimeType>? allowedFileTypes,
  });

  /// Deletes the file at the specified [filePath] if it exists.
  ///
  /// Returns a [FileStorageFailure] if an error occurs.
  FutureEitherFailureUnit deleteFile(String filePath);

  /// Resolves the application's temporary directory.
  ///
  /// Returns a [Directory] on success, or a [FileStorageFailure] on error.
  FutureEitherFailure<Directory> getTemporaryDirectory();

}

/// {@template file_storage_service_impl}
/// Implementation of [FileStorageService] wrapping [FilePicker.saveFile],
/// `dart:io`, and `path_provider`.
/// {@endtemplate}
class FileStorageServiceImpl implements FileStorageService {
  /// {@macro file_storage_service_impl}
  const FileStorageServiceImpl();

  @override
  FutureEitherFailure<String> saveFile({
    required String fileName,
    required Uint8List bytes,
    String? dialogTitle,
    String? initialDirectory,
    List<MimeType>? allowedFileTypes,
  }) async {
    try {
      final extensions = allowedFileTypes?.map((e) => e.fileType).toList();
      final savedUri = await FilePicker.saveFile(
        dialogTitle: dialogTitle,
        fileName: fileName,
        initialDirectory: initialDirectory,
        type: extensions != null && extensions.isNotEmpty
            ? FileType.custom
            : FileType.any,
        allowedExtensions: extensions,
        bytes: bytes,
      );

      if (savedUri == null) {
        return const Left(FileStorageCancelledFailure());
      }

      return Right(
        savedUri.path.isNotEmpty ? savedUri.path : savedUri.toString(),
      );
    } on PlatformException catch (e) {
      final code = e.code.toLowerCase();
      if (code.contains('permission') || code.contains('denied')) {
        return Left(
          FileStoragePermissionDeniedFailure(
            message: e.message ?? 'Permission to save file was denied.',
            permission: 'storage',
            code: e.code,
          ),
        );
      }
      return Left(
        FileStorageIOFailure(
          message: e.message ?? 'Failed to save file.',
          code: e.code,
        ),
      );
    } on Exception catch (e) {
      return Left(FileStorageIOFailure(message: e.toString()));
    }
  }

  @override
  FutureEitherFailureUnit deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        await file.delete();
      }
      return const Right(unit);
    } on FileSystemException catch (e) {
      return Left(
        FileStorageIOFailure(
          message: e.message,
          filePath: filePath,
          code: e.osError?.errorCode.toString(),
        ),
      );
    } on Exception catch (e) {
      return Left(
        FileStorageIOFailure(
          message: e.toString(),
          filePath: filePath,
        ),
      );
    }
  }

  @override
  FutureEitherFailure<Directory> getTemporaryDirectory() async {
    try {
      final directory = await path_provider.getTemporaryDirectory();
      return Right(directory);
    } on Exception catch (e) {
      return Left(FileStorageIOFailure(message: e.toString()));
    }
  }
}
