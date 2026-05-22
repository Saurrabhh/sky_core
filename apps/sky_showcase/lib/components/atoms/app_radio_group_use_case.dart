import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Basic Group', type: AppRadioGroup)
Widget appRadioGroupBasicUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: _RadioGroupShowcase(),
  );
}

class _RadioGroupShowcase extends StatefulWidget {
  const _RadioGroupShowcase();

  @override
  State<_RadioGroupShowcase> createState() => _RadioGroupShowcaseState();
}

class _RadioGroupShowcaseState extends State<_RadioGroupShowcase> {
  String _selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        AppText.titleMedium('AppRadioGroup - Selected: $_selectedOption'),
        AppRadioGroup<String>(
          groupValue: _selectedOption,
          onChanged: (val) => setState(() => _selectedOption = val ?? ''),
          child: const Column(
            spacing: AppSpacing.sm,
            children: [
              Row(
                children: [
                  AppRadioButton<String>(value: 'Option 1'),
                  AppText.bodyMedium('Option 1'),
                ],
              ),
              Row(
                children: [
                  AppRadioButton<String>(value: 'Option 2'),
                  AppText.bodyMedium('Option 2'),
                ],
              ),
              Row(
                children: [
                  AppRadioButton<String>(value: 'Option 3'),
                  AppText.bodyMedium('Option 3'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
