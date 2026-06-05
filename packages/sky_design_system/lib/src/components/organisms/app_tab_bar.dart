import 'package:flutter/material.dart';

/// A tab bar container widget.
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates an [AppTabBar] instance.
  const AppTabBar({
    required this.tabs,
    super.key,
    this.controller,
    this.isScrollable = false,
  });

  /// The tabs of this widget.
  final List<Widget> tabs;
  /// The controller of this widget.
  final TabController? controller;
  /// The isScrollable of this widget.
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      isScrollable: isScrollable,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
