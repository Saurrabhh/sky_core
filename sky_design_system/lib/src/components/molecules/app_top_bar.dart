import 'package:flutter/material.dart';
import '../../extensions.dart';

/// A standardized app bar for the design system.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.bottom,
    this.centerTitle = false,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          color: context.colorScheme.onSurface,
        ),
      ),
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      bottom: bottom,
      backgroundColor: context.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: context.colorScheme.onSurface),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
