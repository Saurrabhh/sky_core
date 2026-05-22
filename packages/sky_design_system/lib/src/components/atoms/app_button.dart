import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

enum _AppButtonVariant { primary, secondary, outlined, inverse, text, fab }

class AppButton extends StatelessWidget {
  const AppButton.primary({
    required this.text,
    required this.onPressed,
    super.key,
    this._icon,
  }) : _variant = _AppButtonVariant.primary;

  const AppButton.secondary({
    required this.text,
    required this.onPressed,
    super.key,
    this._icon,
  }) : _variant = _AppButtonVariant.secondary;

  const AppButton.outlined({
    required this.text,
    required this.onPressed,
    super.key,
    this._icon,
  }) : _variant = _AppButtonVariant.outlined;

  const AppButton.inverse({
    required this.text,
    required this.onPressed,
    super.key,
    this._icon,
  }) : _variant = _AppButtonVariant.inverse;

  const AppButton.text({
    required this.text,
    required this.onPressed,
    super.key,
    this._icon,
  }) : _variant = _AppButtonVariant.text;

  const AppButton.fab({
    required IconData this._icon,
    required this.onPressed,
    super.key,
  }) : _variant = _AppButtonVariant.fab,
       text = '';

  final String text;
  final VoidCallback? onPressed;
  final IconData? _icon;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    if (_variant == _AppButtonVariant.fab) {
      return FloatingActionButton(
        onPressed: onPressed,
        child: AppIcon.md(_icon!),
      );
    }

    final Widget label = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.sm,
      children: [
        if (_icon != null) ...[
          AppIcon.sm(_icon),
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
