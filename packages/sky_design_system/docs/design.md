---
name: Core Logic Light
colors:
  surface: '#f8f9ff'
  surface-dim: '#d8dae0'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3fa'
  surface-container: '#eceef4'
  surface-container-high: '#e6e8ee'
  surface-container-highest: '#e1e2e8'
  on-surface: '#191c20'
  on-surface-variant: '#414750'
  inverse-surface: '#2e3135'
  inverse-on-surface: '#eff0f7'
  outline: '#717782'
  outline-variant: '#c1c7d2'
  surface-tint: '#0061a4'
  primary: '#00497d'
  on-primary: '#ffffff'
  primary-container: '#0061a4'
  on-primary-container: '#c0dbff'
  inverse-primary: '#9fcaff'
  secondary: '#535f70'
  on-secondary: '#ffffff'
  secondary-container: '#d7e3f8'
  on-secondary-container: '#596576'
  tertiary: '#52405f'
  on-tertiary: '#ffffff'
  tertiary-container: '#6b5778'
  on-tertiary-container: '#e9d0f7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d1e4ff'
  primary-fixed-dim: '#9fcaff'
  on-primary-fixed: '#001d36'
  on-primary-fixed-variant: '#00497d'
  secondary-fixed: '#d7e3f8'
  secondary-fixed-dim: '#bbc7db'
  on-secondary-fixed: '#101c2b'
  on-secondary-fixed-variant: '#3c4858'
  tertiary-fixed: '#f3daff'
  tertiary-fixed-dim: '#d6bee4'
  on-tertiary-fixed: '#251431'
  on-tertiary-fixed-variant: '#523f5f'
  background: '#f8f9ff'
  on-background: '#191c20'
  surface-variant: '#e1e2e8'
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

The style leverages Material 3's logic while leaning into a more refined, systematic execution. It utilizes heavy whitespace to reduce cognitive load and a strict adherence to a grid-based hierarchy. The emotional goal is to evoke a sense of reliability and technical competence.

## Colors

The color system utilizes a dynamic Material 3 palette anchored by a professional Deep Blue primary. The palette is designed for high accessibility and clarity.

- **Primary**: Used for key action highlights and active states.
- **Secondary**: Used for less prominent UI components and grouping elements.
- **Tertiary**: Provides a subtle accent for contrasting data points or secondary call-outs.
- **Surface**: A clean, high-brightness neutral that serves as the canvas.
- **Outline**: A medium-contrast grey used for component boundaries and structural separation.

For dark mode implementation, follow standard M3 tonal mapping, shifting primary intensities to 80-tone equivalents to ensure legibility against dark surfaces.

## Typography

The typography system uses **Inter** for all levels to ensure maximum readability across different screen densities. 

Critical to this system is the use of **Tabular Figures (`tnum`)** for all `Body` and `Label` styles. This ensures that numerical data aligns perfectly in lists, tables, and dashboards, reinforcing the professional and technical nature of the design system. 

Weights are strictly controlled: `400` (Regular) for readability in long-form text and `500` (Medium) for titles and functional labels to provide clear visual hierarchy.

## Layout & Spacing

This design system utilizes a **Fluid Grid** model based on an 8-pixel rhythm with 4-pixel sub-increments for tight component internal spacing. 

- **Columns**: 4 columns for mobile, 8 for tablet, and 12 for desktop.
- **Gutters**: Fixed at 16px to maintain a tight, efficient data density.
- **Margins**: Scales dynamically based on the breakpoint to provide more breathing room on larger displays.

Alignment should prioritize the "baseline" for text and "center-alignment" for icons within buttons or list items. Consistency in vertical spacing (using `md` and `lg` increments) is essential to maintain the professional aesthetic.

## Elevation & Depth

Depth is primarily communicated through **Tonal Layers** and **Low-contrast Outlines** rather than heavy shadows. This creates a flat, modern architectural feel.

- **Level 0 (Flat)**: Standard surface background.
- **Level 1 (Tonal)**: Uses a subtle color shift (Surface Container) to denote cards or secondary sections.
- **Level 2+ (Shadows)**: Reserved only for floating elements like Dialogs, Menus, or FABs. Shadows must be ambient and diffused: a soft blur with 10-12% opacity using the Neutral color, never pure black.

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