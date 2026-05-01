import 'package:flutter/material.dart';
import '../../../sky_design_system.dart';

enum _AppButtonVariant {
  primary,
  secondary,
  outlined,
  text,
}

/// A unified button component following the design system's specifications.
class AppButton extends StatelessWidget {
  /// Creates a primary button with filled background.
  const AppButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.primary;

  /// Creates a secondary button with tonal background.
  const AppButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.secondary;

  /// Creates an outlined button with a border.
  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.outlined;

  /// Creates a text button with transparent background.
  const AppButton.text({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.text;

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final Widget label = _LoadingOverlay(
      isLoading: isLoading,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.sm,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
          ],
          Text(text),
        ],
      ),
    );

    return switch (_variant) {
      _AppButtonVariant.primary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: label,
        ),
      _AppButtonVariant.secondary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.secondaryContainer,
            foregroundColor: context.colorScheme.onSecondaryContainer,
          ),
          child: label,
        ),
      _AppButtonVariant.outlined => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: label,
        ),
      _AppButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          child: label,
        ),
    };
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay({
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: isLoading ? 0 : 1,
          child: child,
        ),
        if (isLoading)
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
      ],
    );
  }
}
