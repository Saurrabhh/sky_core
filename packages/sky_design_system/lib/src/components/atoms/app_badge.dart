import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.child,
    super.key,
    this._count,
    this.isDot = false,
  });

  final Widget child;
  final int? _count;
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
