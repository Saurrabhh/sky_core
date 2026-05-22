import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppRadioButton)
Widget appRadioButtonInteractiveUseCase(BuildContext context) {
  final value = context.knobs.string(
    label: 'Value',
    initialValue: 'Option A',
  );

  final initialGroupValue = context.knobs.string(
    label: 'Group Value',
    initialValue: 'Option A',
  );

  final toggleable = context.knobs.boolean(
    label: 'Toggleable',
  );

  return Center(
    child: _InteractiveRadioWrapper(
      value: value,
      initialGroupValue: initialGroupValue,
      toggleable: toggleable,
    ),
  );
}

class _InteractiveRadioWrapper extends StatefulWidget {
  const _InteractiveRadioWrapper({
    required this.value,
    required this.initialGroupValue,
    required this.toggleable,
  });

  final String value;
  final String initialGroupValue;
  final bool toggleable;

  @override
  State<_InteractiveRadioWrapper> createState() =>
      _InteractiveRadioWrapperState();
}

class _InteractiveRadioWrapperState extends State<_InteractiveRadioWrapper> {
  String? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.initialGroupValue;
  }

  @override
  void didUpdateWidget(covariant _InteractiveRadioWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialGroupValue != widget.initialGroupValue) {
      _groupValue = widget.initialGroupValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.md,
      children: [
        AppRadioGroup<String>(
          groupValue: _groupValue,
          onChanged: (val) => setState(() => _groupValue = val),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppRadioButton<String>(
                value: widget.value,
                toggleable: widget.toggleable,
              ),
              AppText.bodyMedium('Value: ${widget.value}'),
            ],
          ),
        ),
        AppText.bodySmall('Current Group Value: ${_groupValue ?? "null"}'),
      ],
    );
  }
}

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
