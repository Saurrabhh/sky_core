import 'package:flutter/material.dart';

/// A sidebar rail navigation widget.
class AppNavigationRail extends StatelessWidget {
  /// Creates an [AppNavigationRail] instance.
  const AppNavigationRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
    this.leading,
    this.trailing,
    this.extended = false,
  });

  /// The selectedIndex of this widget.
  final int selectedIndex;

  /// The onDestinationSelected of this widget.
  final ValueChanged<int> onDestinationSelected;

  /// The destinations of this widget.
  final List<NavigationRailDestination> destinations;

  /// The leading of this widget.
  final Widget? leading;

  /// The trailing of this widget.
  final Widget? trailing;

  /// The extended of this widget.
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
