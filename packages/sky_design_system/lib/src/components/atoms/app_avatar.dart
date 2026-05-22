import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/app_radius.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.initials,
    this.backgroundImage,
    this.radius = AppRadius.lgIncreased,
  });

  final String? initials;
  final ImageProvider? backgroundImage;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: backgroundImage,
      child: backgroundImage == null && initials != null
          ? FittedBox(child: Text(initials ?? ''))
          : null,
    );
  }
}
