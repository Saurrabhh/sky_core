import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Variants', type: AppRadioButton)
Widget appRadioButtonVariantsUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: _RadioButtonShowcase(),
  );
}

class _RadioButtonShowcase extends StatefulWidget {
  const _RadioButtonShowcase();

  @override
  State<_RadioButtonShowcase> createState() => _RadioButtonShowcaseState();
}

class _RadioButtonShowcaseState extends State<_RadioButtonShowcase> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        const AppText.titleMedium('Radio Buttons Selection State'),
        AppRadioGroup<int>(
          groupValue: _selectedValue,
          onChanged: (val) => setState(() => _selectedValue = val ?? 1),
          child: const Column(
            spacing: AppSpacing.sm,
            children: [
              Row(
                children: [
                  AppRadioButton<int>(value: 1),
                  AppText.bodyMedium('Selected (Value 1)'),
                ],
              ),
              Row(
                children: [
                  AppRadioButton<int>(value: 2),
                  AppText.bodyMedium('Unselected (Value 2)'),
                ],
              ),
              Row(
                children: [
                  AppRadioButton<int>(value: 3, toggleable: true),
                  AppText.bodyMedium('Toggleable Option (Value 3)'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
