import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive Date Picker', type: AppDatePickerField)
Widget appDatePickerUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Select Date',
  );
  final hint = context.knobs.string(
    label: 'Hint',
    initialValue: 'YYYY-MM-DD',
  );
  final error = context.knobs.string(
    label: 'Error',
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
          labelText: label.isNotEmpty ? label : null,
          hintText: hint.isNotEmpty ? hint : null,
          errorText: error.isNotEmpty ? error : null,
          enabled: enabled,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          initialDate: DateTime.now(),
          onDateSelected: (date) {
            debugPrint('Selected date: $date');
          },
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive Time Picker', type: AppTimePickerField)
Widget appTimePickerUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Select Time',
  );
  final hint = context.knobs.string(
    label: 'Hint',
    initialValue: 'HH:MM AM/PM',
  );
  final error = context.knobs.string(
    label: 'Error',
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
          labelText: label.isNotEmpty ? label : null,
          hintText: hint.isNotEmpty ? hint : null,
          errorText: error.isNotEmpty ? error : null,
          enabled: enabled,
          initialTime: TimeOfDay.now(),
          onTimeSelected: (time) {
            debugPrint('Selected time: $time');
          },
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Form Integration Demo', type: AppDatePickerField)
Widget appPickerFormDemoUseCase(BuildContext context) {
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
              const SizedBox(height: AppSpacing.md),
              AppTimePickerField(
                labelText: 'Meeting Time',
                hintText: 'Choose a time',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a meeting time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton.primary(
                text: 'Schedule Meeting',
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Meeting Scheduled Successfully!'),
                      ),
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
