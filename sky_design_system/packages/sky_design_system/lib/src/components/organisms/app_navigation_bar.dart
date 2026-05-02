import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';

/// A standardized bottom navigation bar for mobile layouts.
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    required this.selectedIndex, required this.onDestinationSelected, required this.destinations, super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
      backgroundColor: context.colorScheme.surfaceContainer,
      indicatorColor: context.colorScheme.secondaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}
