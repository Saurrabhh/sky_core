import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_media_kit/src/failures/media_failures.dart';
import 'package:sky_media_kit/src/pickers/media_picker_service.dart';
import 'package:sky_media_kit/src/pickers/mime_type.dart';

/// {@template media_picker_service_impl}
/// Implementation of [MediaPickerService] wrapping [ImagePicker] and
/// [FilePicker].
/// {@endtemplate}
class MediaPickerServiceImpl implements MediaPickerService {
  /// {@macro media_picker_service_impl}
  MediaPickerServiceImpl({ImagePicker? picker})
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
        try {
          final length = await file.length();
          if (length > maxSizeBytes) {
            return Left(
              FileSizeExceededFailure(
                message:
                    'Selected image ($length bytes) exceeds the maximum '
                    'allowed size of $maxSizeBytes bytes.',
                actualSizeBytes: length,
                maxSizeBytes: maxSizeBytes,
              ),
            );
          }
        } on FileSystemException catch (e) {
          return Left(
            UnknownMediaFailure(
              message: _sanitizeErrorMessage(
                e,
                fallback: 'Failed to read image file size.',
              ),
              code: e.osError?.errorCode.toString(),
            ),
          );
        }
      }

      return Right(file);
    } on PlatformException catch (e) {
      return _handlePlatformException(
        e,
        'picking image',
        source: source,
      );
    } on FileSystemException catch (e) {
      return Left(
        UnknownMediaFailure(
          message: _sanitizeErrorMessage(
            e,
            fallback: 'File system error occurred while picking image.',
          ),
          code: e.osError?.errorCode.toString(),
        ),
      );
    } on Object catch (e) {
      return Left(
        UnknownMediaFailure(
          message: _sanitizeErrorMessage(
            e,
            fallback: 'An error occurred while picking image.',
          ),
        ),
      );
    }
  }

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

      return _validateFile(
        file,
        allowedTypes: allowedFileTypes?.toSet(),
        maxSizeBytes: maxSizeBytes,
      );
    } on PlatformException catch (e) {
      return _handlePlatformException(
        e,
        'picking file',
        permission: 'storage',
      );
    } on FileSystemException catch (e) {
      return Left(
        UnknownMediaFailure(
          message: _sanitizeErrorMessage(
            e,
            fallback: 'File system error occurred while picking file.',
          ),
          code: e.osError?.errorCode.toString(),
        ),
      );
    } on Object catch (e) {
      return Left(
        UnknownMediaFailure(
          message: _sanitizeErrorMessage(
            e,
            fallback: 'An error occurred while picking file.',
          ),
        ),
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
        final validationResult = await _validateFile(
          file,
          allowedTypes: allowedTypesSet,
          maxSizeBytes: maxSizeBytes,
        );

        switch (validationResult) {
          case Left(:final value):
            return Left(value);
          case Right(:final value):
            resultFiles.add(value);
        }
      }

      return Right(resultFiles);
    } on PlatformException catch (e) {
      return _handlePlatformException(
        e,
        'picking files',
        permission: 'storage',
      );
    } on FileSystemException catch (e) {
      return Left(
        UnknownMediaFailure(
          message: _sanitizeErrorMessage(
            e,
            fallback: 'File system error occurred while picking files.',
          ),
          code: e.osError?.errorCode.toString(),
        ),
      );
    } on Object catch (e) {
      return Left(
        UnknownMediaFailure(
          message: _sanitizeErrorMessage(
            e,
            fallback: 'An error occurred while picking files.',
          ),
        ),
      );
    }
  }

  FutureEitherFailure<XFile> _validateFile(
    PlatformFile file, {
    Set<MimeType>? allowedTypes,
    int? maxSizeBytes,
  }) async {
    if (allowedTypes != null && allowedTypes.isNotEmpty) {
      final actualMimeType =
          MimeType.fromFileNameOrPath(file.name) ??
          MimeType.fromExtension(file.extension);

      if (actualMimeType == null || !allowedTypes.contains(actualMimeType)) {
        return Left(
          InvalidFileTypeFailure(
            message:
                'Picked file "${file.name}" has an unsupported file type '
                '(${actualMimeType?.mime ?? "unknown"}). '
                'Allowed types: '
                '${allowedTypes.map((m) => m.fileType).join(", ")}',
            actualExtension: file.extension ?? file.name.split('.').lastOrNull,
            allowedFileTypes: allowedTypes.toList(),
            allowedExtensions: allowedTypes.map((m) => m.fileType).toList(),
            actualMimeType: actualMimeType,
          ),
        );
      }
    }

    final xFile = file.xFile;

    if (maxSizeBytes != null) {
      try {
        final length = await xFile.length();
        if (length > maxSizeBytes) {
          return Left(
            FileSizeExceededFailure(
              message:
                  'Selected file "${file.name}" ($length bytes) exceeds the '
                  'maximum allowed size of $maxSizeBytes bytes.',
              actualSizeBytes: length,
              maxSizeBytes: maxSizeBytes,
            ),
          );
        }
      } on FileSystemException catch (e) {
        return Left(
          UnknownMediaFailure(
            message: _sanitizeErrorMessage(
              e,
              fallback: 'Failed to read file length for "${file.name}".',
            ),
            code: e.osError?.errorCode.toString(),
          ),
        );
      } on Object catch (e) {
        return Left(
          UnknownMediaFailure(
            message: _sanitizeErrorMessage(
              e,
              fallback: 'Failed to validate file size for "${file.name}".',
            ),
          ),
        );
      }
    }

    return Right(xFile);
  }

  Left<MediaPickerFailure, T> _handlePlatformException<T>(
    PlatformException e,
    String operation, {
    String? permission,
    ImageSource? source,
  }) {
    final code = e.code.toLowerCase();
    final message = _sanitizeErrorMessage(
      e,
      fallback: 'An error occurred while $operation.',
    );

    if (code.contains('cancel')) {
      return Left(
        MediaPickerCancelledFailure(
          message: message,
          code: e.code,
        ),
      );
    }

    if (code.contains('permission') ||
        code.contains('denied') ||
        code.contains('restricted') ||
        code.contains('unauthorized')) {
      final resolvedPermission =
          permission ??
          (source == ImageSource.camera
              ? 'camera'
              : (source == ImageSource.gallery ? 'gallery' : 'storage'));

      return Left(
        MediaPermissionDeniedFailure(
          message: message,
          permission: resolvedPermission,
          code: e.code,
        ),
      );
    }

    if (source == ImageSource.camera || code.contains('camera')) {
      return Left(
        CameraCaptureFailure(
          message: message,
          code: e.code,
        ),
      );
    }

    return Left(
      UnknownMediaFailure(
        message: message,
        code: e.code,
      ),
    );
  }

  String _sanitizeErrorMessage(
    Object error, {
    required String fallback,
  }) {
    if (error is PlatformException) {
      final msg = error.message?.trim();
      if (msg != null && msg.isNotEmpty) {
        return msg;
      }
      return 'Platform error occurred: ${error.code}';
    }

    if (error is FileSystemException) {
      final msg = error.message.trim();
      if (msg.isNotEmpty) {
        return msg;
      }
      return 'File system error occurred.';
    }

    final rawString = error.toString().trim();
    final cleanString = rawString.startsWith('Exception: ')
        ? rawString.substring('Exception: '.length).trim()
        : rawString;

    if (cleanString.isNotEmpty && cleanString != 'null') {
      return cleanString;
    }

    return fallback;
  }
}
