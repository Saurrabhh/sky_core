import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

import 'main.directories.g.dart';

import 'foundations_screen.dart';

void main() {
  runApp(const ShowcaseApp());
}

class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Sky Design System Showcase',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: mode,
          home: FoundationsScreen(themeMode: _themeMode),
        );
      },
    );
  }

  @override
  void dispose() {
    _themeMode.dispose();
    super.dispose();
  }
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      appBuilder: (context, child) {
        return child;
      },
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: AppTheme.light()),
            WidgetbookTheme(name: 'Dark', data: AppTheme.dark()),
          ],
        ),
        ViewportAddon([
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyS20,
        ]),
      ],
    );
  }
}
