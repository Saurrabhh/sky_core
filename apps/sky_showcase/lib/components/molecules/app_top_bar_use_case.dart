import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppTopBar)
Widget appTopBarInteractiveUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Dashboard',
  );
  final centerTitle = context.knobs.boolean(
    label: 'Center Title',
  );
  final hasLeading = context.knobs.boolean(
    label: 'Has Leading',
    initialValue: true,
  );
  final hasActions = context.knobs.boolean(
    label: 'Has Actions',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppTopBar(
      title: title,
      centerTitle: centerTitle,
      leading: hasLeading
          ? AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () {},
            )
          : null,
      actions: hasActions
          ? [
              AppIconButton(
                icon: Icons.search,
                onPressed: () {},
              ),
              AppIconButton(
                icon: Icons.more_vert,
                onPressed: () {},
              ),
            ]
          : null,
    ),
    body: const Center(
      child: AppText.bodyMedium('Screen Body Content'),
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppTopBar)
Widget appTopBarVariantsUseCase(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        AppTopBar(
          title: 'Standard Top Bar',
          actions: [
            AppIconButton(
              icon: Icons.search,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const AppTopBar(
          title: 'Centered Top Bar',
          centerTitle: true,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTopBar(
          title: 'Navigation Top Bar',
          leading: AppIconButton(
            icon: Icons.arrow_back,
            onPressed: () {},
          ),
          actions: [
            AppIconButton(
              icon: Icons.share,
              onPressed: () {},
            ),
            AppIconButton(
              icon: Icons.favorite_border,
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );
}
