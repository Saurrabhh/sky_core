import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';

enum AppIconSize {
  /// 18px icon size
  small(18),

  /// 24px icon size
  medium(24),

  /// 32px icon size
  large(32);

  const AppIconSize(this.value);
  final double value;
}

/// A wrapper for standardizing icon sizes to the design system grid.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSize.medium,
    this.color,
  });

  final IconData icon;
  final AppIconSize size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size.value,
      color: color ?? context.colorScheme.onSurface,
    );
  }
}
