import 'package:flutter/material.dart';

/// A standard toggle switch input widget.
class AppSwitch extends StatelessWidget {
  /// Creates an [AppSwitch] instance.
  const AppSwitch({required this.value, required this.onChanged, super.key});

  /// The value of this widget.
  final bool value;

  /// The onChanged of this widget.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}
