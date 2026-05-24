import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('AppTheme', () {
    test('light() creates a valid Material 3 light theme', () {
      final theme = AppTheme.light(useGoogleFonts: false);
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, AppColors.light.primary);
      expect(theme.colorScheme.surface, AppColors.light.surface);
      expect(theme.colorScheme.error, AppColors.light.error);
    });

    test('dark() creates a valid Material 3 dark theme', () {
      final theme = AppTheme.dark(useGoogleFonts: false);
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.primary, AppColors.dark.primary);
      expect(theme.colorScheme.surface, AppColors.dark.surface);
      expect(theme.colorScheme.error, AppColors.dark.error);
    });

    test(
      'customColorScheme parameter overrides default colors in light() and '
          'dark()',
      () {
        const customScheme = AppColorScheme(
          surface: Colors.red,
          surfaceDim: Colors.red,
          surfaceBright: Colors.red,
          surfaceContainerLowest: Colors.red,
          surfaceContainerLow: Colors.red,
          surfaceContainer: Colors.red,
          surfaceContainerHigh: Colors.red,
          surfaceContainerHighest: Colors.red,
          onSurface: Colors.white,
          onSurfaceVariant: Colors.white,
          inverseSurface: Colors.white,
          onInverseSurface: Colors.red,
          outline: Colors.white,
          outlineVariant: Colors.white,
          surfaceTint: Colors.amber,
          primary: Colors.amber,
          onPrimary: Colors.red,
          primaryContainer: Colors.red,
          onPrimaryContainer: Colors.white,
          inversePrimary: Colors.red,
          secondary: Colors.red,
          onSecondary: Colors.white,
          secondaryContainer: Colors.red,
          onSecondaryContainer: Colors.white,
          tertiary: Colors.red,
          onTertiary: Colors.white,
          tertiaryContainer: Colors.red,
          onTertiaryContainer: Colors.white,
          error: Colors.purple,
          onError: Colors.white,
          errorContainer: Colors.red,
          onErrorContainer: Colors.white,
          primaryFixed: Colors.amber,
          primaryFixedDim: Colors.amber,
          onPrimaryFixed: Colors.white,
          onPrimaryFixedVariant: Colors.white,
          secondaryFixed: Colors.red,
          secondaryFixedDim: Colors.red,
          onSecondaryFixed: Colors.white,
          onSecondaryFixedVariant: Colors.white,
          tertiaryFixed: Colors.red,
          tertiaryFixedDim: Colors.red,
          onTertiaryFixed: Colors.white,
          onTertiaryFixedVariant: Colors.white,
          background: Colors.red,
          onBackground: Colors.white,
          surfaceVariant: Colors.red,
        );

        final lightTheme = AppTheme.light(
          customColorScheme: customScheme,
          useGoogleFonts: false,
        );
        expect(lightTheme.colorScheme.primary, Colors.amber);
        expect(lightTheme.colorScheme.surface, Colors.red);
        expect(lightTheme.colorScheme.error, Colors.purple);

        final darkTheme = AppTheme.dark(
          customColorScheme: customScheme,
          useGoogleFonts: false,
        );
        expect(darkTheme.colorScheme.primary, Colors.amber);
        expect(darkTheme.colorScheme.surface, Colors.red);
        expect(darkTheme.colorScheme.error, Colors.purple);
      },
    );

    test('useGoogleFonts toggles text theme configurations correctly', () {
      final systemFontsTheme = AppTheme.light(useGoogleFonts: false);
      expect(
        systemFontsTheme.textTheme.displayLarge?.fontFamily,
        isNot(contains('Inter')),
      );
    });

    test(
      'sub-themes (buttons, chips, lists, fields) are properly configured',
      () {
        final theme = AppTheme.light(useGoogleFonts: false);

        // 1. Elevated button theme
        expect(
          theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
          AppColors.light.primary,
        );
        expect(
          theme.elevatedButtonTheme.style?.foregroundColor?.resolve({}),
          AppColors.light.onPrimary,
        );
        expect(theme.elevatedButtonTheme.style?.elevation?.resolve({}), 0);

        // 2. Outlined button theme
        expect(
          theme.outlinedButtonTheme.style?.foregroundColor?.resolve({}),
          AppColors.light.primary,
        );
        expect(
          theme.outlinedButtonTheme.style?.side?.resolve({}),
          BorderSide(color: AppColors.light.outline),
        );

        // 3. Input Decoration theme
        expect(theme.inputDecorationTheme.filled, isFalse);
        expect(
          theme.inputDecorationTheme.contentPadding,
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        );

        // 4. Chip theme
        expect(
          theme.chipTheme.backgroundColor,
          AppColors.light.surfaceContainerLow,
        );
        expect(
          theme.chipTheme.side,
          BorderSide(color: AppColors.light.outlineVariant),
        );

        // 5. List Tile theme
        expect(
          theme.listTileTheme.contentPadding,
          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        );

        // 6. Card theme
        expect(theme.cardTheme.elevation, 0);
        expect(theme.cardTheme.color, AppColors.light.surface);

        // 7. Checkbox theme selected state
        expect(
          theme.checkboxTheme.fillColor?.resolve({WidgetState.selected}),
          AppColors.light.primary,
        );
        expect(theme.checkboxTheme.fillColor?.resolve({}), isNull);

        // 8. Radio theme selected state
        expect(
          theme.radioTheme.fillColor?.resolve({WidgetState.selected}),
          AppColors.light.primary,
        );
        expect(theme.radioTheme.fillColor?.resolve({}), isNull);

        // 9. Text and Icon button themes
        expect(
          theme.textButtonTheme.style?.foregroundColor?.resolve({}),
          AppColors.light.primary,
        );

        // 10. AppBar and Dialog themes
        expect(theme.appBarTheme.elevation, 0);
        expect(theme.appBarTheme.backgroundColor, AppColors.light.surface);
        expect(theme.appBarTheme.foregroundColor, AppColors.light.onSurface);

        // 11. Bottom Sheet theme
        expect(theme.bottomSheetTheme.showDragHandle, isTrue);
        expect(theme.bottomSheetTheme.backgroundColor, AppColors.light.surface);
        expect(theme.bottomSheetTheme.elevation, 1.0);

        // 12. Date Picker theme
        expect(
          theme.datePickerTheme.backgroundColor,
          AppColors.light.surfaceContainerHigh,
        );
        expect(theme.datePickerTheme.weekdayStyle?.fontWeight, FontWeight.bold);
        expect(
          theme.datePickerTheme.dayForegroundColor?.resolve({
            WidgetState.selected,
          }),
          AppColors.light.onPrimary,
        );
        expect(
          theme.datePickerTheme.dayForegroundColor?.resolve({
            WidgetState.disabled,
          }),
          AppColors.light.onSurface.withValues(alpha: 0.38),
        );
        expect(
          theme.datePickerTheme.dayBackgroundColor?.resolve({
            WidgetState.selected,
          }),
          AppColors.light.primary,
        );
        expect(
          theme.datePickerTheme.dayBackgroundColor?.resolve({}),
          Colors.transparent,
        );

        // 13. Time Picker theme
        expect(
          theme.timePickerTheme.backgroundColor,
          AppColors.light.surfaceContainerHigh,
        );
        expect(
          theme.timePickerTheme.hourMinuteColor,
          AppColors.light.surfaceContainerHighest,
        );
        expect(
          theme.timePickerTheme.hourMinuteTextColor,
          AppColors.light.onSurface,
        );
        expect(theme.timePickerTheme.dialHandColor, AppColors.light.primary);
      },
    );
  });
}
