import 'package:flutter/material.dart';

/// A wrapper for the Material Radio button ensuring a minimum 48dp hit target.
class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value,
      // ignore: deprecated_member_use
      groupValue: groupValue,
      // ignore: deprecated_member_use
      onChanged: onChanged,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
