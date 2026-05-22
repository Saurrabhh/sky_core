import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppListTile)
Widget appListTileInteractiveUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'List Item Title',
  );
  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'List Item Subtitle',
  );
  final leading = context.knobs.boolean(
    label: 'Has Leading Icon',
    initialValue: true,
  );
  final trailing = context.knobs.boolean(
    label: 'Has Trailing Icon',
    initialValue: true,
  );
  final hasTrailingWidget = context.knobs.boolean(
    label: 'Has Custom Trailing Widget',
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AppCard.outlined(
        child: AppListTile(
          title: title,
          subtitle: subtitle.isEmpty ? null : subtitle,
          leadingIcon: leading ? Icons.star : null,
          trailingIcon: trailing ? Icons.chevron_right : null,
          trailingWidget: hasTrailingWidget
              ? const AppBadge(
                  count: 3,
                  child: Icon(Icons.notifications),
                )
              : null,
          onTap: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppListTile)
Widget appListTileVariantsUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AppCard.outlined(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppListTile(
              title: 'Title Only',
              onTap: () {},
            ),
            const AppDivider.horizontal(),
            AppListTile(
              title: 'Title & Subtitle',
              subtitle: 'Supporting text goes here',
              onTap: () {},
            ),
            const AppDivider.horizontal(),
            AppListTile(
              title: 'Title with Leading Icon',
              leadingIcon: Icons.home,
              onTap: () {},
            ),
            const AppDivider.horizontal(),
            AppListTile(
              title: 'Title with Custom Trailing',
              subtitle: 'Uses an AppBadge as trailing widget',
              leadingIcon: Icons.notifications,
              trailingWidget: const AppBadge(
                count: 5,
                child: Icon(Icons.notifications),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
