import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppSlider)
Widget appSliderInteractiveUseCase(BuildContext context) {
  final min = context.knobs.double.slider(
    label: 'Min',
    max: 10,
  );

  final max = context.knobs.double.slider(
    label: 'Max',
    initialValue: 10,
    min: 10,
    max: 100,
  );

  final divisions = context.knobs.double
      .slider(
        label: 'Divisions (0 for continuous)',
        max: 10,
        divisions: 10,
      )
      .toInt();

  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Custom Value',
  );

  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: _InteractiveSliderWrapper(
      min: min,
      max: max,
      divisions: divisions > 0 ? divisions : null,
      label: label.isEmpty ? null : label,
      enabled: enabled,
    ),
  );
}

class _InteractiveSliderWrapper extends StatefulWidget {
  const _InteractiveSliderWrapper({
    required this.min,
    required this.max,
    required this.enabled,
    this.divisions,
    this.label,
  });

  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool enabled;

  @override
  State<_InteractiveSliderWrapper> createState() =>
      _InteractiveSliderWrapperState();
}

class _InteractiveSliderWrapperState extends State<_InteractiveSliderWrapper> {
  double _value = 5;

  @override
  void initState() {
    super.initState();
    _value = widget.min + (widget.max - widget.min) / 2;
  }

  @override
  void didUpdateWidget(covariant _InteractiveSliderWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_value < widget.min || _value > widget.max) {
      _value = widget.min + (widget.max - widget.min) / 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.md,
      children: [
        AppText.titleMedium('Slider Value: ${_value.toStringAsFixed(2)}'),
        AppSlider(
          value: _value,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          label: widget.label,
          onChanged: widget.enabled
              ? (val) => setState(() => _value = val)
              : null,
        ),
      ],
    );
  }
}

@widgetbook.UseCase(name: 'Variants', type: AppSlider)
Widget appSliderVariantsUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: _SliderShowcase(),
  );
}

class _SliderShowcase extends StatefulWidget {
  const _SliderShowcase();

  @override
  State<_SliderShowcase> createState() => _SliderShowcaseState();
}

class _SliderShowcaseState extends State<_SliderShowcase> {
  double _value1 = 0.3;
  double _value2 = 0.6;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        AppText.titleMedium(
          'Continuous Slider (Value: ${_value1.toStringAsFixed(2)})',
        ),
        AppSlider(
          value: _value1,
          onChanged: (val) => setState(() => _value1 = val),
        ),
        const Divider(),
        AppText.titleMedium(
          'Discrete Slider (Value: ${_value2.toStringAsFixed(1)})',
        ),
        AppSlider(
          value: _value2,
          divisions: 5,
          label: _value2.toString(),
          onChanged: (val) => setState(() => _value2 = val),
        ),
        const Divider(),
        const AppText.titleMedium('Disabled Slider'),
        const AppSlider(
          value: 0.5,
          onChanged: null,
        ),
      ],
    );
  }
}
