import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/app_radius.dart';

/// An avatar widget displaying initials or a background image.
class AppAvatar extends StatelessWidget {
  /// Creates an [AppAvatar] instance.
  const AppAvatar({
    super.key,
    this.initials,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.child,
    this.backgroundColor,
    this.radius = AppRadius.lgIncreased,
  });

  /// The initials of this widget.
  final String? initials;

  /// The backgroundImage of this widget.
  final ImageProvider? backgroundImage;

  /// The onBackgroundImageError of this widget.
  final ImageErrorListener? onBackgroundImageError;

  /// The child widget of this avatar.
  final Widget? child;

  /// The background color of this avatar.
  final Color? backgroundColor;

  /// The radius of this widget.
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      onBackgroundImageError: onBackgroundImageError,
      child: child ??
          (backgroundImage == null && initials != null
              ? FittedBox(child: Text(initials ?? ''))
              : null),
    );
  }
}
