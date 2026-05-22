import 'package:flutter/material.dart';

class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value,
      // later fix
      // ignore: deprecated_member_use
      groupValue: groupValue,
      // later fix
      // ignore: deprecated_member_use
      onChanged: onChanged,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
