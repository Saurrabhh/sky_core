import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppCard)
Widget appCardInteractiveUseCase(BuildContext context) {
  final variant = context.knobs.list(
    label: 'Variant',
    options: ['Outlined', 'Filled'],
    initialOption: 'Outlined',
  );
  final content = context.knobs.string(
    label: 'Content',
    initialValue: 'Card Content',
  );

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Center(
      child: switch (variant) {
        'Outlined' => AppCard.outlined(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppText.bodyMedium(content),
          ),
        'Filled' => AppCard.filled(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppText.bodyMedium(content),
          ),
        _ => const SizedBox.shrink(),
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive', type: AppListItem)
Widget appListItemInteractiveUseCase(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'Item Title');
  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'Item Subtitle',
  );
  final leading = context.knobs.boolean(label: 'Leading Icon', initialValue: true);
  final trailing = context.knobs.boolean(
    label: 'Trailing Icon',
    initialValue: true,
  );

  return Center(
    child: AppCard.outlined(
      child: AppListItem(
        title: title,
        subtitle: subtitle.isNotEmpty ? subtitle : null,
        leadingIcon: leading ? Icons.star : null,
        trailingIcon: trailing ? Icons.chevron_right : null,
        onTap: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSearchBar)
Widget appSearchBarUseCase(BuildContext context) {
  final hint = context.knobs.string(
    label: 'Hint',
    initialValue: 'Search items...',
  );
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: AppSearchBar(hintText: hint),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSectionHeader)
Widget appSectionHeaderUseCase(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'Section');
  final action = context.knobs.string(label: 'Action', initialValue: 'View All');

  return AppSectionHeader(
    title: title,
    actionText: action,
    onActionTap: () {},
  );
}
