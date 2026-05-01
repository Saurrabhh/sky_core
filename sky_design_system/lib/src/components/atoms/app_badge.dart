import 'package:flutter/material.dart';

/// A wrapper around Material Badge for numerical or status indicators.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.child,
    this.count,
    this.isDot = false,
  });

  final Widget child;
  final int? count;
  final bool isDot;

  @override
  Widget build(BuildContext context) {
    if (isDot) {
      return Badge(smallSize: 8, child: child);
    }

    return Badge(
      label: count != null ? Text(count.toString()) : null,
      isLabelVisible: count != null && count! > 0,
      child: child,
    );
  }
}
