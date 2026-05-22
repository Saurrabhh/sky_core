import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppDialog)
Widget appDialogInteractiveUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Confirm Action',
  );
  final content = context.knobs.string(
    label: 'Content Text',
    initialValue: 'Are you sure you want to proceed?',
  );
  final scrollable = context.knobs.boolean(
    label: 'Scrollable',
    initialValue: true,
  );
  final barrierDismissible = context.knobs.boolean(
    label: 'Barrier Dismissible',
    initialValue: true,
  );
  final hasIcon = context.knobs.boolean(
    label: 'Has Icon',
  );

  return Center(
    child: AppButton.primary(
      text: 'Show Dialog',
      onPressed: () async {
        await AppDialog.show<void>(
          context: context,
          title: title,
          scrollable: scrollable,
          barrierDismissible: barrierDismissible,
          icon: hasIcon ? const AppIcon.lg(Icons.info_outlined) : null,
          content: AppText.bodyMedium(content),
          actions: [
            AppButton.text(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
            AppButton.primary(
              text: 'Confirm',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Standard', type: AppDialog)
Widget appDialogStandardUseCase(BuildContext context) {
  return Center(
    child: AppButton.outlined(
      text: 'Show Standard Dialog',
      onPressed: () async {
        await AppDialog.show<void>(
          context: context,
          title: 'Alert',
          content: const AppText.bodyMedium(
            'This is a standard system dialogue warning.',
          ),
          actions: [
            AppButton.primary(
              text: 'Dismiss',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    ),
  );
}
