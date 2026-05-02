import 'package:flutter/material.dart';
import '../../extensions.dart';

/// A standardized tab bar for top-level view switching.
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
  });

  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      isScrollable: isScrollable,
      labelColor: context.colorScheme.primary,
      unselectedLabelColor: context.colorScheme.onSurfaceVariant,
      indicatorColor: context.colorScheme.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: context.textTheme.titleSmall,
      unselectedLabelStyle: context.textTheme.titleSmall,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
