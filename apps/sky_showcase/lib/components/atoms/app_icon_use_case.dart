import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Sizes', type: AppIcon)
Widget appIconSizesUseCase(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: AppSpacing.lg,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppIcon.sm(Icons.star),
        AppIcon.md(Icons.star),
        AppIcon.lg(Icons.star),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Colors', type: AppIcon)
Widget appIconColorsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: AppSpacing.lg,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppIcon.md(
          Icons.favorite,
          color: context.colorScheme.primary,
        ),
        AppIcon.md(
          Icons.shield,
          color: context.colorScheme.secondary,
        ),
        AppIcon.md(
          Icons.warning,
          color: context.colorScheme.error,
        ),
      ],
    ),
  );
}
