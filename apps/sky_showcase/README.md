# Sky Showcase

A [Widgetbook](https://www.widgetbook.io/)-based showcase application for the Sky Design System. It allows developers and designers to view, interact with, and test UI components in isolation with various configurations.

🌐 **Live Demo:** Visit the hosted Widgetbook at [design.skycore.dev](https://design.skycore.dev/)

## Features

- **Component Catalog:** Interactive preview of all UI components (atoms, molecules, organisms) defined in [sky_design_system](../../packages/sky_design_system).
- **Themes:** Easily toggle between **Light** and **Dark** modes using the custom `AppTheme` addon.
- **Viewports:** Simulates various device screen sizes (mobile, tablet, desktop) to test layout responsiveness.
- **Widget Inspector & Zoom:** Built-in tools for inspecting constraints and sizing.

## Getting Started

### Prerequisites

Ensure you have bootstrapped the monorepo first using [Melos](https://melos.invertase.dev/):

```bash
# From the root of the workspace
melos bootstrap
```

### 1. Code Generation

This project uses `widgetbook_generator` to automatically build the component tree. Whenever components are added or modified, run `build_runner`:

```bash
# Run code generation once
dart run build_runner build --delete-conflicting-outputs

# Or watch for changes in real-time
dart run build_runner watch --delete-conflicting-outputs
```

### 2. Run the Application

You can run the showcase application on any supported target (Web, Desktop, Mobile).

To run on **Web** (recommended for browser inspection):

```bash
flutter run -d chrome
```

For other platforms:

```bash
flutter run
```

## Deployment

The hosted Widgetbook is built as a Flutter web app and deployed to [design.skycore.dev](https://design.skycore.dev/).

To build the web project locally:

```bash
flutter build web
```

