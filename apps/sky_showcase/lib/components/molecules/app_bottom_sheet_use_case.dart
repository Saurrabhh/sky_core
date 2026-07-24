import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppBottomSheet)
Widget appBottomSheetInteractiveUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Bottom Sheet Title',
  );
  final content = context.knobs.string(
    label: 'Content Text',
    initialValue: 'This is the bottom sheet content.',
  );
  final showDragHandle = context.knobs.boolean(
    label: 'Show Drag Handle',
    initialValue: true,
  );
  final isDismissible = context.knobs.boolean(
    label: 'Is Dismissible',
    initialValue: true,
  );

  return Center(
    child: AppButton.primary(
      text: 'Show Bottom Sheet',
      onPressed: () async {
        await AppBottomSheet.show<void>(
          context: context,
          title: title,
          showDragHandle: showDragHandle,
          isDismissible: isDismissible,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.bodyMedium(content),
              const SizedBox(height: AppSpacing.md),
              AppButton.primary(
                text: 'Close',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Standard', type: AppBottomSheet)
Widget appBottomSheetStandardUseCase(BuildContext context) {
  return Center(
    child: AppButton.outlined(
      text: 'Show Standard Bottom Sheet',
      onPressed: () async {
        await AppBottomSheet.show<void>(
          context: context,
          title: 'Information',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText.bodyMedium(
                'This bottom sheet displays generic helper text or controls.',
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton.outlined(
                text: 'Dismiss',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    ),
  );
}
