import 'package:flutter/material.dart';

enum _AppProgressVariant { circular, linear }

/// A unified progress indicator component.
class AppProgressIndicator extends StatelessWidget {
  /// Creates a circular progress indicator.
  const AppProgressIndicator.circular({super.key, this.value})
    : _variant = _AppProgressVariant.circular;

  /// Creates a linear progress indicator.
  const AppProgressIndicator.linear({super.key, this.value})
    : _variant = _AppProgressVariant.linear;

  final double? value;
  final _AppProgressVariant _variant;

  @override
  Widget build(BuildContext context) {
    return switch (_variant) {
      _AppProgressVariant.circular => CircularProgressIndicator(value: value),
      _AppProgressVariant.linear => LinearProgressIndicator(value: value),
    };
  }
}
