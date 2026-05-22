import 'package:flutter/material.dart';

class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    required this.value,
    super.key,
    this.toggleable = false,
  });

  final T value;
  final bool toggleable;

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value,
      toggleable: toggleable,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
