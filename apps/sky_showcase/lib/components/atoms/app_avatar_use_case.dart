import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Initials', type: AppAvatar)
Widget appAvatarInitialsUseCase(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: AppSpacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppAvatar(initials: 'A'),
        AppAvatar(initials: 'JD'),
        AppAvatar(initials: 'XYZ'),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Sizes', type: AppAvatar)
Widget appAvatarSizesUseCase(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: AppSpacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppAvatar(
          initials: 'SM',
          radius: AppRadius.md,
        ),
        AppAvatar(
          initials: 'MD',
          radius: AppRadius.lg,
        ),
        AppAvatar(
          initials: 'LG',
          radius: AppRadius.xl,
        ),
      ],
    ),
  );
}
