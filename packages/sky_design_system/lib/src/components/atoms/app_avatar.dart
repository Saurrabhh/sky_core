import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// An avatar widget displaying initials, an icon, or a background image.
class AppAvatar extends StatelessWidget {
  /// Creates an [AppAvatar] instance.
  const AppAvatar({
    super.key,
    this.initials,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.radius = AppRadius.lgIncreased,
  }) : icon = null;

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

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (backgroundImage == null) {
      if (initials != null && initials!.isNotEmpty) {
        child = FittedBox(child: Text(initials!));
      } else if (icon != null) {
        child = radius >= AppRadius.xl
            ? AppIcon.lg(icon!)
            : AppIcon.md(icon!);
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: backgroundImage,
      onBackgroundImageError: onBackgroundImageError,
      child: child,
    );
  }
}
