import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppCheckbox)
Widget appCheckboxUseCase(BuildContext context) {
  final value = context.knobs.boolean(label: 'Checked', initialValue: true);
  return Center(child: AppCheckbox(value: value, onChanged: (v) {}));
}

@widgetbook.UseCase(name: 'Interactive', type: AppRadioButton)
Widget appRadioButtonInteractiveUseCase(BuildContext context) {
  final selectedValue = context.knobs.list(
    label: 'Selected',
    options: [1, 2, 3],
    initialOption: 1,
  );

  return Center(
    child: AppRadioGroup<int>(
      groupValue: selectedValue,
      onChanged: (v) {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [1, 2, 3]
            .map((i) => AppRadioButton<int>(
                  value: i,
                ))
            .toList(),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSwitch)
Widget appSwitchUseCase(BuildContext context) {
  final value = context.knobs.boolean(label: 'On', initialValue: true);
  return Center(child: AppSwitch(value: value, onChanged: (v) {}));
}

@widgetbook.UseCase(name: 'Interactive', type: AppTextField)
Widget appTextFieldInteractiveUseCase(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Username');
  final hint = context.knobs.string(
    label: 'Hint',
    initialValue: 'Enter your username',
  );
  final error = context.knobs.string(label: 'Error', initialValue: '');

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: AppTextField(
      labelText: label.isNotEmpty ? label : null,
      hintText: hint.isNotEmpty ? hint : null,
      errorText: error.isNotEmpty ? error : null,
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSlider)
Widget appSliderUseCase(BuildContext context) {
  final value = context.knobs.double.slider(
    label: 'Value',
    initialValue: 0.5,
    min: 0,
    max: 1,
  );
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: AppSlider(value: value, onChanged: (v) {}),
  );
}
