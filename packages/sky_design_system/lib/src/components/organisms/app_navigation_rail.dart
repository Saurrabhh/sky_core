import 'package:flutter/material.dart';

class AppNavigationRail extends StatelessWidget {
  const AppNavigationRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
    this.leading,
    this.trailing,
    this.extended = false,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationRailDestination> destinations;
  final Widget? leading;
  final Widget? trailing;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
      leading: leading,
      trailing: trailing,
      extended: extended,
      labelType: extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      useIndicator: true,
    );
  }
}
