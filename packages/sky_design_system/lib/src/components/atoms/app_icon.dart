import 'package:flutter/material.dart';

/// A widget for displaying system icons with standard sizes.
class AppIcon extends StatelessWidget {
  /// Creates an [AppIcon] in the sm style.
  const AppIcon.sm(
    this.icon, {
    super.key,
    this.color,
  }) : _size = 18;

  /// Creates an [AppIcon] in the md style.
  const AppIcon.md(
    this.icon, {
    super.key,
    this.color,
  }) : _size = 24;

  /// Creates an [AppIcon] in the lg style.
  const AppIcon.lg(
    this.icon, {
    super.key,
    this.color,
  }) : _size = 32;

  /// The icon of this widget.
  final IconData icon;
  /// The color of this widget.
  final Color? color;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: _size,
      color: color,
    );
  }
}
