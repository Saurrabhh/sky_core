import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AppTypography', () {
    test('textTheme has correctly configured styles', () {
      final textTheme = AppTypography.textTheme;

      expect(textTheme.displayLarge?.fontSize, 57);
      expect(textTheme.displayLarge?.fontWeight, FontWeight.w400);

      expect(textTheme.displayMedium?.fontSize, 45);
      expect(textTheme.displayMedium?.fontWeight, FontWeight.w400);

      expect(textTheme.displaySmall?.fontSize, 36);
      expect(textTheme.displaySmall?.fontWeight, FontWeight.w400);

      expect(textTheme.headlineLarge?.fontSize, 32);
      expect(textTheme.headlineLarge?.fontWeight, FontWeight.w400);

      expect(textTheme.headlineMedium?.fontSize, 28);
      expect(textTheme.headlineMedium?.fontWeight, FontWeight.w400);

      expect(textTheme.headlineSmall?.fontSize, 24);
      expect(textTheme.headlineSmall?.fontWeight, FontWeight.w400);

      expect(textTheme.titleLarge?.fontSize, 22);
      expect(textTheme.titleLarge?.fontWeight, FontWeight.w500);

      expect(textTheme.titleMedium?.fontSize, 16);
      expect(textTheme.titleMedium?.fontWeight, FontWeight.w500);

      expect(textTheme.titleSmall?.fontSize, 14);
      expect(textTheme.titleSmall?.fontWeight, FontWeight.w500);

      expect(textTheme.bodyLarge?.fontSize, 16);
      expect(textTheme.bodyLarge?.fontWeight, FontWeight.w400);

      expect(textTheme.bodyMedium?.fontSize, 14);
      expect(textTheme.bodyMedium?.fontWeight, FontWeight.w400);

      expect(textTheme.bodySmall?.fontSize, 12);
      expect(textTheme.bodySmall?.fontWeight, FontWeight.w400);

      expect(textTheme.labelLarge?.fontSize, 14);
      expect(textTheme.labelLarge?.fontWeight, FontWeight.w500);

      expect(textTheme.labelMedium?.fontSize, 12);
      expect(textTheme.labelMedium?.fontWeight, FontWeight.w500);

      expect(textTheme.labelSmall?.fontSize, 11);
      expect(textTheme.labelSmall?.fontWeight, FontWeight.w500);
    });
  });
}
