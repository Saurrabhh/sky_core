import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppDivider)
Widget appDividerInteractiveUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: ['Horizontal', 'Vertical'],
  );

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Center(
      child: variant == 'Horizontal'
          ? const Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.md,
              children: [
                AppText.bodyMedium('Above Divider'),
                AppDivider.horizontal(),
                AppText.bodyMedium('Below Divider'),
              ],
            )
          : const SizedBox(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.md,
                children: [
                  AppText.bodyMedium('Left'),
                  AppDivider.vertical(),
                  AppText.bodyMedium('Right'),
                ],
              ),
            ),
    ),
  );
}

@widgetbook.UseCase(name: 'Horizontal', type: AppDivider)
Widget appDividerHorizontalUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        AppText.bodyMedium('Content block above divider'),
        AppDivider.horizontal(),
        AppText.bodyMedium('Content block below divider'),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Vertical', type: AppDivider)
Widget appDividerVerticalUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: SizedBox(
      height: 50,
      child: Row(
        spacing: AppSpacing.md,
        children: [
          AppText.bodyMedium('Left'),
          AppDivider.vertical(),
          AppText.bodyMedium('Middle'),
          AppDivider.vertical(),
          AppText.bodyMedium('Right'),
        ],
      ),
    ),
  );
}
