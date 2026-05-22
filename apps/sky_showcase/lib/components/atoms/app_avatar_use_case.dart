import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppAvatar)
Widget appAvatarInteractiveUseCase(BuildContext context) {
  final initials = context.knobs.string(
    label: 'Initials',
    initialValue: 'JD',
  );
  final radius = context.knobs.double.slider(
    label: 'Radius',
    initialValue: AppRadius.lgIncreased,
    min: AppRadius.xs,
    max: AppRadius.xxl,
  );
  final hasImage = context.knobs.boolean(
    label: 'Has Image',
  );

  return Center(
    child: AppAvatar(
      initials: initials.isEmpty ? null : initials,
      radius: radius,
      backgroundImage: hasImage
          ? const NetworkImage('https://picsum.photos/200')
          : null,
    ),
  );
}

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
