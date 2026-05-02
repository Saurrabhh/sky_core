import 'package:flutter/material.dart';
import '../../extensions.dart';

/// A standardized navigation rail for tablet and desktop layouts.
class AppNavigationRail extends StatelessWidget {
  const AppNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
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
      backgroundColor: context.colorScheme.surface,
      indicatorColor: context.colorScheme.secondaryContainer,
      labelType: extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      useIndicator: true,
    );
  }
}
