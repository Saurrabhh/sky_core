import 'package:flutter/material.dart';
import '../../extensions.dart';
import 'app_text.dart';

/// A circular container for user images or initials.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.initials,
    this.backgroundImage,
    this.radius = 20.0,
  });

  final String? initials;
  final ImageProvider? backgroundImage;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.colorScheme.primaryContainer,
      foregroundColor: context.colorScheme.onPrimaryContainer,
      backgroundImage: backgroundImage,
      child: backgroundImage == null && initials != null
          ? AppText.titleMedium(
              initials!,
              color: context.colorScheme.onPrimaryContainer,
            )
          : null,
    );
  }
}