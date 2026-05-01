import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:flutter/material.dart';

void main() {
  test('CoreTheme.light() creates a valid Material 3 theme', () {
    final theme = CoreTheme.light(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, CoreColors.primaryLight);
  });

  test('CoreTheme.dark() creates a valid Material 3 theme', () {
    final theme = CoreTheme.dark(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, CoreColors.primaryDark);
  });
}
