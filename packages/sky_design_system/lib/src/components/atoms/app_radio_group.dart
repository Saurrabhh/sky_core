import 'package:flutter/material.dart';

/// A group of mutually exclusive radio buttons.
class AppRadioGroup<T> extends StatelessWidget {
  /// Creates an [AppRadioGroup] instance.
  const AppRadioGroup({
    required this.groupValue,
    required this.onChanged,
    required this.child,
    super.key,
  });

  /// The groupValue of this widget.
  final T? groupValue;

  /// The onChanged of this widget.
  final ValueChanged<T?> onChanged;

  /// The child of this widget.
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
