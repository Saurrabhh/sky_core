import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

class PlatformRasterWidget extends StatelessWidget {
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

  /// The file of this widget.
  final XFile file;

  /// The width of this widget.
  final double? width;

  /// The height of this widget.
  final double? height;

  /// The fit of this widget.
  final BoxFit fit;

  /// The cacheHeight of this widget.
  final int? cacheHeight;

  /// The cacheWidth of this widget.
  final int? cacheWidth;

  /// The semanticLabel of this widget.
  final String? semanticLabel;

  /// The errorWidget of this widget.
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
