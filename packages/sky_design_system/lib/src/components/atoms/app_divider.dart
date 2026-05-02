import 'package:flutter/material.dart';

enum _AppDividerVariant { horizontal, vertical }

/// A unified divider component for structural separation.
class AppDivider extends StatelessWidget {
  /// Creates a horizontal divider.
  const AppDivider.horizontal({super.key})
    : _variant = _AppDividerVariant.horizontal;

  /// Creates a vertical divider.
  const AppDivider.vertical({super.key})
    : _variant = _AppDividerVariant.vertical;

  final _AppDividerVariant _variant;

  @override
  Widget build(BuildContext context) {
    return switch (_variant) {
      _AppDividerVariant.horizontal => const Divider(height: 1, thickness: 1),
      _AppDividerVariant.vertical => const VerticalDivider(
        width: 1,
        thickness: 1,
      ),
    };
  }
}
