import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/app_color_scheme.dart';
import 'package:sky_design_system/src/foundations/border_radius.dart';
import 'package:sky_design_system/src/foundations/colors.dart';
import 'package:sky_design_system/src/foundations/spacing.dart';
import 'package:sky_design_system/src/foundations/typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light({
    AppColorScheme? customColorScheme,
    bool useGoogleFonts = true,
  }) {
    final activeScheme = AppColors.light.merge(customColorScheme);
    return _buildTheme(
      activeScheme.toColorScheme(Brightness.light),
      useGoogleFonts: useGoogleFonts,
    );
  }

  static ThemeData dark({
    AppColorScheme? customColorScheme,
    bool useGoogleFonts = true,
  }) {
    final activeScheme = AppColors.dark.merge(customColorScheme);
    return _buildTheme(
      activeScheme.toColorScheme(Brightness.dark),
      useGoogleFonts: useGoogleFonts,
    );
  }

  static ThemeData _buildTheme(
    ColorScheme colorScheme, {
    required bool useGoogleFonts,
  }) {
    final textTheme = useGoogleFonts
        ? AppTypography.textTheme
        : ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.full,
          ),
          textStyle: textTheme.labelLarge,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.full,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: textTheme.labelMedium,
        floatingLabelStyle: textTheme.labelSmall,
        helperStyle: textTheme.labelSmall,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.sm),
        labelStyle: textTheme.labelMedium,
        backgroundColor: colorScheme.surfaceContainerLow,
        side: BorderSide(color: colorScheme.outlineVariant),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        shape: const RoundedRectangleBorder(),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.md,
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        color: colorScheme.surface,
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.sm),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.full,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
    );
  }
}
