import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppProgressIndicator)
Widget appProgressIndicatorInteractiveUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: const ['Circular', 'Linear'],
  );

  final isIndeterminate = context.knobs.boolean(
    label: 'Is Indeterminate',
    initialValue: true,
  );

  final val = context.knobs.double.slider(
    label: 'Value',
    initialValue: 0.5,
    max: 1,
  );

  final value = isIndeterminate ? null : val;

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Center(
      child: variant == 'Circular'
          ? AppProgressIndicator.circular(value: value)
          : AppProgressIndicator.linear(value: value),
    ),
  );
}

@widgetbook.UseCase(name: 'Indeterminate', type: AppProgressIndicator)
Widget appProgressIndicatorIndeterminateUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xl,
      children: [
        AppText.titleMedium('Indeterminate Circular'),
        Center(child: AppProgressIndicator.circular()),
        AppText.titleMedium('Indeterminate Linear'),
        AppProgressIndicator.linear(),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Determinate', type: AppProgressIndicator)
Widget appProgressIndicatorDeterminateUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xl,
      children: [
        AppText.titleMedium('Determinate Circular (30%, 70%, 100%)'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppProgressIndicator.circular(value: 0.3),
            AppProgressIndicator.circular(value: 0.7),
            AppProgressIndicator.circular(value: 1),
          ],
        ),
        AppText.titleMedium('Determinate Linear (50%)'),
        AppProgressIndicator.linear(value: 0.5),
      ],
    ),
  );
}
