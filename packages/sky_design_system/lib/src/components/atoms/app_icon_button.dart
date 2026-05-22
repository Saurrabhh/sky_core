import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

enum _AppIconButtonVariant { standard, primary, secondary, outlined, inverse }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.standard;

  const AppIconButton.primary({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.primary;

  const AppIconButton.secondary({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.secondary;

  const AppIconButton.outlined({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.outlined;

  const AppIconButton.inverse({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.inverse;

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final bool isLoading;
  final _AppIconButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final iconWidget = isLoading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: AppProgressIndicator.circular(),
          )
        : AppIcon.md(icon, color: color);

    return switch (_variant) {
      _AppIconButtonVariant.standard => IconButton(
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
        icon: iconWidget,
      ),
      _AppIconButtonVariant.primary => IconButton.filled(
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          backgroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.primary,
          foregroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.onPrimary,
        ),
      ),
      _AppIconButtonVariant.secondary => IconButton.filled(
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          backgroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.secondaryContainer,
          foregroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.onSecondaryContainer,
        ),
      ),
      _AppIconButtonVariant.outlined => IconButton.outlined(
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          foregroundColor: context.colorScheme.primary,
          side: BorderSide(color: context.colorScheme.outline),
        ),
      ),
      _AppIconButtonVariant.inverse => IconButton.filled(
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
        icon: iconWidget,
        style: IconButton.styleFrom(
          backgroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.inverseSurface,
          foregroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.onInverseSurface,
        ),
      ),
    };
  }
}
