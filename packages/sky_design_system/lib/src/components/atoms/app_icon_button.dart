import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_icon.dart';
import 'package:sky_design_system/src/components/atoms/app_progress_indicator.dart';

enum _AppIconButtonVariant { standard, filled, tonal, outlined }

/// A unified icon button component following the design system's
/// specifications.
class AppIconButton extends StatelessWidget {
  /// Creates a standard icon button.
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.standard;

  /// Creates a filled icon button.
  const AppIconButton.filled({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.filled;

  /// Creates a tonal icon button.
  const AppIconButton.tonal({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.tonal;

  /// Creates an outlined icon button.
  const AppIconButton.outlined({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.isLoading = false,
  }) : _variant = _AppIconButtonVariant.outlined;

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
        : AppIcon(icon, color: color);

    return switch (_variant) {
      _AppIconButtonVariant.standard => IconButton(
        icon: iconWidget,
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
      ),
      _AppIconButtonVariant.filled => IconButton.filled(
        icon: iconWidget,
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
      ),
      _AppIconButtonVariant.tonal => IconButton.filledTonal(
        icon: iconWidget,
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
      ),
      _AppIconButtonVariant.outlined => IconButton.outlined(
        icon: iconWidget,
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
      ),
    };
  }
}
