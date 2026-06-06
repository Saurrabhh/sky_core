import 'package:flutter/material.dart';

/// Theme and design system context extensions on [BuildContext].
extension SkyDesignSystemContextExtension on BuildContext {
  /// Returns the current [ColorScheme].
  ColorScheme get colorScheme => ColorScheme.of(this);

  /// Returns the current [TextTheme].
  TextTheme get textTheme => TextTheme.of(this);

  /// Returns the current [CardThemeData].
  CardThemeData get cardTheme => CardTheme.of(this);

  /// Returns the current [ScaffoldMessengerState].
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Returns the current [AppBarTheme].
  AppBarThemeData get appBarTheme => AppBarTheme.of(this);
}
