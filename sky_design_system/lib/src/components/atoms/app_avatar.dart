import 'package:flutter/material.dart';
import '../../extensions.dart';

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
          ? Text(
              initials!,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
            )
          : null,
    );
  }
}
