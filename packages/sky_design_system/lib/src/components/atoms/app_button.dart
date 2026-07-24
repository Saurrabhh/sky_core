import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

enum _AppButtonVariant { primary, secondary, outlined, inverse, text, fab }

/// A button widget supporting multiple styles and an optional icon.
class AppButton extends StatelessWidget {
  /// Creates an [AppButton] in the primary style.
  const AppButton.primary({
    required this.text,
    this.onPressed,
    super.key,
    this._icon,
    this.textAlign,
  }) : _variant = _AppButtonVariant.primary,
       color = null;

  /// Creates an [AppButton] in the secondary style.
  const AppButton.secondary({
    required this.text,
    this.onPressed,
    super.key,
    this._icon,
    this.textAlign,
  }) : _variant = _AppButtonVariant.secondary,
       color = null;

  /// Creates an [AppButton] in the outlined style.
  const AppButton.outlined({
    required this.text,
    this.onPressed,
    super.key,
    this._icon,
    this.textAlign,
  }) : _variant = _AppButtonVariant.outlined,
       color = null;

  /// Creates an [AppButton] in the inverse style.
  const AppButton.inverse({
    required this.text,
    this.onPressed,
    super.key,
    this._icon,
    this.textAlign,
  }) : _variant = _AppButtonVariant.inverse,
       color = null;

  /// Creates an [AppButton] in the text style.
  const AppButton.text({
    required this.text,
    this.onPressed,
    super.key,
    this._icon,
    this.textAlign,
    this.color,
  }) : _variant = _AppButtonVariant.text;

  /// Creates an [AppButton] in the fab style.
  const AppButton.fab({
    required IconData this._icon,
    this.onPressed,
    super.key,
  }) : _variant = _AppButtonVariant.fab,
       text = '',
       textAlign = null,
       color = null;

  /// The text of this widget.
  final String text;

  /// The onPressed of this widget.
  final VoidCallback? onPressed;
  final IconData? _icon;
  final TextAlign? textAlign;
  final Color? color;
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
        Flexible(
          child: Text(text, textAlign: textAlign),
        ),
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
        style: TextButton.styleFrom(foregroundColor: color),
        child: label,
      ),
      _AppButtonVariant.fab => throw UnimplementedError(), // Handled above
    };
  }
}
