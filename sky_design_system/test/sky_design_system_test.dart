import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:flutter/material.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CoreTheme.light() creates a valid Material 3 theme', () {
    final theme = CoreTheme.light();
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, CoreColors.primary);
  });
}
