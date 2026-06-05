import 'package:flutter/material.dart';

/// A slider input widget to select from a range of values.
class AppSlider extends StatelessWidget {
  /// Creates an [AppSlider] instance.
  const AppSlider({
    required this.value,
    required this.onChanged,
    super.key,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
  });

  /// The value of this widget.
  final double value;
  /// The onChanged of this widget.
  final ValueChanged<double>? onChanged;
  /// The min of this widget.
  final double min;
  /// The max of this widget.
  final double max;
  /// The divisions of this widget.
  final int? divisions;
  /// The label of this widget.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
    );
  }
}
