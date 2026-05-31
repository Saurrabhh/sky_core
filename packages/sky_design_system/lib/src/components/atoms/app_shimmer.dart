import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// A reusable skeleton loader (Shimmer) atom widget.
///
/// Used to display a premium pulsing load state that matches the theme's color
/// schemes out-of-the-box.
class AppShimmer extends StatelessWidget {
  /// Renders a pulsing shimmer block or custom child.
  const AppShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.child,
    this.baseColor,
    this.highlightColor,
  });

  /// Convenience constructor to render a circular shimmer skeleton.
  const AppShimmer.circle({
    required double size,
    super.key,
    this.baseColor,
    this.highlightColor,
  }) : width = size,
       height = size,
       borderRadius = const BorderRadius.all(Radius.circular(AppRadius.full)),
       child = null;

  /// The width of the shimmer box (ignored if [child] is provided).
  final double? width;

  /// The height of the shimmer box (ignored if [child] is provided).
  final double? height;

  /// The border radius of the shimmer box (ignored if [child] is provided).
  final BorderRadiusGeometry? borderRadius;

  /// An optional child to overlay the shimmer on (e.g. text or complex shape).
  final Widget? child;

  /// The primary background pulsing color of the shimmer.
  final Color? baseColor;

  /// The sweeping highlight color of the shimmer.
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final resolvedBase = baseColor ?? colorScheme.surfaceContainerHigh;
    final resolvedHighlight =
        highlightColor ?? colorScheme.surfaceContainerLowest;

    final shimmerChild =
        child ??
        Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          decoration: BoxDecoration(
            color: resolvedBase,
            borderRadius: borderRadius,
          ),
        );

    return Shimmer.fromColors(
      baseColor: resolvedBase,
      highlightColor: resolvedHighlight,
      child: shimmerChild,
    );
  }
}
