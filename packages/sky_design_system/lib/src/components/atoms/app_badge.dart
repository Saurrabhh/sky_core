import 'package:flutter/material.dart';

/// A badge widget that displays an optional count or status dot.
class AppBadge extends StatelessWidget {
  /// Creates an [AppBadge] instance.
  const AppBadge({
    required this.child,
    super.key,
    this._count,
    this.isDot = false,
  });

  /// The child of this widget.
  final Widget child;
  final int? _count;
  /// The isDot of this widget.
  final bool isDot;

  @override
  Widget build(BuildContext context) {
    if (isDot) {
      return Badge(smallSize: 8, child: child);
    }

    return Badge(
      label: _count != null ? Text(_count.toString()) : null,
      isLabelVisible: _count != null && _count > 0,
      child: child,
    );
  }
}
