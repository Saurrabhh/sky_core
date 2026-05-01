import 'package:flutter/material.dart';

/// Default color tokens for the Core Logic Visual Language.
class AppColors {
  AppColors._();

  // Light Mode Tokens
  static const Color surfaceLight = Color(0xFFFAF8FD);
  static const Color surfaceDimLight = Color(0xFFDBD9DE);
  static const Color surfaceBrightLight = Color(0xFFFAF8FD);
  static const Color surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowLight = Color(0xFFF5F3F7);
  static const Color surfaceContainerLight = Color(0xFFEFEDF2);
  static const Color surfaceContainerHighLight = Color(0xFFE9E7EC);
  static const Color surfaceContainerHighestLight = Color(0xFFE3E2E6);
  static const Color onSurfaceLight = Color(0xFF1B1B1F);
  static const Color onSurfaceVariantLight = Color(0xFF414751);
  static const Color inverseSurfaceLight = Color(0xFF303034);
  static const Color inverseOnSurfaceLight = Color(0xFFF2F0F4);
  static const Color outlineLight = Color(0xFF727783);
  static const Color outlineVariantLight = Color(0xFFC1C6D3);
  static const Color surfaceTintLight = Color(0xFF005FAF);
  static const Color primaryLight = Color(0xFF004786);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color primaryContainerLight = Color(0xFF005FAF);
  static const Color onPrimaryContainerLight = Color(0xFFC4DAFF);
  static const Color inversePrimaryLight = Color(0xFFA5C8FF);
  static const Color secondaryLight = Color(0xFF525F70);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color secondaryContainerLight = Color(0xFFD3E1F5);
  static const Color onSecondaryContainerLight = Color(0xFF576475);
  static const Color tertiaryLight = Color(0xFF52405F);
  static const Color onTertiaryLight = Color(0xFFFFFFFF);
  static const Color tertiaryContainerLight = Color(0xFF6B5778);
  static const Color onTertiaryContainerLight = Color(0xFFE9D0F7);
  static const Color errorLight = Color(0xFFBA1A1A);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color errorContainerLight = Color(0xFFFFDAD6);
  static const Color onErrorContainerLight = Color(0xFF93000A);
  static const Color backgroundLight = Color(0xFFFAF8FD);
  static const Color onBackgroundLight = Color(0xFF1B1B1F);
  static const Color surfaceVariantLight = Color(0xFFE3E2E6);

  // Dark Mode Tokens
  static const Color surfaceDark = Color(0xFF121316);
  static const Color surfaceDimDark = Color(0xFF121316);
  static const Color surfaceBrightDark = Color(0xFF38393D);
  static const Color surfaceContainerLowestDark = Color(0xFF0D0E11);
  static const Color surfaceContainerLowDark = Color(0xFF1B1B1F);
  static const Color surfaceContainerDark = Color(0xFF1F1F23);
  static const Color surfaceContainerHighDark = Color(0xFF292A2D);
  static const Color surfaceContainerHighestDark = Color(0xFF343438);
  static const Color onSurfaceDark = Color(0xFFE3E2E6);
  static const Color onSurfaceVariantDark = Color(0xFFC1C6D3);
  static const Color inverseSurfaceDark = Color(0xFFE3E2E6);
  static const Color inverseOnSurfaceDark = Color(0xFF303034);
  static const Color outlineDark = Color(0xFF8B919D);
  static const Color outlineVariantDark = Color(0xFF414751);
  static const Color surfaceTintDark = Color(0xFFA5C8FF);
  static const Color primaryDark = Color(0xFFA5C8FF);
  static const Color onPrimaryDark = Color(0xFF00315F);
  static const Color primaryContainerDark = Color(0xFF005FAF);
  static const Color onPrimaryContainerDark = Color(0xFFC4DAFF);
  static const Color inversePrimaryDark = Color(0xFF005FAF);
  static const Color secondaryDark = Color(0xFFBAC8DB);
  static const Color onSecondaryDark = Color(0xFF243141);
  static const Color secondaryContainerDark = Color(0xFF3D4A5A);
  static const Color onSecondaryContainerDark = Color(0xFFACB9CD);
  static const Color tertiaryDark = Color(0xFFD6BEE4);
  static const Color onTertiaryDark = Color(0xFF3B2947);
  static const Color tertiaryContainerDark = Color(0xFF6B5778);
  static const Color onTertiaryContainerDark = Color(0xFFE9D0F7);
  static const Color errorDark = Color(0xFFFFB4AB);
  static const Color onErrorDark = Color(0xFF690005);
  static const Color errorContainerDark = Color(0xFF93000A);
  static const Color onErrorContainerDark = Color(0xFFFFDAD6);
  static const Color backgroundDark = Color(0xFF121316);
  static const Color onBackgroundDark = Color(0xFFE3E2E6);
  static const Color surfaceVariantDark = Color(0xFF343438);

  // Common Fixed Tokens (Consistent across themes)
  static const Color primaryFixed = Color(0xFFD4E3FF);
  static const Color primaryFixedDim = Color(0xFFA5C8FF);
  static const Color onPrimaryFixed = Color(0xFF001C3A);
  static const Color onPrimaryFixedVariant = Color(0xFF004786);
  static const Color secondaryFixed = Color(0xFFD6E4F8);
  static const Color secondaryFixedDim = Color(0xFFBAC8DB);
  static const Color onSecondaryFixed = Color(0xFF0F1C2B);
  static const Color onSecondaryFixedVariant = Color(0xFF3B4858);
  static const Color tertiaryFixed = Color(0xFFF3DAFF);
  static const Color tertiaryFixedDim = Color(0xFFD6BEE4);
  static const Color onTertiaryFixed = Color(0xFF251431);
  static const Color onTertiaryFixedVariant = Color(0xFF523F5F);

  /// Default Light ColorScheme for Core Logic Visual Language.
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryLight,
    onPrimary: onPrimaryLight,
    primaryContainer: primaryContainerLight,
    onPrimaryContainer: onPrimaryContainerLight,
    secondary: secondaryLight,
    onSecondary: onSecondaryLight,
    secondaryContainer: secondaryContainerLight,
    onSecondaryContainer: onSecondaryContainerLight,
    tertiary: tertiaryLight,
    onTertiary: onTertiaryLight,
    tertiaryContainer: tertiaryContainerLight,
    onTertiaryContainer: onTertiaryContainerLight,
    error: errorLight,
    onError: onErrorLight,
    errorContainer: errorContainerLight,
    onErrorContainer: onErrorContainerLight,
    surface: surfaceLight,
    onSurface: onSurfaceLight,
    surfaceContainerLowest: surfaceContainerLowestLight,
    surfaceContainerLow: surfaceContainerLowLight,
    surfaceContainer: surfaceContainerLight,
    surfaceContainerHigh: surfaceContainerHighLight,
    surfaceContainerHighest: surfaceContainerHighestLight,
    onSurfaceVariant: onSurfaceVariantLight,
    outline: outlineLight,
    outlineVariant: outlineVariantLight,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: inverseSurfaceLight,
    onInverseSurface: inverseOnSurfaceLight,
    inversePrimary: inversePrimaryLight,
    surfaceTint: surfaceTintLight,
    primaryFixed: primaryFixed,
    primaryFixedDim: primaryFixedDim,
    onPrimaryFixed: onPrimaryFixed,
    onPrimaryFixedVariant: onPrimaryFixedVariant,
    secondaryFixed: secondaryFixed,
    secondaryFixedDim: secondaryFixedDim,
    onSecondaryFixed: onSecondaryFixed,
    onSecondaryFixedVariant: onSecondaryFixedVariant,
    tertiaryFixed: tertiaryFixed,
    tertiaryFixedDim: tertiaryFixedDim,
    onTertiaryFixed: onTertiaryFixed,
    onTertiaryFixedVariant: onTertiaryFixedVariant,
    surfaceDim: surfaceDimLight,
    surfaceBright: surfaceBrightLight,
  );

  /// Default Dark ColorScheme for Core Logic Visual Language.
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryDark,
    onPrimary: onPrimaryDark,
    primaryContainer: primaryContainerDark,
    onPrimaryContainer: onPrimaryContainerDark,
    secondary: secondaryDark,
    onSecondary: onSecondaryDark,
    secondaryContainer: secondaryContainerDark,
    onSecondaryContainer: onSecondaryContainerDark,
    tertiary: tertiaryDark,
    onTertiary: onTertiaryDark,
    tertiaryContainer: tertiaryContainerDark,
    onTertiaryContainer: onTertiaryContainerDark,
    error: errorDark,
    onError: onErrorDark,
    errorContainer: errorContainerDark,
    onErrorContainer: onErrorContainerDark,
    surface: surfaceDark,
    onSurface: onSurfaceDark,
    surfaceContainerLowest: surfaceContainerLowestDark,
    surfaceContainerLow: surfaceContainerLowDark,
    surfaceContainer: surfaceContainerDark,
    surfaceContainerHigh: surfaceContainerHighDark,
    surfaceContainerHighest: surfaceContainerHighestDark,
    onSurfaceVariant: onSurfaceVariantDark,
    outline: outlineDark,
    outlineVariant: outlineVariantDark,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: inverseSurfaceDark,
    onInverseSurface: inverseOnSurfaceDark,
    inversePrimary: inversePrimaryDark,
    surfaceTint: surfaceTintDark,
    primaryFixed: primaryFixed,
    primaryFixedDim: primaryFixedDim,
    onPrimaryFixed: onPrimaryFixed,
    onPrimaryFixedVariant: onPrimaryFixedVariant,
    secondaryFixed: secondaryFixed,
    secondaryFixedDim: secondaryFixedDim,
    onSecondaryFixed: onSecondaryFixed,
    onSecondaryFixedVariant: onSecondaryFixedVariant,
    tertiaryFixed: tertiaryFixed,
    tertiaryFixedDim: tertiaryFixedDim,
    onTertiaryFixed: onTertiaryFixed,
    onTertiaryFixedVariant: onTertiaryFixedVariant,
    surfaceDim: surfaceDimDark,
    surfaceBright: surfaceBrightDark,
  );
}
