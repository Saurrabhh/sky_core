import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
