import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  group('AppBorderRadius', () {
    test('constants return correct BorderRadius values', () {
      expect(
        AppBorderRadius.xs,
        const BorderRadius.all(Radius.circular(AppRadius.xs)),
      );
      expect(
        AppBorderRadius.sm,
        const BorderRadius.all(Radius.circular(AppRadius.sm)),
      );
      expect(
        AppBorderRadius.md,
        const BorderRadius.all(Radius.circular(AppRadius.md)),
      );
      expect(
        AppBorderRadius.lg,
        const BorderRadius.all(Radius.circular(AppRadius.lg)),
      );
      expect(
        AppBorderRadius.lgIncreased,
        const BorderRadius.all(Radius.circular(AppRadius.lgIncreased)),
      );
      expect(
        AppBorderRadius.xl,
        const BorderRadius.all(Radius.circular(AppRadius.xl)),
      );
      expect(
        AppBorderRadius.xlIncreased,
        const BorderRadius.all(Radius.circular(AppRadius.xlIncreased)),
      );
      expect(
        AppBorderRadius.xxl,
        const BorderRadius.all(Radius.circular(AppRadius.xxl)),
      );
      expect(
        AppBorderRadius.full,
        const BorderRadius.all(Radius.circular(AppRadius.full)),
      );
    });
  });
}
