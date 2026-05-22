import 'package:flutter/material.dart';

class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    required this.groupValue,
    required this.onChanged,
    required this.child,
    super.key,
  });

  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: child,
    );
  }
}
