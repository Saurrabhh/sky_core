import 'package:flutter/material.dart';

extension SkyDesignSystemContextExtension on BuildContext {
  ColorScheme get colorScheme => ColorScheme.of(this);

  TextTheme get textTheme => TextTheme.of(this);

  CardThemeData get cardTheme => CardTheme.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}
