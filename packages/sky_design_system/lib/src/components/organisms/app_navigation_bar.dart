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
    this.elevation,
    this.backgroundColor,
    this.surfaceTintColor,
    this.shadowColor,
    this.indicatorColor,
    this.labelBehavior = NavigationDestinationLabelBehavior.alwaysShow,
  })  : _isFloating = false,
        margin = 0,
        borderRadius = BorderRadius.zero;

  /// Creates a pill-shaped floating [AppNavigationBar].
  ///
  /// The bar floats above the bottom of the screen with [margin] from
  /// screen edges and [borderRadius] curvature. All visual properties
  /// (elevation, color, shadow) are passed through to [NavigationBar].
  const AppNavigationBar.floating({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
    this.margin = AppSpacing.marginMobile,
    this.borderRadius = AppBorderRadius.xl,
    this.elevation,
    this.backgroundColor,
    this.surfaceTintColor,
    this.shadowColor,
    this.indicatorColor,
    this.labelBehavior = NavigationDestinationLabelBehavior.alwaysShow,
  }) : _isFloating = true;

  /// The currently selected destination index.
  final int selectedIndex;

  /// Called when a destination is selected.
  final ValueChanged<int> onDestinationSelected;

  /// The list of navigation destinations to display.
  final List<NavigationDestination> destinations;

  /// The elevation of the navigation bar.
  ///
  /// Passed directly to [NavigationBar]. Only effective for the floating
  /// variant when it provides visual depth.
  final double? elevation;

  /// The background color of the navigation bar.
  ///
  /// Passed directly to [NavigationBar].
  final Color? backgroundColor;

  /// The surface tint color of the navigation bar.
  ///
  /// Passed directly to [NavigationBar].
  final Color? surfaceTintColor;

  /// The shadow color of the navigation bar.
  ///
  /// Passed directly to [NavigationBar].
  final Color? shadowColor;

  /// The indicator color for the selected destination.
  ///
  /// Passed directly to [NavigationBar].
  final Color? indicatorColor;

  /// The label display behavior for destinations.
  ///
  /// Defaults to [NavigationDestinationLabelBehavior.alwaysShow].
  final NavigationDestinationLabelBehavior labelBehavior;

  /// Horizontal and bottom margin from screen edges (floating variant only).
  ///
  /// Defaults to [AppSpacing.marginMobile] (16dp).
  final double margin;

  /// Border radius for the pill shape (floating variant only).
  ///
  /// Defaults to [AppBorderRadius.xl] (28dp).
  final BorderRadius borderRadius;

  final bool _isFloating;

  Widget _buildNavigationBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
      labelBehavior: labelBehavior,
      elevation: elevation,
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      shadowColor: shadowColor,
      indicatorColor: indicatorColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFloating) {
      return _buildNavigationBar(context);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: margin,
        right: margin,
        bottom: margin,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: _buildNavigationBar(context),
      ),
    );
  }
}
