# sky_design_system

A production-grade, highly customizable atomic design system and theme package for Flutter applications. Built with curated typography, harmonious light and dark color schemas, and reactive responsive widgets.

## Features

* **Atomic Component Design:** Organized clean UI abstractions into Atoms (buttons, inputs), Molecules (cards, list tiles), and Organisms (headers, views).
* **Curated Typography:** Integrated Google Fonts Outfit and Inter scales directly into standard text styles.
* **Premium Theme Palettes:** Highly tailored, cohesive Light and Dark Theme configurations to wow users at first glance.
* **Fluid Hover & Micro-Animations:** Standard interactive components come packaged with smooth feedback and touch indicators.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sky_design_system: ^1.0.0
```

## Usage

Initialize the design system themes inside your entry app:

```dart
import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sky Core App',
      theme: SkyTheme.lightTheme,
      darkTheme: SkyTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Showcase')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Standard atom button
            SkyPrimaryButton(
              onPressed: () {},
              label: 'Explore Showcase',
            ),
          ],
        ),
      ),
    );
  }
}
```
