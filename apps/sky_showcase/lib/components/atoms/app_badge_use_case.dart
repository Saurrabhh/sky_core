import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Variants', type: AppBadge)
Widget appBadgeVariantsUseCase(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: AppSpacing.xl,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppBadge(
          count: 3,
          child: AppIcon.lg(Icons.mail),
        ),
        AppBadge(
          count: 99,
          child: AppIcon.lg(Icons.notifications),
        ),
        AppBadge(
          isDot: true,
          child: AppIcon.lg(Icons.settings),
        ),
        AppBadge(
          child: AppIcon.lg(Icons.person),
        ),
      ],
    ),
  );
}
