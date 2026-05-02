import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Default', type: AppEmptyState)
Widget appEmptyStateUseCase(BuildContext context) {
  return AppEmptyState(
    icon: Icons.folder_open,
    title: 'No Data Found',
    description: 'Try adjusting your filters or creating a new item.',
    actionText: 'Create Item',
    onAction: () {},
  );
}

@widgetbook.UseCase(name: 'Default', type: AppTooltip)
Widget appTooltipUseCase(BuildContext context) {
  return const Center(
    child: AppTooltip(
      message: 'This is a tooltip',
      child: Icon(Icons.info, size: 32),
    ),
  );
}
