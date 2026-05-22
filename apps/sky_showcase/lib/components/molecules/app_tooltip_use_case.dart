import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppTooltip)
Widget appTooltipInteractiveUseCase(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a helpful tooltip',
  );
  final childType = context.knobs.object.dropdown<String>(
    label: 'Child Widget',
    options: const ['Icon', 'Text', 'Button'],
  );

  final Widget child;
  switch (childType) {
    case 'Icon':
      child = const AppIcon.lg(Icons.info_outlined);
    case 'Text':
      child = const AppText.bodyMedium('Hover/long-press me');
    case 'Button':
      child = AppButton.primary(
        text: 'Action Button',
        onPressed: () {},
      );
    default:
      child = const SizedBox.shrink();
  }

  return Center(
    child: AppTooltip(
      message: message,
      child: child,
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppTooltip)
Widget appTooltipVariantsUseCase(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: AppSpacing.xl,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppTooltip(
          message: 'Icon tooltip helper',
          child: AppIcon.lg(Icons.help_outline),
        ),
        AppTooltip(
          message: 'Text block explanation',
          child: AppText.bodyMedium('Info label'),
        ),
      ],
    ),
  );
}
