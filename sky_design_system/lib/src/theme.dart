import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'border_radius.dart';
import 'spacing.dart';

/// The main theme factory for the Core Logic Visual Language.
class CoreTheme {
  CoreTheme._();

  /// Generates the Light [ThemeData] for the design system.
  static ThemeData light([ColorScheme? customColorScheme]) {
    final colorScheme = customColorScheme ?? CoreColors.lightColorScheme;
    final textTheme = CoreTypography.textTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          shape: const RoundedRectangleBorder(
            borderRadius: CoreBorderRadius.full,
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
            borderRadius: CoreBorderRadius.full,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: CoreBorderRadius.sm,
          borderSide: BorderSide(color: colorScheme.outline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: CoreBorderRadius.sm,
          borderSide: BorderSide(color: colorScheme.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: CoreBorderRadius.sm,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: textTheme.labelMedium,
        floatingLabelStyle: textTheme.labelSmall,
        helperStyle: textTheme.labelSmall,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: CoreSpacing.md,
          vertical: CoreSpacing.sm,
        ),
      ),

      chipTheme: ChipThemeData(
        shape: const RoundedRectangleBorder(borderRadius: CoreBorderRadius.sm),
        labelStyle: textTheme.labelMedium,
        backgroundColor: colorScheme.surfaceContainerLow,
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        padding: const EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm,
          vertical: CoreSpacing.xs,
        ),
      ),

      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: CoreSpacing.md),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: CoreBorderRadius.md,
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        color: colorScheme.surface,
        margin: const EdgeInsets.all(CoreSpacing.sm),
      ),

      checkboxTheme: CheckboxThemeData(
        shape: const RoundedRectangleBorder(borderRadius: CoreBorderRadius.sm),
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
    );
  }
}
