import 'package:flutter/material.dart';
import '../atoms/app_icon.dart';
import '../atoms/app_text.dart';

/// The backbone list item for the design system.
class AppListItem extends StatelessWidget {
  const AppListItem({
    super.key,
    required this.title,
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
      title: AppText.titleMedium(title),
      subtitle: subtitle != null ? AppText.bodySmall(subtitle!) : null,
      leading: leadingIcon != null ? AppIcon(leadingIcon!) : null,
      trailing:
          trailingWidget ??
          (trailingIcon != null ? AppIcon(trailingIcon!) : null),
      onTap: onTap,
    );
  }
}
