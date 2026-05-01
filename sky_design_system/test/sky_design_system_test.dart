import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:flutter/material.dart';

void main() {
  test('AppTheme.light() creates a valid Material 3 theme', () {
    final theme = AppTheme.light(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, AppColors.primaryLight);
  });

  test('AppTheme.dark() creates a valid Material 3 theme', () {
    final theme = AppTheme.dark(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, AppColors.primaryDark);
  });
}
