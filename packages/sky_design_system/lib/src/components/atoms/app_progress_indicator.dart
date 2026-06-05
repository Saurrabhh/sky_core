import 'package:flutter/material.dart';

enum _AppProgressVariant { circular, linear }

/// A linear or circular progress indicator.
class AppProgressIndicator extends StatelessWidget {
  /// Creates an [AppProgressIndicator] in the circular style.
  const AppProgressIndicator.circular({super.key, this.value})
    : _variant = _AppProgressVariant.circular;

  /// Creates an [AppProgressIndicator] in the linear style.
  const AppProgressIndicator.linear({super.key, this.value})
    : _variant = _AppProgressVariant.linear;

  /// The value of this widget.
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
