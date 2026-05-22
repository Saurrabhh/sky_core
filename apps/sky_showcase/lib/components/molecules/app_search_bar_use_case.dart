import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppSearchBar)
Widget appSearchBarInteractiveUseCase(BuildContext context) {
  final hint = context.knobs.string(
    label: 'Hint Text',
    initialValue: 'Search items...',
  );

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: AppSearchBar(
          hintText: hint,
          onChanged: (val) {
            debugPrint('Search query: $val');
          },
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppSearchBar)
Widget appSearchBarVariantsUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppText.titleMedium('Default Hint Search'),
            const SizedBox(height: AppSpacing.xs),
            AppSearchBar(
              onChanged: (val) {},
            ),
            const SizedBox(height: AppSpacing.lg),
            const AppText.titleMedium('Custom Hint Search'),
            const SizedBox(height: AppSpacing.xs),
            AppSearchBar(
              hintText: 'Search movies, shows...',
              onChanged: (val) {},
            ),
          ],
        ),
      ),
    ),
  );
}
