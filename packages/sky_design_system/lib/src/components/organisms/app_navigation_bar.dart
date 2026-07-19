import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/foundations.dart';

/// A bottom navigation bar widget.
///
/// Use the default constructor for a standard full-width navigation bar,
/// or [AppNavigationBar.floating] for a pill-shaped floating variant.
class AppNavigationBar extends StatelessWidget {
  /// Creates a standard full-width [AppNavigationBar].
  const AppNavigationBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
    this.labelBehavior = NavigationDestinationLabelBehavior.alwaysShow,
  }) : _isFloating = false;

  /// Creates a pill-shaped floating [AppNavigationBar].
  ///
  /// The bar floats above the bottom of the screen with horizontal margin
  /// from screen edges and rounded corners. All visual properties
  /// (elevation, color, shadow) are passed through to [NavigationBar].
  const AppNavigationBar.floating({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
    this.labelBehavior = NavigationDestinationLabelBehavior.alwaysShow,
  }) : _isFloating = true;

  /// The currently selected destination index.
  final int selectedIndex;

  /// Called when a destination is selected.
  final ValueChanged<int> onDestinationSelected;

  /// The list of navigation destinations to display.
  final List<NavigationDestination> destinations;

  /// The label display behavior for destinations.
  ///
  /// Defaults to [NavigationDestinationLabelBehavior.alwaysShow].
  final NavigationDestinationLabelBehavior labelBehavior;

  final bool _isFloating;

  @override
  Widget build(BuildContext context) {
    final child = NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
      labelBehavior: labelBehavior,
    );

    if (!_isFloating) {
      return child;
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.xxl,
        right: AppSpacing.xxl,
        bottom: AppSpacing.lg,
      ),
      child: ClipRRect(
        borderRadius: AppBorderRadius.full,
        child: child,
      ),
    );
  }
}
