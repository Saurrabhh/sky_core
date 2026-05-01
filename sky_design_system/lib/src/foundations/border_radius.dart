import 'package:flutter/material.dart';
import 'radius.dart';

/// Border radius tokens for the Core Logic Visual Language.
class AppBorderRadius {
  AppBorderRadius._();

  static const BorderRadius sm = BorderRadius.all(
    Radius.circular(AppRadius.sm),
  );
  static const BorderRadius base = BorderRadius.all(
    Radius.circular(AppRadius.base),
  );
  static const BorderRadius md = BorderRadius.all(
    Radius.circular(AppRadius.md),
  );
  static const BorderRadius lg = BorderRadius.all(
    Radius.circular(AppRadius.lg),
  );
  static const BorderRadius xl = BorderRadius.all(
    Radius.circular(AppRadius.xl),
  );
  static const BorderRadius full = BorderRadius.all(
    Radius.circular(AppRadius.full),
  );
}
