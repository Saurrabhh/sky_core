import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// A single fixed-height row that contains text and optional icons.
class AppListTile extends StatelessWidget {
  /// Creates an [AppListTile] instance.
  const AppListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingWidget,
    this.trailingWidget,
    this.titleColor,
    this.leadingIconColor,
    this.onTap,
  });

  /// The title of this widget.
  final String title;

  /// The subtitle of this widget.
  final String? subtitle;

  /// The leading icon of this widget.
  final IconData? leadingIcon;

  /// The trailing icon of this widget.
  final IconData? trailingIcon;

  /// The leading widget of this widget (takes precedence over [leadingIcon]).
  final Widget? leadingWidget;

  /// The trailing widget of this widget.
  final Widget? trailingWidget;

  /// The title color of this widget.
  final Color? titleColor;

  /// The leading icon color of this widget.
  final Color? leadingIconColor;

  /// The onTap of this widget.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText.bodyLarge(
        title,
        color: titleColor,
      ),
      subtitle: subtitle != null
          ? AppText.bodyMedium(
              subtitle!,
              color: context.colorScheme.onSurfaceVariant,
            )
          : null,
      leading: leadingWidget ??
          (leadingIcon != null
              ? AppIcon.md(leadingIcon!, color: leadingIconColor)
              : null),
      trailing: trailingWidget ??
          (trailingIcon != null ? AppIcon.md(trailingIcon!) : null),
      onTap: onTap,
    );
  }
}
