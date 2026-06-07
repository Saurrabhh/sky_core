import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

enum _AppIconButtonVariant { standard, primary, secondary, outlined, inverse }

/// A button widget consisting of a single icon.
class AppIconButton extends StatelessWidget {
  /// Creates an [AppIconButton] instance.
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this._borderRadius,
  }) : _variant = _AppIconButtonVariant.standard;

  /// Creates an [AppIconButton] in the primary style.
  const AppIconButton.primary({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this._borderRadius,
  }) : _variant = _AppIconButtonVariant.primary;

  /// Creates an [AppIconButton] in the secondary style.
  const AppIconButton.secondary({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this._borderRadius,
  }) : _variant = _AppIconButtonVariant.secondary;

  /// Creates an [AppIconButton] in the outlined style.
  const AppIconButton.outlined({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this._borderRadius,
  }) : _variant = _AppIconButtonVariant.outlined;

  /// Creates an [AppIconButton] in the inverse style.
  const AppIconButton.inverse({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this._borderRadius,
  }) : _variant = _AppIconButtonVariant.inverse;

  /// The icon of this widget.
  final IconData icon;

  /// The onPressed of this widget.
  final VoidCallback? onPressed;

  /// The tooltip of this widget.
  final String? tooltip;

  /// The color of this widget.
  final Color? color;

  /// The border radius of this widget.
  final BorderRadius? _borderRadius;

  final _AppIconButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final iconWidget = AppIcon.md(icon, color: color);

    return switch (_variant) {
      _AppIconButtonVariant.standard => IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: _borderRadius != null
            ? IconButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: _borderRadius),
              )
            : null,
      ),
      _AppIconButtonVariant.primary => IconButton.filled(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
          shape: _borderRadius != null
              ? RoundedRectangleBorder(borderRadius: _borderRadius)
              : null,
        ),
      ),
      _AppIconButtonVariant.secondary => IconButton.filled(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          backgroundColor: context.colorScheme.secondaryContainer,
          foregroundColor: context.colorScheme.onSecondaryContainer,
          shape: _borderRadius != null
              ? RoundedRectangleBorder(borderRadius: _borderRadius)
              : null,
        ),
      ),
      _AppIconButtonVariant.outlined => IconButton.outlined(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          foregroundColor: context.colorScheme.primary,
          side: BorderSide(color: context.colorScheme.outline),
          shape: _borderRadius != null
              ? RoundedRectangleBorder(borderRadius: _borderRadius)
              : null,
        ),
      ),
      _AppIconButtonVariant.inverse => IconButton.filled(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          backgroundColor: context.colorScheme.inverseSurface,
          foregroundColor: context.colorScheme.onInverseSurface,
          shape: _borderRadius != null
              ? RoundedRectangleBorder(borderRadius: _borderRadius)
              : null,
        ),
      ),
    };
  }
}
