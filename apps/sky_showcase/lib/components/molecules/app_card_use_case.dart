import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppCard)
Widget appCardInteractiveUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: const ['Outlined', 'Filled'],
  );
  final content = context.knobs.string(
    label: 'Content',
    initialValue: 'Card Content',
  );
  final paddingVal = context.knobs.double.slider(
    label: 'Padding',
    initialValue: AppSpacing.md,
    max: AppSpacing.xxl,
  );

  final padding = EdgeInsets.all(paddingVal);

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Center(
      child: variant == 'Outlined'
          ? AppCard.outlined(
              padding: padding,
              child: AppText.bodyMedium(content),
            )
          : AppCard.filled(
              padding: padding,
              child: AppText.bodyMedium(content),
            ),
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppCard)
Widget appCardVariantsUseCase(BuildContext context) {
  return const Center(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppCard.outlined(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.titleMedium('Outlined Card'),
                SizedBox(height: AppSpacing.xs),
                AppText.bodyMedium('This is an outlined card.'),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.md),
          AppCard.filled(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.titleMedium('Filled Card'),
                SizedBox(height: AppSpacing.xs),
                AppText.bodyMedium('This is a filled card.'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
