import 'package:flutter/material.dart';

/// A wrapper for the Material Checkbox ensuring a minimum 48dp hit target.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.isError = false,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      isError: isError,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
