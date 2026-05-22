import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

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
