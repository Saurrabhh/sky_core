import 'package:flutter/material.dart';
import 'foundations/colors.dart';
import 'foundations/typography.dart';
import 'foundations/border_radius.dart';
import 'foundations/spacing.dart';

/// The main theme factory for the Core Logic Visual Language.
class AppTheme {
  AppTheme._();

  /// Generates the Light [ThemeData] for the design system.
  static ThemeData light({
    ColorScheme? customColorScheme,
    bool useGoogleFonts = true,
  }) {
    return _buildTheme(
      customColorScheme ?? AppColors.lightColorScheme,
      useGoogleFonts: useGoogleFonts,
    );
  }

  /// Generates the Dark [ThemeData] for the design system.
  static ThemeData dark({
    ColorScheme? customColorScheme,
    bool useGoogleFonts = true,
  }) {
    return _buildTheme(
      customColorScheme ?? AppColors.darkColorScheme,
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
          side: BorderSide(color: colorScheme.outline, width: 1),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.full,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.sm,
          borderSide: BorderSide(color: colorScheme.outline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.sm,
          borderSide: BorderSide(color: colorScheme.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.sm,
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
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),

      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.md,
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
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
