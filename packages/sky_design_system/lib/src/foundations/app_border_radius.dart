import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/app_radius.dart';

/// Design system token values for [BorderRadius].
class AppBorderRadius {
  const AppBorderRadius._();

  /// Extra-small border radius (4dp circular).
  static const BorderRadius xs = BorderRadius.all(
    Radius.circular(AppRadius.xs),
  );

  /// Small border radius (8dp circular).
  static const BorderRadius sm = BorderRadius.all(
    Radius.circular(AppRadius.sm),
  );

  /// Medium border radius (8dp circular).
  static const BorderRadius md = BorderRadius.all(
    Radius.circular(AppRadius.md),
  );

  /// Large border radius (16dp circular).
  static const BorderRadius lg = BorderRadius.all(
    Radius.circular(AppRadius.lg),
  );

  /// Large increased border radius (20dp circular).
  static const BorderRadius lgIncreased = BorderRadius.all(
    Radius.circular(AppRadius.lgIncreased),
  );

  /// Extra-large border radius (28dp circular).
  static const BorderRadius xl = BorderRadius.all(
    Radius.circular(AppRadius.xl),
  );

  /// Extra-large increased border radius (32dp circular).
  static const BorderRadius xlIncreased = BorderRadius.all(
    Radius.circular(AppRadius.xlIncreased),
  );

  /// Double extra-large border radius (48dp circular).
  static const BorderRadius xxl = BorderRadius.all(
    Radius.circular(AppRadius.xxl),
  );

  /// Maximum border radius for pills or fully circular shapes.
  static const BorderRadius full = BorderRadius.all(
    Radius.circular(AppRadius.full),
  );
}
