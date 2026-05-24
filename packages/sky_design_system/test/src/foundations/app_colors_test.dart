import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  group('AppColors', () {
    test('light has correct color properties', () {
      expect(AppColors.light.surface, const Color(0xFFF8F9FF));
      expect(AppColors.light.primary, const Color(0xFF00497D));
      expect(AppColors.light.onPrimary, const Color(0xFFFFFFFF));
      expect(AppColors.light.secondary, const Color(0xFF535F70));
      expect(AppColors.light.error, const Color(0xFFBA1A1A));
      expect(AppColors.light.background, const Color(0xFFF8F9FF));
    });

    test('dark has correct color properties', () {
      expect(AppColors.dark.surface, const Color(0xFF111418));
      expect(AppColors.dark.primary, const Color(0xFF9FCAFF));
      expect(AppColors.dark.onPrimary, const Color(0xFF003258));
      expect(AppColors.dark.secondary, const Color(0xFFBBC7DB));
      expect(AppColors.dark.error, const Color(0xFFFFB4AB));
      expect(AppColors.dark.background, const Color(0xFF111418));
    });
  });
}
