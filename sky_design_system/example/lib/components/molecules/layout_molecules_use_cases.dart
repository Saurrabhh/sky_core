import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Outlined & Filled', type: AppCard)
Widget appCardUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      children: [
        AppCard.outlined(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: const AppText.bodyMedium('Outlined Card Content'),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard.filled(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: const AppText.bodyMedium('Filled Card Content'),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppListItem)
Widget appListItemUseCase(BuildContext context) {
  return const AppCard.outlined(
    child: AppListItem(
      title: 'List Item Title',
      subtitle: 'Secondary text goes here',
      leadingIcon: Icons.star,
      trailingIcon: Icons.chevron_right,
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSearchBar)
Widget appSearchBarUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: AppSearchBar(hintText: 'Search items...'),
  );
}
