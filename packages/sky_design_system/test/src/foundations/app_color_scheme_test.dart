import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  group('AppColorScheme', () {
    const baseScheme = AppColorScheme(
      surface: Colors.white,
      surfaceDim: Colors.grey,
      surfaceBright: Colors.white,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Colors.white,
      surfaceContainer: Colors.white,
      surfaceContainerHigh: Colors.white,
      surfaceContainerHighest: Colors.white,
      onSurface: Colors.black,
      onSurfaceVariant: Colors.black45,
      inverseSurface: Colors.black,
      onInverseSurface: Colors.white,
      outline: Colors.black26,
      outlineVariant: Colors.black12,
      surfaceTint: Colors.blue,
      primary: Colors.blue,
      onPrimary: Colors.white,
      primaryContainer: Colors.blue,
      onPrimaryContainer: Colors.black,
      inversePrimary: Colors.lightBlue,
      secondary: Colors.green,
      onSecondary: Colors.white,
      secondaryContainer: Colors.green,
      onSecondaryContainer: Colors.black,
      tertiary: Colors.orange,
      onTertiary: Colors.white,
      tertiaryContainer: Colors.orange,
      onTertiaryContainer: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      errorContainer: Colors.red,
      onErrorContainer: Colors.black,
      primaryFixed: Colors.blue,
      primaryFixedDim: Colors.blue,
      onPrimaryFixed: Colors.black,
      onPrimaryFixedVariant: Colors.black,
      secondaryFixed: Colors.green,
      secondaryFixedDim: Colors.green,
      onSecondaryFixed: Colors.black,
      onSecondaryFixedVariant: Colors.black,
      tertiaryFixed: Colors.orange,
      tertiaryFixedDim: Colors.orange,
      onTertiaryFixed: Colors.black,
      onTertiaryFixedVariant: Colors.black,
      background: Colors.white,
      onBackground: Colors.black,
      surfaceVariant: Colors.white,
    );

    test('constructor and properties work correctly', () {
      expect(baseScheme.surface, Colors.white);
      expect(baseScheme.primary, Colors.blue);
      expect(baseScheme.onPrimary, Colors.white);
      expect(baseScheme.secondary, Colors.green);
      expect(baseScheme.error, Colors.red);
    });

    test('copyWith works with partial values and no values', () {
      final identityCopy = baseScheme.copyWith();
      expect(identityCopy.surface, baseScheme.surface);
      expect(identityCopy.primary, baseScheme.primary);
      expect(identityCopy.onPrimary, baseScheme.onPrimary);

      final customCopy = baseScheme.copyWith(
        surface: Colors.red,
        primary: Colors.amber,
      );
      expect(customCopy.surface, Colors.red);
      expect(customCopy.primary, Colors.amber);
      expect(customCopy.onPrimary, baseScheme.onPrimary); // remains unchanged
    });

    test('merge handles null and overrides correctly', () {
      final mergedNull = baseScheme.merge(null);
      expect(mergedNull, baseScheme);

      const overrideScheme = AppColorScheme(
        surface: Colors.black,
        surfaceDim: Colors.black,
        surfaceBright: Colors.black,
        surfaceContainerLowest: Colors.black,
        surfaceContainerLow: Colors.black,
        surfaceContainer: Colors.black,
        surfaceContainerHigh: Colors.black,
        surfaceContainerHighest: Colors.black,
        onSurface: Colors.white,
        onSurfaceVariant: Colors.white,
        inverseSurface: Colors.white,
        onInverseSurface: Colors.black,
        outline: Colors.white,
        outlineVariant: Colors.white,
        surfaceTint: Colors.red,
        primary: Colors.red,
        onPrimary: Colors.black,
        primaryContainer: Colors.black,
        onPrimaryContainer: Colors.white,
        inversePrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        secondaryContainer: Colors.black,
        onSecondaryContainer: Colors.white,
        tertiary: Colors.black,
        onTertiary: Colors.white,
        tertiaryContainer: Colors.black,
        onTertiaryContainer: Colors.white,
        error: Colors.purple,
        onError: Colors.white,
        errorContainer: Colors.black,
        onErrorContainer: Colors.white,
        primaryFixed: Colors.red,
        primaryFixedDim: Colors.red,
        onPrimaryFixed: Colors.white,
        onPrimaryFixedVariant: Colors.white,
        secondaryFixed: Colors.black,
        secondaryFixedDim: Colors.black,
        onSecondaryFixed: Colors.white,
        onSecondaryFixedVariant: Colors.white,
        tertiaryFixed: Colors.black,
        tertiaryFixedDim: Colors.black,
        onTertiaryFixed: Colors.white,
        onTertiaryFixedVariant: Colors.white,
        background: Colors.black,
        onBackground: Colors.white,
        surfaceVariant: Colors.black,
      );

      final merged = baseScheme.merge(overrideScheme);
      expect(merged.primary, Colors.red);
      expect(merged.surface, Colors.black);
      expect(merged.error, Colors.purple);
    });

    test('toColorScheme returns valid Material 3 ColorScheme with correct mappings', () {
      final colorScheme = baseScheme.toColorScheme(Brightness.light);

      expect(colorScheme.brightness, Brightness.light);
      expect(colorScheme.primary, baseScheme.primary);
      expect(colorScheme.onPrimary, baseScheme.onPrimary);
      expect(colorScheme.primaryContainer, baseScheme.primaryContainer);
      expect(colorScheme.onPrimaryContainer, baseScheme.onPrimaryContainer);
      expect(colorScheme.secondary, baseScheme.secondary);
      expect(colorScheme.onSecondary, baseScheme.onSecondary);
      expect(colorScheme.secondaryContainer, baseScheme.secondaryContainer);
      expect(colorScheme.onSecondaryContainer, baseScheme.onSecondaryContainer);
      expect(colorScheme.tertiary, baseScheme.tertiary);
      expect(colorScheme.onTertiary, baseScheme.onTertiary);
      expect(colorScheme.tertiaryContainer, baseScheme.tertiaryContainer);
      expect(colorScheme.onTertiaryContainer, baseScheme.onTertiaryContainer);
      expect(colorScheme.error, baseScheme.error);
      expect(colorScheme.onError, baseScheme.onError);
      expect(colorScheme.errorContainer, baseScheme.errorContainer);
      expect(colorScheme.onErrorContainer, baseScheme.onErrorContainer);
      expect(colorScheme.surface, baseScheme.surface);
      expect(colorScheme.onSurface, baseScheme.onSurface);
      expect(colorScheme.surfaceContainerLowest, baseScheme.surfaceContainerLowest);
      expect(colorScheme.surfaceContainerLow, baseScheme.surfaceContainerLow);
      expect(colorScheme.surfaceContainer, baseScheme.surfaceContainer);
      expect(colorScheme.surfaceContainerHigh, baseScheme.surfaceContainerHigh);
      expect(colorScheme.surfaceContainerHighest, baseScheme.surfaceContainerHighest);
      expect(colorScheme.onSurfaceVariant, baseScheme.onSurfaceVariant);
      expect(colorScheme.outline, baseScheme.outline);
      expect(colorScheme.outlineVariant, baseScheme.outlineVariant);
      expect(colorScheme.inverseSurface, baseScheme.inverseSurface);
      expect(colorScheme.onInverseSurface, baseScheme.onInverseSurface);
      expect(colorScheme.inversePrimary, baseScheme.inversePrimary);
      expect(colorScheme.surfaceTint, baseScheme.surfaceTint);
      expect(colorScheme.primaryFixed, baseScheme.primaryFixed);
      expect(colorScheme.primaryFixedDim, baseScheme.primaryFixedDim);
      expect(colorScheme.onPrimaryFixed, baseScheme.onPrimaryFixed);
      expect(colorScheme.onPrimaryFixedVariant, baseScheme.onPrimaryFixedVariant);
      expect(colorScheme.secondaryFixed, baseScheme.secondaryFixed);
      expect(colorScheme.secondaryFixedDim, baseScheme.secondaryFixedDim);
      expect(colorScheme.onSecondaryFixed, baseScheme.onSecondaryFixed);
      expect(colorScheme.onSecondaryFixedVariant, baseScheme.onSecondaryFixedVariant);
      expect(colorScheme.tertiaryFixed, baseScheme.tertiaryFixed);
      expect(colorScheme.tertiaryFixedDim, baseScheme.tertiaryFixedDim);
      expect(colorScheme.onTertiaryFixed, baseScheme.onTertiaryFixed);
      expect(colorScheme.onTertiaryFixedVariant, baseScheme.onTertiaryFixedVariant);
      expect(colorScheme.surfaceDim, baseScheme.surfaceDim);
      expect(colorScheme.surfaceBright, baseScheme.surfaceBright);
    });
  });
}
