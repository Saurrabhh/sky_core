import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_icon.dart';

/// The backbone list item for the design system.
class AppListItem extends StatelessWidget {
  const AppListItem({
    required this.title,
    super.key,
    this.subtitle,
    this.leadingIcon,
    this.trailingIcon,
    this.trailingWidget,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: leadingIcon != null ? AppIcon(leadingIcon!) : null,
      trailing:
          trailingWidget ??
          (trailingIcon != null ? AppIcon(trailingIcon!) : null),
      onTap: onTap,
    );
  }
}
