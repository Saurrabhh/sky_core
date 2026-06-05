import 'package:flutter/material.dart';

/// A tooltip wrapper widget.
class AppTooltip extends StatelessWidget {
  /// Creates an [AppTooltip] instance.
  const AppTooltip({required this.message, required this.child, super.key});

  /// The message of this widget.
  final String message;
  /// The child of this widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: child,
    );
  }
}
