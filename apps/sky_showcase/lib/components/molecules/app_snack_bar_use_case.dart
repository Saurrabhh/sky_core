import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppSnackBar)
Widget appSnackBarInteractiveUseCase(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Operation successful!',
  );
  final actionText = context.knobs.string(
    label: 'Action Text',
    initialValue: 'Undo',
  );
  final isError = context.knobs.boolean(
    label: 'Is Error',
  );
  final hasAction = context.knobs.boolean(
    label: 'Has Action',
    initialValue: true,
  );

  return Center(
    child: AppButton.primary(
      text: 'Trigger SnackBar',
      onPressed: () {
        AppSnackBar.show(
          context,
          message: message,
          isError: isError,
          actionText: hasAction && actionText.isNotEmpty ? actionText : null,
          onAction: hasAction && actionText.isNotEmpty ? () {} : null,
        );
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppSnackBar)
Widget appSnackBarVariantsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        AppButton.outlined(
          text: 'Show Success SnackBar',
          onPressed: () {
            AppSnackBar.show(
              context,
              message: 'Action completed successfully.',
            );
          },
        ),
        AppButton.outlined(
          text: 'Show Action SnackBar',
          onPressed: () {
            AppSnackBar.show(
              context,
              message: 'Item has been deleted.',
              actionText: 'Restore',
              onAction: () {},
            );
          },
        ),
        AppButton.outlined(
          text: 'Show Error SnackBar',
          onPressed: () {
            AppSnackBar.show(
              context,
              message: 'Failed to connection to server.',
              isError: true,
            );
          },
        ),
      ],
    ),
  );
}
