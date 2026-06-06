import 'package:flutter/material.dart';

/// A bottom navigation bar widget.
class AppNavigationBar extends StatelessWidget {
  /// Creates an [AppNavigationBar] instance.
  const AppNavigationBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
  });

  /// The selectedIndex of this widget.
  final int selectedIndex;

  /// The onDestinationSelected of this widget.
  final ValueChanged<int> onDestinationSelected;

  /// The destinations of this widget.
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}
