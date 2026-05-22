// Ignoring const constructor rules because AppTimePickerField cannot be
// initialized as const due to its internal controller mapping.
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppTimePickerField)
Widget appTimePickerFieldInteractiveUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label Text',
    initialValue: 'Select Time',
  );
  final hint = context.knobs.string(
    label: 'Hint Text',
    initialValue: 'HH:MM AM/PM',
  );
  final error = context.knobs.string(
    label: 'Error Text',
  );
  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: AppTimePickerField(
          labelText: label.isEmpty ? null : label,
          hintText: hint.isEmpty ? null : hint,
          errorText: error.isEmpty ? null : error,
          enabled: enabled,
          initialTime: const TimeOfDay(hour: 9, minute: 30),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'States', type: AppTimePickerField)
Widget appTimePickerFieldStatesUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTimePickerField(
                labelText: 'Normal State',
                hintText: 'Choose time',
              ),
              SizedBox(height: AppSpacing.md),
              AppTimePickerField(
                labelText: 'Pre-populated State',
                initialTime: const TimeOfDay(hour: 14, minute: 15),
              ),
              SizedBox(height: AppSpacing.md),
              AppTimePickerField(
                labelText: 'Disabled State',
                enabled: false,
                hintText: 'Cannot select',
              ),
              SizedBox(height: AppSpacing.md),
              AppTimePickerField(
                labelText: 'Error State',
                errorText: 'Time slot unavailable',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
