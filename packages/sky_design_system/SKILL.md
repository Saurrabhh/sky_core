---
name: sky-design-system
description: Guidelines on styling and visual components using sky_design_system
---

# Design System Guidelines (`sky_design_system`)

This skill file defines the standards, naming conventions, and constraints for styling, layouts, and visual components using the `sky_design_system` package.

## 1. Design System Wrappers

To ensure branding consistency, dark/light theme responsiveness, and standardized padding across the application, you **must** use design system wrappers instead of standard Flutter Material or Cupertino widgets.

Before writing a generic Flutter component, check if `sky_design_system` provides a wrapper:

| Standard Flutter Widget | Design System Wrapper | Usage / Guidelines |
| :--- | :--- | :--- |
| `AppBar` | `AppTopBar` | Standardized header bar with theme integration. |
| `ElevatedButton`, `TextButton`, `OutlinedButton` | `AppButton` | Use named constructors: `AppButton.primary()`, `AppButton.secondary()`, `AppButton.outlined()`, `AppButton.text()`, `AppButton.fab()`, or `AppButton.inverse()`. |
| `TextField`, `TextFormField` | `AppTextField` | Encapsulates input themes, validator support, and focus behavior. |
| `Icon` | `AppIcon` | Enforces standard icon sizes. Use `AppIcon.sm()`, `AppIcon.md()`, or `AppIcon.lg()`. |
| `SingleChildScrollView` | `AppScrollView` | Enforces responsive margins, keyboard dismissal on tap, safe area handling, and sticky/scrolling footers. |
| `showModalBottomSheet` | `AppBottomSheet.show(...)` | Enforces uniform modal layouts, header/title close buttons, and drag handles. |
| `ScaffoldMessenger.of(context).showSnackBar(...)` | `AppSnackBar.show(...)` | Enforces consistent background colors, padding, actions, and custom error styling. |

### Code Examples

#### Button Usage
```dart
// ❌ Avoid raw Flutter buttons
ElevatedButton(
  onPressed: () {},
  child: const Text('Submit'),
);

//  Use design system wrappers
AppButton.primary(
  text: 'Submit',
  onPressed: () {},
);

AppButton.secondary(
  text: 'Cancel',
  onPressed: () {},
);
```

#### Scroll Views
`AppScrollView` handles keyboard dismissal, responsive side padding (mobile/tablet/desktop layouts), and optional footers.
```dart
// ❌ Avoid raw SingleChildScrollView
SingleChildScrollView(
  child: Column(
    children: [ ... ],
  ),
);

//  Use AppScrollView
AppScrollView(
  spacing: AppSpacing.md,
  footer: AppButton.primary(
    text: 'Save Details',
    onPressed: () {},
  ),
  children: [
    AppTextField(labelText: 'Name'),
    AppTextField(labelText: 'Email'),
  ],
);
```

#### Navigation Bar
`AppNavigationBar` supports two variants: the default full-width bar and a floating pill-shaped bar. Use `.floating()` when the design calls for the nav bar to float above content with margin and rounded corners.

```dart
// Full-width (default)
AppNavigationBar(
  selectedIndex: index,
  onDestinationSelected: onTap,
  destinations: [...],
  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
)

// Floating pill shape
AppNavigationBar.floating(
  selectedIndex: index,
  onDestinationSelected: onTap,
  destinations: [...],
  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
)
```

The `labelBehavior` parameter controls label visibility (defaults to `alwaysShow`). The floating variant uses `AppSpacing.gutter` for horizontal margin and `AppBorderRadius.full` for pill-shaped corners.

---

## 2. Spacing Tokens (`AppSpacing`)

You must **never** hardcode raw double values (e.g., `8.0`, `16.0`) for padding, margins, spacers, gaps, or grid alignments. Always use tokens from `AppSpacing`:

*   `AppSpacing.none` (0 dp) - Zero spacing.
*   `AppSpacing.xs` (4 dp) - Extra-small spacing.
*   `AppSpacing.sm` (8 dp) - Small spacing.
*   `AppSpacing.md` (16 dp) - Medium spacing.
*   `AppSpacing.lg` (24 dp) - Large spacing.
*   `AppSpacing.xl` (32 dp) - Extra-large spacing.
*   `AppSpacing.xxl` (48 dp) - Double extra-large spacing.
*   `AppSpacing.gutter` (16 dp) - Standard column spacing gutter.
*   `AppSpacing.marginMobile` (16 dp) - Responsive layout margin for mobile screens.
*   `AppSpacing.marginTablet` (24 dp) - Responsive layout margin for tablet screens.
*   `AppSpacing.marginDesktop` (32 dp) - Responsive layout margin for desktop screens.

### Code Examples
```dart
// ❌ Avoid raw double values
Padding(
  padding: const EdgeInsets.all(12.0),
  child: SizedBox(height: 10.0),
);

//  Use AppSpacing tokens
Padding(
  padding: const EdgeInsets.all(AppSpacing.md),
  child: const SizedBox(height: AppSpacing.sm),
);
```

---

## 3. Color and Typography Tokens

To support theme switching (light/dark mode) and brand consistency, resolve styles dynamically using `BuildContext` extensions or `AppText` widgets. Do not hardcode custom colors or `TextStyle` properties.

### Theme Colors
Access the current color scheme via `context.colorScheme`:
*   `context.colorScheme.primary`
*   `context.colorScheme.onPrimary`
*   `context.colorScheme.secondary`
*   `context.colorScheme.surface`
*   `context.colorScheme.onSurface`
*   `context.colorScheme.error`
*   `context.colorScheme.secondaryContainer`

### Typography and Text Styles
Use `AppText` widgets instead of standard `Text` widgets with manual style styling whenever possible. `AppText` automatically applies the corresponding token:
*   `AppText.displayLarge('...')`
*   `AppText.headlineMedium('...')`
*   `AppText.titleLarge('...')`
*   `AppText.bodyMedium('...')`
*   `AppText.labelSmall('...')`

If you must access raw styles for custom needs (e.g. spans or inputs), use `context.textTheme`:
*   `context.textTheme.titleLarge`
*   `context.textTheme.bodyMedium`
*   `context.textTheme.labelSmall`

### Code Examples
```dart
// ❌ Avoid hardcoding typography and text colors
Text(
  'User Profile',
  style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
);

//  Use AppText variants
AppText.titleLarge(
  'User Profile',
  color: context.colorScheme.primary,
);
```
