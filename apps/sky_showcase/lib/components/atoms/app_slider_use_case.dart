import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

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
