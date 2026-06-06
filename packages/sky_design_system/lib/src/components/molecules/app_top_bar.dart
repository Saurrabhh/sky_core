import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// A header bar for screens.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates an [AppTopBar] instance.
  const AppTopBar({
    required this.title,
    super.key,
    this.actions,
    this.leading,
    this.bottom,
    this.centerTitle = false,
    this.titleColor,
  });

  /// The title of this widget.
  final String title;

  /// The actions of this widget.
  final List<Widget>? actions;

  /// The leading of this widget.
  final Widget? leading;

  /// The bottom of this widget.
  final PreferredSizeWidget? bottom;

  /// The centerTitle of this widget.
  final bool centerTitle;

  /// The color of title text.
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.appBarTheme.titleTextStyle?.copyWith(color: titleColor),
      ),
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
