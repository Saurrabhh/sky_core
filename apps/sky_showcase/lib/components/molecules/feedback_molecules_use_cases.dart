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

  return Center(
    child: AppTooltip(
      message: message,
      child: const AppIcon.lg(Icons.info,),
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

@widgetbook.UseCase(name: 'Snackbar', type: AppSnackBar)
Widget appSnackbarUseCase(BuildContext context) {
  return Center(
    child: AppButton.primary(
      text: 'Show Snackbar',
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar.create(
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
