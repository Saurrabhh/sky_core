import 'package:flutter/material.dart';

/// Shape tokens for the Core Logic Visual Language.
class CoreShapes {
  CoreShapes._();

  static const double smRadius = 4;
  static const double baseRadius = 8;
  static const double mdRadius = 12;
  static const double lgRadius = 16;
  static const double xlRadius = 24;
  static const double fullRadius = 9999;

  static const BorderRadius sm = BorderRadius.all(Radius.circular(smRadius));
  static const BorderRadius base = BorderRadius.all(Radius.circular(baseRadius));
  static const BorderRadius md = BorderRadius.all(Radius.circular(mdRadius));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(lgRadius));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(xlRadius));
  static const BorderRadius full = BorderRadius.all(Radius.circular(fullRadius));
}
