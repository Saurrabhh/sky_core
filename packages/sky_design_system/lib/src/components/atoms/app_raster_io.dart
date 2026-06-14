import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

/// An internal widget that renders a raster image (e.g., PNG, JPEG) from a
/// local file on native (I/O) platforms.
///
/// This widget uses [Image.file] to load and decode the image from the local
/// filesystem.
class PlatformRasterWidget extends StatelessWidget {
  /// Creates a [PlatformRasterWidget].
  const PlatformRasterWidget({
    required this.file,
    required this.fit,
    required this.errorWidget,
    this.width,
    this.height,
    this.cacheHeight,
    this.cacheWidth,
    this.semanticLabel,
    super.key,
  });

  /// The local file containing the raster image to render.
  final XFile file;

  /// The target width of the image container.
  final double? width;

  /// The target height of the image container.
  final double? height;

  /// How the image should be inscribed into its container.
  final BoxFit fit;

  /// The maximum height to decode the image to, used for memory optimization.
  final int? cacheHeight;

  /// The maximum width to decode the image to, used for memory optimization.
  final int? cacheWidth;

  /// The semantic label for the image, used for accessibility.
  final String? semanticLabel;

  /// The widget to display if the image fails to load.
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(file.path),
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      errorBuilder: (_, _, _) => errorWidget,
    );
  }
}
