import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_text.dart';

/// A wrapper around Material Badge for numerical or status indicators.
class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.child,
    super.key,
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
      label: count != null
          ? AppText.labelSmall(count.toString(), color: Colors.white)
          : null,
      isLabelVisible: count != null && count! > 0,
      child: child,
    );
  }
}
