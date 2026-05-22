import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

enum _AppButtonVariant { primary, secondary, outlined, inverse, text, fab }

class AppButton extends StatelessWidget {
  const AppButton.primary({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
  }) : _variant = _AppButtonVariant.primary,
       _iconData = icon;

  const AppButton.secondary({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
  }) : _variant = _AppButtonVariant.secondary,
       _iconData = icon;

  const AppButton.outlined({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
  }) : _variant = _AppButtonVariant.outlined,
       _iconData = icon;

  const AppButton.inverse({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
  }) : _variant = _AppButtonVariant.inverse,
       _iconData = icon;

  const AppButton.text({
    required this.text,
    required this.onPressed,
    super.key,
    IconData? icon,
  }) : _variant = _AppButtonVariant.text,
       _iconData = icon;

  const AppButton.fab({
    required IconData icon,
    required this.onPressed,
    super.key,
  }) : _variant = _AppButtonVariant.fab,
       text = '',
       _iconData = icon;

  final String text;
  final VoidCallback? onPressed;
  final IconData? _iconData;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    if (_variant == _AppButtonVariant.fab) {
      return FloatingActionButton(
        onPressed: onPressed,
        child: AppIcon.md(_iconData!),
      );
    }

    final Widget label = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.sm,
      children: [
        if (_iconData != null) ...[
          AppIcon.sm(_iconData),
        ],
        Text(text),
      ],
    );

    return switch (_variant) {
      _AppButtonVariant.primary => ElevatedButton(
        onPressed: onPressed,
        child: label,
      ),
      _AppButtonVariant.secondary => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.secondaryContainer,
          foregroundColor: context.colorScheme.onSecondaryContainer,
        ),
        child: label,
      ),
      _AppButtonVariant.inverse => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.inverseSurface,
          foregroundColor: context.colorScheme.onInverseSurface,
        ),
        child: label,
      ),
      _AppButtonVariant.outlined => OutlinedButton(
        onPressed: onPressed,
        child: label,
      ),
      _AppButtonVariant.text => TextButton(
        onPressed: onPressed,
        child: label,
      ),
      _AppButtonVariant.fab => throw UnimplementedError(), // Handled above
    };
  }
}
