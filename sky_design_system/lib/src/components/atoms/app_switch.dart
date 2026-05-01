import 'package:flutter/material.dart';
import '../../extensions.dart';

/// A standard toggle for binary states.
class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.value, required this.onChanged});

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
