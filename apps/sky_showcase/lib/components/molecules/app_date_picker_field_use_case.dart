import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppDatePickerField)
Widget appDatePickerFieldInteractiveUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label Text',
    initialValue: 'Select Date',
  );
  final hint = context.knobs.string(
    label: 'Hint Text',
    initialValue: 'YYYY-MM-DD',
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
        child: AppDatePickerField(
          labelText: label.isEmpty ? null : label,
          hintText: hint.isEmpty ? null : hint,
          errorText: error.isEmpty ? null : error,
          enabled: enabled,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          initialDate: DateTime.now(),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'States', type: AppDatePickerField)
Widget appDatePickerFieldStatesUseCase(BuildContext context) {
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
              const AppDatePickerField(
                labelText: 'Normal State',
                hintText: 'Choose date',
              ),
              const SizedBox(height: AppSpacing.md),
              AppDatePickerField(
                labelText: 'Pre-populated State',
                initialDate: DateTime(2026, 5, 23),
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDatePickerField(
                labelText: 'Disabled State',
                enabled: false,
                hintText: 'Cannot select',
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDatePickerField(
                labelText: 'Error State',
                errorText: 'This date is unavailable',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Form Demo', type: AppDatePickerField)
Widget appDatePickerFieldFormDemoUseCase(BuildContext context) {
  final formKey = GlobalKey<FormState>();

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText.titleMedium(
                'Meeting Scheduler Form',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              AppDatePickerField(
                labelText: 'Meeting Date',
                hintText: 'Choose a date',
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a meeting date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton.primary(
                text: 'Schedule Meeting',
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    AppSnackBar.show(
                      context,
                      message: 'Date selected successfully!',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
