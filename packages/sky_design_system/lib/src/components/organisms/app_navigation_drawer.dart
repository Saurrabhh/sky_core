import 'package:flutter/material.dart';

/// A sidebar drawer navigation widget.
class AppNavigationDrawer extends StatelessWidget {
  /// Creates an [AppNavigationDrawer] instance.
  const AppNavigationDrawer({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.children,
    super.key,
  });

  /// The selectedIndex of this widget.
  final int selectedIndex;

  /// The onDestinationSelected of this widget.
  final ValueChanged<int> onDestinationSelected;

  /// The children of this widget.
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
