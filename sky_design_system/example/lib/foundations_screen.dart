import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'foundations/colors_use_case.dart';
import 'foundations/typography_use_case.dart';
import 'foundations/spacing_use_case.dart';
import 'foundations/radius_use_case.dart';
import 'main.dart';

class FoundationsScreen extends StatelessWidget {
  const FoundationsScreen({
    super.key,
    required this.themeMode,
  });

  final ValueNotifier<ThemeMode> themeMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.titleLarge('Phase 1: Foundations'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () {
              themeMode.value = themeMode.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
          IconButton(
            icon: const Icon(Icons.book),
            tooltip: 'Open Widgetbook',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WidgetbookApp(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Section(
              title: 'App Details',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText.bodyMedium('Stitch Project ID: 9356866131485520871'),
                    AppText.bodySmall(
                      'Current Theme: ${themeMode.value.name.toUpperCase()}',
                      color: context.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            _Section(
              title: 'Colors',
              child: SizedBox(
                height: 600,
                child: colorsUseCase(context),
              ),
            ),
            const Divider(),
            _Section(
              title: 'Typography',
              child: SizedBox(
                height: 800,
                child: typographyUseCase(context),
              ),
            ),
            const Divider(),
            _Section(
              title: 'Spacing',
              child: SizedBox(
                height: 600,
                child: spacingUseCase(context),
              ),
            ),
            const Divider(),
            _Section(
              title: 'Radius',
              child: SizedBox(
                height: 400,
                child: radiusUseCase(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: AppText.headlineMedium(title),
        ),
        child,
      ],
    );
  }
}
