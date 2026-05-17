import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppProgressIndicator)
Widget appProgressIndicatorInteractiveUseCase(BuildContext context) {
  final value = context.knobs.double.slider(
    label: 'Progress',
    initialValue: 0.5,
    min: 0,
    max: 1,
  );
  final isIndeterminate = context.knobs.boolean(
    label: 'Indeterminate',
    initialValue: false,
  );
  final type = context.knobs.list(
    label: 'Type',
    options: ['Circular', 'Linear'],
    initialOption: 'Circular',
  );

  return Center(
    child: switch (type) {
      'Circular' => AppProgressIndicator.circular(
          value: isIndeterminate ? null : value,
        ),
      'Linear' => AppProgressIndicator.linear(
          value: isIndeterminate ? null : value,
        ),
      _ => const SizedBox.shrink(),
    },
  );
}

@widgetbook.UseCase(name: 'Interactive', type: AppAvatar)
Widget appAvatarInteractiveUseCase(BuildContext context) {
  final initials = context.knobs.string(label: 'Initials', initialValue: 'JD');
  final hasImage = context.knobs.boolean(label: 'Has Image', initialValue: false);

  return Center(
    child: AppAvatar(
      initials: initials,
      imageUrl: hasImage ? 'https://i.pravatar.cc/150?u=sky' : null,
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive', type: AppBadge)
Widget appBadgeInteractiveUseCase(BuildContext context) {
  final count = context.knobs.double
      .slider(label: 'Count', initialValue: 3, min: 0, max: 99)
      .toInt();
  final isDot = context.knobs.boolean(label: 'Is Dot', initialValue: false);

  return Center(
    child: AppBadge(
      count: count > 0 ? count : null,
      isDot: isDot,
      child: const AppIcon(Icons.notifications, size: AppIconSize.large),
    ),
  );
}

@widgetbook.UseCase(name: 'Circular & Linear', type: AppProgressIndicator)
Widget appProgressIndicatorUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.lg),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.xl,
      children: [
        AppProgressIndicator.circular(),
        AppProgressIndicator.linear(),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppAvatar)
Widget appAvatarUseCase(BuildContext context) {
  return const Center(child: AppAvatar(initials: 'JD'));
}

@widgetbook.UseCase(name: 'Default', type: AppBadge)
Widget appBadgeUseCase(BuildContext context) {
  return const Center(
    child: AppBadge(
      count: 3,
      child: AppIcon(Icons.notifications, size: AppIconSize.large),
    ),
  );
}
