---
name: Core Logic Visual Language
colors:
  surface: '#121316'
  surface-dim: '#121316'
  surface-bright: '#38393d'
  surface-container-lowest: '#0d0e11'
  surface-container-low: '#1b1b1f'
  surface-container: '#1f1f23'
  surface-container-high: '#292a2d'
  surface-container-highest: '#343438'
  on-surface: '#e3e2e6'
  on-surface-variant: '#c1c6d3'
  inverse-surface: '#e3e2e6'
  inverse-on-surface: '#303034'
  outline: '#8b919d'
  outline-variant: '#414751'
  surface-tint: '#a5c8ff'
  primary: '#a5c8ff'
  on-primary: '#00315f'
  primary-container: '#005faf'
  on-primary-container: '#c4daff'
  inverse-primary: '#005faf'
  secondary: '#bac8db'
  on-secondary: '#243141'
  secondary-container: '#3d4a5a'
  on-secondary-container: '#acb9cd'
  tertiary: '#d6bee4'
  on-tertiary: '#3b2947'
  tertiary-container: '#6b5778'
  on-tertiary-container: '#e9d0f7'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#d4e3ff'
  primary-fixed-dim: '#a5c8ff'
  on-primary-fixed: '#001c3a'
  on-primary-fixed-variant: '#004786'
  secondary-fixed: '#d6e4f8'
  secondary-fixed-dim: '#bac8db'
  on-secondary-fixed: '#0f1c2b'
  on-secondary-fixed-variant: '#3b4858'
  tertiary-fixed: '#f3daff'
  tertiary-fixed-dim: '#d6bee4'
  on-tertiary-fixed: '#251431'
  on-tertiary-fixed-variant: '#523f5f'
  background: '#121316'
  on-background: '#e3e2e6'
  surface-variant: '#343438'
typography:
  display-lg:
    fontSize: 57px
    fontWeight: '400'
    lineHeight: 64px
    letterSpacing: -0.25px
  display-md:
    fontSize: 45px
    fontWeight: '400'
    lineHeight: 52px
    letterSpacing: 0px
  display-sm:
    fontSize: 36px
    fontWeight: '400'
    lineHeight: 44px
    letterSpacing: 0px
  headline-lg:
    fontSize: 32px
    fontWeight: '400'
    lineHeight: 40px
    letterSpacing: 0px
  headline-md:
    fontSize: 28px
    fontWeight: '400'
    lineHeight: 36px
    letterSpacing: 0px
  headline-sm:
    fontSize: 24px
    fontWeight: '400'
    lineHeight: 32px
    letterSpacing: 0px
  title-lg:
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
    letterSpacing: 0px
  title-md:
    fontSize: 16px
    fontWeight: '500'
    lineHeight: 24px
    letterSpacing: 0.15px
  title-sm:
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.1px
  body-lg:
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0.5px
  body-md:
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0.25px
  body-sm:
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
    letterSpacing: 0.4px
  label-lg:
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
  label-sm:
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  none: '0'
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  xxl: 48px
  gutter: 16px
  margin-mobile: 16px
  margin-tablet: 24px
  margin-desktop: 32px
---

## Brand & Style

This design system is built on a **Corporate / Modern** aesthetic, designed to serve as a high-performance foundation for any domain. The personality is disciplined, precise, and unobtrusive, ensuring that the interface never competes with the user's data.

By utilizing a dark color mode, the system reduces eye strain and provides a sophisticated environment that allows technical content to stand out. The style leverages Material 3's logic while leaning into a more refined, systematic execution. It utilizes heavy whitespace to reduce cognitive load and a strict adherence to a grid-based hierarchy.

## Colors

The color system utilizes a dynamic Material 3 dark palette anchored by a professional Deep Blue primary. The palette is designed for high accessibility and clarity in low-light environments.

- **Primary**: Used for key action highlights and active states, utilizing lighter tones (Tone 80) for optimal contrast.
- **Secondary**: Used for less prominent UI components and grouping elements.
- **Tertiary**: Provides a subtle accent for contrasting data points or secondary call-outs.
- **Surface**: A sophisticated, low-luminance neutral background that reduces glare.
- **Outline**: A medium-contrast grey used for component boundaries and structural separation.

For dark mode implementation, follow standard M3 tonal mapping to ensure legibility against dark surfaces.

## Typography

The typography system uses **Inter** for all levels to ensure maximum readability across different screen densities.

Critical to this system is the use of **Tabular Figures (`tnum`)** for all `Body` and `Label` styles. This ensures that numerical data aligns perfectly in lists, tables, and dashboards, reinforcing the professional and technical nature of the design system.

Weights are strictly controlled: `400` (Regular) for readability in long-form text and `500` (Medium) for titles and functional labels to provide clear visual hierarchy without excessive "glow" on dark surfaces.

## Layout & Spacing

This design system utilizes a **Fluid Grid** model based on an 8-pixel rhythm with 4-pixel sub-increments for tight component internal spacing.

- **Columns**: 4 columns for mobile, 8 for tablet, and 12 for desktop.
- **Gutters**: Fixed at 16px to maintain a tight, efficient data density.
- **Margins**: Scales dynamically based on the breakpoint to provide more breathing room on larger displays.

Alignment should prioritize the "baseline" for text and "center-alignment" for icons within buttons or list items. Consistency in vertical spacing is essential to maintain the professional aesthetic.

## Elevation & Depth

In dark mode, depth is primarily communicated through **Tonal Layers**—where higher elevation elements use lighter surface colors—and **Low-contrast Outlines**.

- **Level 0 (Flat)**: Standard surface background (darkest).
- **Level 1 (Tonal)**: Uses a subtle color shift (Surface Container) to denote cards or secondary sections.
- **Level 2+ (Shadows)**: Reserved only for floating elements like Dialogs, Menus, or FABs. Shadows must be ambient and diffused, primarily used to provide a subtle "lift" from the dark background.

Containers should use `Outline` tokens at 1px width for borders when elevation is not desired but separation is required.

## Shapes

The shape language follows a **Rounded** philosophy, providing a balance between a modern "friendly" feel and a serious "structured" look.

- **Extra Small**: Used for tooltips and small checkboxes.
- **Small**: Standard for text fields and chips.
- **Medium**: Used for cards and small dialogs.
- **Large**: Used for primary container elements.
- **Extra Large**: Used for bottom sheets and large modal surfaces.
- **Full**: Reserved for buttons and status indicators to maximize distinctiveness.

## Components

### Buttons
Buttons use the `Full` shape family. Primary buttons use the Primary container color with high-contrast text. Outlined buttons use the `Outline` token with a 1px border. Iconography within buttons should be 18px or 24px, centered vertically.

### Input Fields
Inputs follow the Material 3 "Filled" or "Outlined" spec but with `Small` corner rounding. Use the `body-md` type scale for input text and `label-sm` for helper text. Ensure the focus state uses a 2px primary border.

### Chips
Chips utilize the `Small` shape family. They are compact (32px height) and use `label-md` for text. Filter chips should show a leading check icon when selected.

### Lists
Lists are the backbone of this system. They should have no side padding within their container to allow the background color to act as the margin. Use `title-md` for primary text and `body-sm` for secondary text. Use 16px horizontal padding for internal content.

### Cards
Cards use the `Medium` shape family. Prefer the "Outlined" card variant for a professional, clean look in data-heavy views, and "Filled" (Tonal) cards for grouping related actions.

### Checkboxes & Radios
These use the `Extra-Small` shape for checkboxes and `Full` for radios. The active state must use the Primary color. Ensure a minimum 48dp hit target even if the visual asset is smaller.