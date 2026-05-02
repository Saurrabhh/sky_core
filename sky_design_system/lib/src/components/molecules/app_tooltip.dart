import 'package:flutter/material.dart';
import '../../extensions.dart';
import '../../foundations/border_radius.dart';

/// Small Extra-Small rounded surfaces for providing context on long-press or hover.
class AppTooltip extends StatelessWidget {
  const AppTooltip({super.key, required this.message, required this.child});

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
