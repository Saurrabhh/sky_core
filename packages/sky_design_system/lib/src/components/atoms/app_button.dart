import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

enum _AppButtonVariant { primary, secondary, outlined, inverse, text, fab }

class AppButton extends StatelessWidget {
  const AppButton.primary({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.primary,
       iconData = icon;

  const AppButton.secondary({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.secondary,
       iconData = icon;

  const AppButton.outlined({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.outlined,
       iconData = icon;

  const AppButton.inverse({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.inverse,
       iconData = icon;

  const AppButton.text({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.text,
       iconData = icon;

  const AppButton.fab({
    required IconData icon,
    required this.onPressed,
    super.key,
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
            : AppIcon.md(iconData!),
      );
    }

    final Widget label = _LoadingOverlay(
      isLoading: isLoading,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.sm,
        children: [
          if (iconData != null) ...[
            AppIcon.sm(iconData!),
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
          backgroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.secondaryContainer,
          foregroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.onSecondaryContainer,
        ),
        child: label,
      ),
      _AppButtonVariant.inverse => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.inverseSurface,
          foregroundColor: isLoading || onPressed == null
              ? null
              : context.colorScheme.onInverseSurface,
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
