import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Native implementation of the platform-specific SVG rendering widget.
///
/// Uses [dart:io] via [SvgPicture.file] to stream the SVG content from disk
/// to optimize RAM usage.
class PlatformSvgWidget extends StatelessWidget {
  /// Creates a [PlatformSvgWidget] for native (I/O) platforms.
  const PlatformSvgWidget({
    required this.file,
    required this.fit,
    required this.placeholder,
    required this.errorWidget,
    this.width,
    this.height,
    this.semanticsLabel,
    super.key,
  });

  /// The local file containing the SVG image to render.
  final XFile file;

  /// The target width of the SVG image container.
  final double? width;

  /// The target height of the SVG image container.
  final double? height;

  /// How the SVG image should be inscribed into its container.
  final BoxFit fit;

  /// The placeholder widget to display while the SVG is loading.
  final Widget placeholder;

  /// The semantic label for the SVG image, used for accessibility.
  final String? semanticsLabel;

  /// The widget to display if the SVG image fails to load.
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.file(
      File(file.path),
      width: width,
      height: height,
      fit: fit,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: (_) => placeholder,
      errorBuilder: (_, _, _) => errorWidget,
    );
  }
}