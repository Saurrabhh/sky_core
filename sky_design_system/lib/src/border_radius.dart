import 'package:flutter/material.dart';
import 'radius.dart';

/// Border radius tokens for the Core Logic Visual Language.
class CoreBorderRadius {
  CoreBorderRadius._();

  static const BorderRadius sm = BorderRadius.all(
    Radius.circular(CoreRadius.sm),
  );
  static const BorderRadius base = BorderRadius.all(
    Radius.circular(CoreRadius.base),
  );
  static const BorderRadius md = BorderRadius.all(
    Radius.circular(CoreRadius.md),
  );
  static const BorderRadius lg = BorderRadius.all(
    Radius.circular(CoreRadius.lg),
  );
  static const BorderRadius xl = BorderRadius.all(
    Radius.circular(CoreRadius.xl),
  );
  static const BorderRadius full = BorderRadius.all(
    Radius.circular(CoreRadius.full),
  );
}
