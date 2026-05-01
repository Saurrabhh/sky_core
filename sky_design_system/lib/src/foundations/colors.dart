import 'package:flutter/material.dart';

/// Default color tokens for the Core Logic Visual Language.
class CoreColors {
  CoreColors._();

  static const Color surface = Color(0xFFFAF8FD);
  static const Color surfaceDim = Color(0xFFDBD9DE);
  static const Color surfaceBright = Color(0xFFFAF8FD);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF5F3F7);
  static const Color surfaceContainer = Color(0xFFEFEDF2);
  static const Color surfaceContainerHigh = Color(0xFFE9E7EC);
  static const Color surfaceContainerHighest = Color(0xFFE3E2E6);
  static const Color onSurface = Color(0xFF1B1B1F);
  static const Color onSurfaceVariant = Color(0xFF414751);
  static const Color inverseSurface = Color(0xFF303034);
  static const Color inverseOnSurface = Color(0xFFF2F0F4);
  static const Color outline = Color(0xFF727783);
  static const Color outlineVariant = Color(0xFFC1C6D3);
  static const Color surfaceTint = Color(0xFF005FAF);
  static const Color primary = Color(0xFF004786);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF005FAF);
  static const Color onPrimaryContainer = Color(0xFFC4DAFF);
  static const Color inversePrimary = Color(0xFFA5C8FF);
  static const Color secondary = Color(0xFF525F70);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFD3E1F5);
  static const Color onSecondaryContainer = Color(0xFF576475);
  static const Color tertiary = Color(0xFF52405F);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF6B5778);
  static const Color onTertiaryContainer = Color(0xFFE9D0F7);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
  static const Color background = Color(0xFFFAF8FD);
  static const Color onBackground = Color(0xFF1B1B1F);
  static const Color surfaceVariant = Color(0xFFE3E2E6);

  /// Default Light ColorScheme for Core Logic Visual Language.
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerLowest: surfaceContainerLowest,
    surfaceContainerLow: surfaceContainerLow,
    surfaceContainer: surfaceContainer,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainerHighest: surfaceContainerHighest,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: inverseSurface,
    onInverseSurface: inverseOnSurface,
    inversePrimary: inversePrimary,
    surfaceTint: surfaceTint,
  );
}
