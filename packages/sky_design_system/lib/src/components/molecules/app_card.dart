import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/border_radius.dart';

enum _AppCardVariant { outlined, filled }

/// A container molecule for grouping related information.
class AppCard extends StatelessWidget {
  /// Creates an outlined card (default for data-heavy views).
  const AppCard.outlined({required this.child, super.key, this.padding})
    : _variant = _AppCardVariant.outlined;

  /// Creates a filled (tonal) card for grouping related actions.
  const AppCard.filled({required this.child, super.key, this.padding})
    : _variant = _AppCardVariant.filled;

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final _AppCardVariant _variant;

  @override
  Widget build(BuildContext context) {
    final isOutlined = _variant == _AppCardVariant.outlined;
    final themeShape = CardTheme.of(context).shape as RoundedRectangleBorder?;

    return Card(
      elevation: isOutlined ? null : 0,
      color: isOutlined
          ? null
          : context.colorScheme.surfaceContainerLow,
      shape: isOutlined
          ? null
          : RoundedRectangleBorder(
              borderRadius: themeShape?.borderRadius ?? AppBorderRadius.md,
              side: BorderSide.none,
            ),
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
