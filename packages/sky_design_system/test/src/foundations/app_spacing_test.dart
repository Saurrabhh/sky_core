import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  group('AppSpacing', () {
    test('constants have correct double values', () {
      expect(AppSpacing.none, 0.0);
      expect(AppSpacing.xs, 4.0);
      expect(AppSpacing.sm, 8.0);
      expect(AppSpacing.md, 16.0);
      expect(AppSpacing.lg, 24.0);
      expect(AppSpacing.xl, 32.0);
      expect(AppSpacing.xxl, 48.0);
      expect(AppSpacing.gutter, 16.0);
      expect(AppSpacing.marginMobile, 16.0);
      expect(AppSpacing.marginTablet, 24.0);
      expect(AppSpacing.marginDesktop, 32.0);
    });
  });
}
