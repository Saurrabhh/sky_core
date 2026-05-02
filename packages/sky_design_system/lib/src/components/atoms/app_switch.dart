import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';

/// A standard toggle for binary states.
class AppSwitch extends StatelessWidget {
  const AppSwitch({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: context.colorScheme.primary,
    );
  }
}
