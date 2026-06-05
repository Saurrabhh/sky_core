import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/app_border_radius.dart';

enum _AppCardVariant { outlined, filled }

/// A card container widget with support for headers and gestures.
class AppCard extends StatelessWidget {
  /// Creates an [AppCard] in the outlined style.
  const AppCard.outlined({
    required this.child,
    super.key,
    this._padding,
    this.color,
  }) : _variant = _AppCardVariant.outlined;

  /// Creates an [AppCard] in the filled style.
  const AppCard.filled({
    required this.child,
    super.key,
    this._padding,
    this.color,
  }) : _variant = _AppCardVariant.filled;

  /// The child of this widget.
  final Widget child;
  final EdgeInsetsGeometry? _padding;
  final Color? color;
  final _AppCardVariant _variant;

  @override
  Widget build(BuildContext context) {
    final isOutlined = _variant == _AppCardVariant.outlined;
    final themeShape = context.cardTheme.shape;
    final borderRadius = themeShape is RoundedRectangleBorder
        ? themeShape.borderRadius
        : AppBorderRadius.md;

    final childWidget = (_padding == null || _padding == EdgeInsets.zero)
        ? child
        : Padding(padding: _padding, child: child);

    return Card(
      elevation: isOutlined ? null : 0,
      color: isOutlined
          ? color
          : color ?? context.colorScheme.surfaceContainerLow,
      shape: isOutlined
          ? null
          : RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
      child: childWidget,
    );
  }
}
