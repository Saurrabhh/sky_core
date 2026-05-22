import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
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
