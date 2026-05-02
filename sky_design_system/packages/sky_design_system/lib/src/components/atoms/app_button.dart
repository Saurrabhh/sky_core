import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

enum _AppButtonVariant { primary, secondary, tonal, outlined, text, fab }

/// A unified button component following the design system's specifications.
class AppButton extends StatelessWidget {
  /// Creates a primary button with filled background.
  const AppButton.primary({
    required this.text, required this.onPressed, super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.primary,
       iconData = icon;

  /// Creates a secondary button with tonal background.
  const AppButton.secondary({
    required this.text, required this.onPressed, super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.secondary,
       iconData = icon;

  /// Creates a tonal button with tonal background.
  const AppButton.tonal({
    required this.text, required this.onPressed, super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.tonal,
       iconData = icon;

  /// Creates an outlined button with a border.
  const AppButton.outlined({
    required this.text, required this.onPressed, super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.outlined,
       iconData = icon;

  /// Creates a text button with transparent background.
  const AppButton.text({
    required this.text, required this.onPressed, super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.text,
       iconData = icon;

  /// Creates a floating action button.
  const AppButton.fab({
    required IconData icon, required this.onPressed, super.key,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.fab,
       text = '',
       iconData = icon;

  final String text;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final bool isLoading;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    if (_variant == _AppButtonVariant.fab) {
      return FloatingActionButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: AppProgressIndicator.circular(),
              )
            : Icon(iconData),
      );
    }

    final Widget label = _LoadingOverlay(
      isLoading: isLoading,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.sm,
        children: [
          if (iconData != null) ...[Icon(iconData, size: 18)],
          AppText.labelLarge(text),
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
      _AppButtonVariant.tonal => FilledButton.tonal(
        onPressed: isLoading ? null : onPressed,
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
      _AppButtonVariant.fab => throw UnimplementedError(), // Handled above
    };
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay({required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: isLoading ? 0 : 1, child: child),
        if (isLoading)
          const SizedBox(
            width: 18,
            height: 18,
            child: AppProgressIndicator.circular(),
          ),
      ],
    );
  }
}
