import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.title,
    super.key,
    this._subtitle,
    this._leadingIcon,
    this._trailingIcon,
    this.trailingWidget,
    this.onTap,
  });

  final String title;
  final String? _subtitle;
  final IconData? _leadingIcon;
  final IconData? _trailingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: _subtitle != null ? Text(_subtitle) : null,
      leading: _leadingIcon != null ? AppIcon.md(_leadingIcon) : null,
      trailing:
          trailingWidget ??
          (_trailingIcon != null ? AppIcon.md(_trailingIcon) : null),
      onTap: onTap,
    );
  }
}
