import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  group('AppRadius', () {
    test('constants have correct double values', () {
      expect(AppRadius.xs, 4.0);
      expect(AppRadius.sm, 8.0);
      expect(AppRadius.md, 8.0);
      expect(AppRadius.lg, 16.0);
      expect(AppRadius.lgIncreased, 20.0);
      expect(AppRadius.xl, 28.0);
      expect(AppRadius.xlIncreased, 32.0);
      expect(AppRadius.xxl, 48.0);
      expect(AppRadius.full, 9999.0);
    });
  });
}
