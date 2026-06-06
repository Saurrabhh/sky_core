import 'package:flutter/material.dart';

/// A standard checkbox input widget.
class AppCheckbox extends StatelessWidget {
  /// Creates an [AppCheckbox] instance.
  const AppCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
    this.isError = false,
  });

  /// The value of this widget.
  final bool? value;

  /// The onChanged of this widget.
  final ValueChanged<bool?>? onChanged;

  /// The isError of this widget.
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
