import 'package:flutter/material.dart';
import '../../extensions.dart';
import '../../foundations/border_radius.dart';

enum _AppCardVariant { outlined, filled }

/// A container molecule for grouping related information.
class AppCard extends StatelessWidget {
  /// Creates an outlined card (default for data-heavy views).
  const AppCard.outlined({super.key, required this.child, this.padding})
    : _variant = _AppCardVariant.outlined;

  /// Creates a filled (tonal) card for grouping related actions.
  const AppCard.filled({super.key, required this.child, this.padding})
    : _variant = _AppCardVariant.filled;

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final _AppCardVariant _variant;

  @override
  Widget build(BuildContext context) {
    final isOutlined = _variant == _AppCardVariant.outlined;

    return Card(
      elevation: 0,
      color: isOutlined
          ? context.colorScheme.surface
          : context.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.md,
        side: isOutlined
            ? BorderSide(color: context.colorScheme.outlineVariant, width: 1)
            : BorderSide.none,
      ),
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
