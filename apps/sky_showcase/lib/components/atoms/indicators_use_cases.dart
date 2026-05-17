import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

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
    child: AppBadge(count: 3, child: Icon(Icons.notifications, size: 32)),
  );
}
