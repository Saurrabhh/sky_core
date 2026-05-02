import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide easy access to the design system's
/// theme and foundational tokens.
extension SkyDesignSystemContextExtension on BuildContext {
  /// Returns the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Returns the current [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the current [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Returns the primary color of the current [ColorScheme].
  Color get primaryColor => colorScheme.primary;

  /// Returns the secondary color of the current [ColorScheme].
  Color get secondaryColor => colorScheme.secondary;

  /// Returns the surface color of the current [ColorScheme].
  Color get surfaceColor => colorScheme.surface;

  /// Returns the error color of the current [ColorScheme].
  Color get errorColor => colorScheme.error;
}
