import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/app_border_radius.dart';

enum _AppCardVariant { outlined, filled }

class AppCard extends StatelessWidget {
  const AppCard.outlined({required this.child, super.key, this._padding})
    : _variant = _AppCardVariant.outlined;

  const AppCard.filled({required this.child, super.key, this._padding})
    : _variant = _AppCardVariant.filled;

  final Widget child;
  final EdgeInsetsGeometry? _padding;
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
      color: isOutlined ? null : context.colorScheme.surfaceContainerLow,
      shape: isOutlined
          ? null
          : RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
      child: childWidget,
    );
  }
}
