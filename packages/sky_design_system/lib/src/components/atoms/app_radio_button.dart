import 'package:flutter/material.dart';

/// A single radio button selector widget.
class AppRadioButton<T> extends StatelessWidget {
  /// Creates an [AppRadioButton] instance.
  const AppRadioButton({
    required this.value,
    super.key,
    this.toggleable = false,
  });

  /// The value of this widget.
  final T value;

  /// The toggleable of this widget.
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
