import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/app_color_scheme.dart';

/// Default color tokens for the Core Logic Visual Language.
class AppColors {
  const AppColors._();

  // ==========================================
  // Private Light Mode Colors (from design.md)
  // ==========================================
  static const Color _surfaceLight = Color(0xFFF8F9FF);
  static const Color _surfaceDimLight = Color(0xFFD8DAE0);
  static const Color _surfaceBrightLight = Color(0xFFF8F9FF);
  static const Color _surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const Color _surfaceContainerLowLight = Color(0xFFF2F3FA);
  static const Color _surfaceContainerLight = Color(0xFFECEEF4);
  static const Color _surfaceContainerHighLight = Color(0xFFE6E8EE);
  static const Color _surfaceContainerHighestLight = Color(0xFFE1E2E8);
  static const Color _onSurfaceLight = Color(0xFF191C20);
  static const Color _onSurfaceVariantLight = Color(0xFF414750);
  static const Color _inverseSurfaceLight = Color(0xFF2E3135);
  static const Color _inverseOnSurfaceLight = Color(0xFFEFF0F7);
  static const Color _outlineLight = Color(0xFF717782);
  static const Color _outlineVariantLight = Color(0xFFC1C7D2);
  static const Color _surfaceTintLight = Color(0xFF0061A4);
  static const Color _primaryLight = Color(0xFF00497D);
  static const Color _onPrimaryLight = Color(0xFFFFFFFF);
  static const Color _primaryContainerLight = Color(0xFF0061A4);
  static const Color _onPrimaryContainerLight = Color(0xFFC0DBFF);
  static const Color _inversePrimaryLight = Color(0xFF9FCAFF);
  static const Color _secondaryLight = Color(0xFF535F70);
  static const Color _onSecondaryLight = Color(0xFFFFFFFF);
  static const Color _secondaryContainerLight = Color(0xFFD7E3F8);
  static const Color _onSecondaryContainerLight = Color(0xFF596576);
  static const Color _tertiaryLight = Color(0xFF52405F);
  static const Color _onTertiaryLight = Color(0xFFFFFFFF);
  static const Color _tertiaryContainerLight = Color(0xFF6B5778);
  static const Color _onTertiaryContainerLight = Color(0xFFE9D0F7);
  static const Color _errorLight = Color(0xFFBA1A1A);
  static const Color _onErrorLight = Color(0xFFFFFFFF);
  static const Color _errorContainerLight = Color(0xFFFFDAD6);
  static const Color _onErrorContainerLight = Color(0xFF93000A);
  static const Color _primaryFixedLight = Color(0xFFD1E4FF);
  static const Color _primaryFixedDimLight = Color(0xFF9FCAFF);
  static const Color _onPrimaryFixedLight = Color(0xFF001D36);
  static const Color _onPrimaryFixedVariantLight = Color(0xFF00497D);
  static const Color _secondaryFixedLight = Color(0xFFD7E3F8);
  static const Color _secondaryFixedDimLight = Color(0xFFBBC7DB);
  static const Color _onSecondaryFixedLight = Color(0xFF101C2B);
  static const Color _onSecondaryFixedVariantLight = Color(0xFF3C4858);
  static const Color _tertiaryFixedLight = Color(0xFFF3DAFF);
  static const Color _tertiaryFixedDimLight = Color(0xFFD6BEE4);
  static const Color _onTertiaryFixedLight = Color(0xFF251431);
  static const Color _onTertiaryFixedVariantLight = Color(0xFF523F5F);
  static const Color _backgroundLight = Color(0xFFF8F9FF);
  static const Color _onBackgroundLight = Color(0xFF191C20);
  static const Color _surfaceVariantLight = Color(0xFFE1E2E8);

  // ==========================================
  // Private Dark Mode Colors (from design_dark.md)
  // ==========================================
  static const Color _surfaceDark = Color(0xFF111418);
  static const Color _surfaceDimDark = Color(0xFF111418);
  static const Color _surfaceBrightDark = Color(0xFF36393E);
  static const Color _surfaceContainerLowestDark = Color(0xFF0B0E13);
  static const Color _surfaceContainerLowDark = Color(0xFF191C20);
  static const Color _surfaceContainerDark = Color(0xFF1D2024);
  static const Color _surfaceContainerHighDark = Color(0xFF272A2F);
  static const Color _surfaceContainerHighestDark = Color(0xFF32353A);
  static const Color _onSurfaceDark = Color(0xFFE1E2E8);
  static const Color _onSurfaceVariantDark = Color(0xFFC1C7D2);
  static const Color _inverseSurfaceDark = Color(0xFFE1E2E8);
  static const Color _inverseOnSurfaceDark = Color(0xFF2E3135);
  static const Color _outlineDark = Color(0xFF8B919C);
  static const Color _outlineVariantDark = Color(0xFF414750);
  static const Color _surfaceTintDark = Color(0xFF9FCAFF);
  static const Color _primaryDark = Color(0xFF9FCAFF);
  static const Color _onPrimaryDark = Color(0xFF003258);
  static const Color _primaryContainerDark = Color(0xFF0061A4);
  static const Color _onPrimaryContainerDark = Color(0xFFC0DBFF);
  static const Color _inversePrimaryDark = Color(0xFF0061A4);
  static const Color _secondaryDark = Color(0xFFBBC7DB);
  static const Color _onSecondaryDark = Color(0xFF253141);
  static const Color _secondaryContainerDark = Color(0xFF3E4A5A);
  static const Color _onSecondaryContainerDark = Color(0xFFADB9CD);
  static const Color _tertiaryDark = Color(0xFFD6BEE4);
  static const Color _onTertiaryDark = Color(0xFF3B2947);
  static const Color _tertiaryContainerDark = Color(0xFF6B5778);
  static const Color _onTertiaryContainerDark = Color(0xFFE9D0F7);
  static const Color _errorDark = Color(0xFFFFB4AB);
  static const Color _onErrorDark = Color(0xFF690005);
  static const Color _errorContainerDark = Color(0xFF93000A);
  static const Color _onErrorContainerDark = Color(0xFFFFDAD6);
  static const Color _primaryFixedDark = Color(0xFFD1E4FF);
  static const Color _primaryFixedDimDark = Color(0xFF9FCAFF);
  static const Color _onPrimaryFixedDark = Color(0xFF001D36);
  static const Color _onPrimaryFixedVariantDark = Color(0xFF00497D);
  static const Color _secondaryFixedDark = Color(0xFFD7E3F8);
  static const Color _secondaryFixedDimDark = Color(0xFFBBC7DB);
  static const Color _onSecondaryFixedDark = Color(0xFF101C2B);
  static const Color _onSecondaryFixedVariantDark = Color(0xFF3C4858);
  static const Color _tertiaryFixedDark = Color(0xFFF3DAFF);
  static const Color _tertiaryFixedDimDark = Color(0xFFD6BEE4);
  static const Color _onTertiaryFixedDark = Color(0xFF251431);
  static const Color _onTertiaryFixedVariantDark = Color(0xFF523F5F);
  static const Color _backgroundDark = Color(0xFF111418);
  static const Color _onBackgroundDark = Color(0xFFE1E2E8);
  static const Color _surfaceVariantDark = Color(0xFF32353A);

  /// Standard light mode scheme from design.md
  static const AppColorScheme light = AppColorScheme(
    surface: _surfaceLight,
    surfaceDim: _surfaceDimLight,
    surfaceBright: _surfaceBrightLight,
    surfaceContainerLowest: _surfaceContainerLowestLight,
    surfaceContainerLow: _surfaceContainerLowLight,
    surfaceContainer: _surfaceContainerLight,
    surfaceContainerHigh: _surfaceContainerHighLight,
    surfaceContainerHighest: _surfaceContainerHighestLight,
    onSurface: _onSurfaceLight,
    onSurfaceVariant: _onSurfaceVariantLight,
    inverseSurface: _inverseSurfaceLight,
    inverseOnSurface: _inverseOnSurfaceLight,
    outline: _outlineLight,
    outlineVariant: _outlineVariantLight,
    surfaceTint: _surfaceTintLight,
    primary: _primaryLight,
    onPrimary: _onPrimaryLight,
    primaryContainer: _primaryContainerLight,
    onPrimaryContainer: _onPrimaryContainerLight,
    inversePrimary: _inversePrimaryLight,
    secondary: _secondaryLight,
    onSecondary: _onSecondaryLight,
    secondaryContainer: _secondaryContainerLight,
    onSecondaryContainer: _onSecondaryContainerLight,
    tertiary: _tertiaryLight,
    onTertiary: _onTertiaryLight,
    tertiaryContainer: _tertiaryContainerLight,
    onTertiaryContainer: _onTertiaryContainerLight,
    error: _errorLight,
    onError: _onErrorLight,
    errorContainer: _errorContainerLight,
    onErrorContainer: _onErrorContainerLight,
    primaryFixed: _primaryFixedLight,
    primaryFixedDim: _primaryFixedDimLight,
    onPrimaryFixed: _onPrimaryFixedLight,
    onPrimaryFixedVariant: _onPrimaryFixedVariantLight,
    secondaryFixed: _secondaryFixedLight,
    secondaryFixedDim: _secondaryFixedDimLight,
    onSecondaryFixed: _onSecondaryFixedLight,
    onSecondaryFixedVariant: _onSecondaryFixedVariantLight,
    tertiaryFixed: _tertiaryFixedLight,
    tertiaryFixedDim: _tertiaryFixedDimLight,
    onTertiaryFixed: _onTertiaryFixedLight,
    onTertiaryFixedVariant: _onTertiaryFixedVariantLight,
    background: _backgroundLight,
    onBackground: _onBackgroundLight,
    surfaceVariant: _surfaceVariantLight,
  );

  /// Standard dark mode scheme from design_dark.md
  static const AppColorScheme dark = AppColorScheme(
    surface: _surfaceDark,
    surfaceDim: _surfaceDimDark,
    surfaceBright: _surfaceBrightDark,
    surfaceContainerLowest: _surfaceContainerLowestDark,
    surfaceContainerLow: _surfaceContainerLowDark,
    surfaceContainer: _surfaceContainerDark,
    surfaceContainerHigh: _surfaceContainerHighDark,
    surfaceContainerHighest: _surfaceContainerHighestDark,
    onSurface: _onSurfaceDark,
    onSurfaceVariant: _onSurfaceVariantDark,
    inverseSurface: _inverseSurfaceDark,
    inverseOnSurface: _inverseOnSurfaceDark,
    outline: _outlineDark,
    outlineVariant: _outlineVariantDark,
    surfaceTint: _surfaceTintDark,
    primary: _primaryDark,
    onPrimary: _onPrimaryDark,
    primaryContainer: _primaryContainerDark,
    onPrimaryContainer: _onPrimaryContainerDark,
    inversePrimary: _inversePrimaryDark,
    secondary: _secondaryDark,
    onSecondary: _onSecondaryDark,
    secondaryContainer: _secondaryContainerDark,
    onSecondaryContainer: _onSecondaryContainerDark,
    tertiary: _tertiaryDark,
    onTertiary: _onTertiaryDark,
    tertiaryContainer: _tertiaryContainerDark,
    onTertiaryContainer: _onTertiaryContainerDark,
    error: _errorDark,
    onError: _onErrorDark,
    errorContainer: _errorContainerDark,
    onErrorContainer: _onErrorContainerDark,
    primaryFixed: _primaryFixedDark,
    primaryFixedDim: _primaryFixedDimDark,
    onPrimaryFixed: _onPrimaryFixedDark,
    onPrimaryFixedVariant: _onPrimaryFixedVariantDark,
    secondaryFixed: _secondaryFixedDark,
    secondaryFixedDim: _secondaryFixedDimDark,
    onSecondaryFixed: _onSecondaryFixedDark,
    onSecondaryFixedVariant: _onSecondaryFixedVariantDark,
    tertiaryFixed: _tertiaryFixedDark,
    tertiaryFixedDim: _tertiaryFixedDimDark,
    onTertiaryFixed: _onTertiaryFixedDark,
    onTertiaryFixedVariant: _onTertiaryFixedVariantDark,
    background: _backgroundDark,
    onBackground: _onBackgroundDark,
    surfaceVariant: _surfaceVariantDark,
  );
}
