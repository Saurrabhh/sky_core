# Sky Core Monorepo

This repository contains the core logic and design system for Sky applications.

## Project Structure

- `packages/sky_design_system`: Atomic design system (atoms, molecules, organisms).
- `packages/sky_di`: Dependency injection setup.
- `packages/sky_error`: Standardized error handling.
- `packages/sky_lints`: Shared analysis rules.
- `packages/sky_network`: Network layer.
- `packages/sky_storage`: Storage abstractions.
- `packages/sky_storage_isar`: Isar implementation of storage.

## Getting Started

This project is managed by [Melos](https://melos.invertase.dev/).

1. Install Melos: `dart pub global activate melos`
2. Bootstrap the project: `melos bootstrap`
3. Run analysis: `melos run analyze`
