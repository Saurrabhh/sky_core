import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon.sm(
    this.icon, {
    super.key,
    this.color,
  }) : _size = 18;

  const AppIcon.md(
    this.icon, {
    super.key,
    this.color,
  }) : _size = 24;

  const AppIcon.lg(
    this.icon, {
    super.key,
    this.color,
  }) : _size = 32;

  final IconData icon;
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
