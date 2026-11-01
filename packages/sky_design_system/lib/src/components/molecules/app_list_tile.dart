import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// A single fixed-height row that contains text and optional icons.
class AppListTile extends StatelessWidget {
  /// Creates an [AppListTile] instance.
  const AppListTile({
    required this.title,
    super.key,
    this._subtitle,
    this._leadingIcon,
    this._trailingIcon,
    this._leadingWidget,
    this._trailingWidget,
    this._titleColor,
    this._leadingIconColor,
    this.onTap,
  });

  /// The title of this widget.
  final String title;
  final String? _subtitle;
  final IconData? _leadingIcon;
  final IconData? _trailingIcon;
  final Widget? _leadingWidget;
  final Widget? _trailingWidget;
  final Color? _titleColor;
  final Color? _leadingIconColor;

  /// The onTap of this widget.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText.bodyLarge(
        title,
        color: _titleColor,
      ),
      subtitle: _subtitle != null
          ? AppText.bodyMedium(
              _subtitle,
              color: context.colorScheme.onSurfaceVariant,
            )
          : null,
      leading:
          _leadingWidget ??
          (_leadingIcon != null
              ? AppIcon.md(_leadingIcon, color: _leadingIconColor)
              : null),
      trailing:
          _trailingWidget ??
          (_trailingIcon != null ? AppIcon.md(_trailingIcon) : null),
      onTap: onTap,
    );
  }
}
