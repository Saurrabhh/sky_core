import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// An avatar widget displaying initials, an icon, or a background image.
class AppAvatar extends StatelessWidget {
  /// Creates an [AppAvatar] displaying initials.
  const AppAvatar.initials({
    required this.initials,
    super.key,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.radius = AppRadius.lgIncreased,
  }) : icon = null;

  /// Creates an [AppAvatar] displaying an icon.
  const AppAvatar.icon({
    required this.icon,
    super.key,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.radius = AppRadius.lgIncreased,
  }) : initials = null;

  /// The initials of this widget.
  final String? initials;

  /// The icon of this widget.
  final IconData? icon;

  /// The backgroundImage of this widget.
  final ImageProvider? backgroundImage;

  /// The onBackgroundImageError callback of this widget.
  final ImageErrorListener? onBackgroundImageError;

  /// The radius of this widget.
  final double radius;

  Widget? _buildChild() {
    if (backgroundImage != null) return null;

    if (initials case final i? when i.isNotEmpty) {
      return FittedBox(child: Text(i));
    }

    if (icon case final ic?) {
      return radius >= AppRadius.xl ? AppIcon.lg(ic) : AppIcon.md(ic);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: backgroundImage,
      onBackgroundImageError: onBackgroundImageError,
      child: _buildChild(),
    );
  }
}
