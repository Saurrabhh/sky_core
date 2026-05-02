import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/border_radius.dart';

/// Small Extra-Small rounded surfaces for providing context on long-press or hover.
class AppTooltip extends StatelessWidget {
  const AppTooltip({required this.message, required this.child, super.key});

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      textStyle: context.textTheme.labelSmall?.copyWith(
        color: context.colorScheme.onInverseSurface,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.inverseSurface,
        borderRadius: AppBorderRadius.sm,
      ),
      child: child,
    );
  }
}
