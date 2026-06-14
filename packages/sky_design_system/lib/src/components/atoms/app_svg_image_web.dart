import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Web implementation: Uses a blob URL to stream the local file.
class PlatformSvgWidget extends StatelessWidget {
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

  /// The file of this widget.
  final XFile file;

  /// The width of this widget.
  final double? width;

  /// The height of this widget.
  final double? height;

  /// The fit of this widget.
  final BoxFit fit;

  /// The placeholder of this widget.
  final Widget placeholder;

  /// The semanticLabel of this widget.
  final String? semanticsLabel;

  /// The errorWidget of this widget.
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      file.path,
      width: width,
      height: height,
      fit: fit,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: (_) => placeholder,
      errorBuilder: (_, _, _) => errorWidget,
    );
  }
}
