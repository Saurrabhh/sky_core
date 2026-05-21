import 'package:flutter/material.dart';

/// A standardized navigation drawer for responsive layouts.
class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.children,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      children: children,
    );
  }
}
