import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppEmptyState)
Widget appEmptyStateInteractiveUseCase(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'No Data');
  final description = context.knobs.string(
    label: 'Description',
    initialValue: 'Try adjusting your filters or creating a new item.',
  );
  final action = context.knobs.string(label: 'Action', initialValue: 'Retry');

  return AppEmptyState(
    icon: Icons.search_off,
    title: title,
    description: description,
    actionText: action.isNotEmpty ? action : null,
    onAction: action.isNotEmpty ? () {} : null,
  );
}

@widgetbook.UseCase(name: 'Interactive', type: AppTooltip)
Widget appTooltipInteractiveUseCase(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a helpful tooltip',
  );

  return Center(
    child: AppTooltip(
      message: message,
      child: const AppIcon(Icons.info, size: AppIconSize.large),
    ),
  );
}

@widgetbook.UseCase(name: 'Dialog', type: AppDialog)
Widget appDialogUseCase(BuildContext context) {
  return Center(
    child: AppButton.primary(
      text: 'Show Dialog',
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AppDialog(
          title: 'Confirm Action',
          content: const AppText.bodyMedium('Are you sure you want to proceed?'),
          actions: [
            AppButton.text(
              text: 'Cancel',
              onPressed: () => Navigator.pop(context),
            ),
            AppButton.primary(
              text: 'Confirm',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Snackbar', type: AppSnackbar)
Widget appSnackbarUseCase(BuildContext context) {
  return Center(
    child: AppButton.primary(
      text: 'Show Snackbar',
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackbar.create(
            context: context,
            message: 'Action completed successfully',
            actionText: 'Undo',
            onAction: () {},
          ),
        );
      },
    ),
  );
}
