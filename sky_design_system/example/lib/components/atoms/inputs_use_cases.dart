import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Default', type: AppCheckbox)
Widget appCheckboxUseCase(BuildContext context) {
  return const Center(child: AppCheckbox(value: true, onChanged: null));
}

@widgetbook.UseCase(name: 'Default', type: AppRadioButton)
Widget appRadioButtonUseCase(BuildContext context) {
  return const Center(
    child: AppRadioButton<int>(value: 1, groupValue: 1, onChanged: null),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSwitch)
Widget appSwitchUseCase(BuildContext context) {
  return const Center(child: AppSwitch(value: true, onChanged: null));
}

@widgetbook.UseCase(name: 'Default', type: AppTextField)
Widget appTextFieldUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.lg),
    child: AppTextField(hintText: 'Enter text here...'),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSlider)
Widget appSliderUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.lg),
    child: AppSlider(value: 0.5, onChanged: null),
  );
}
