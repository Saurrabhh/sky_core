# sky_lints

Shared, highly optimized static analysis rules and strict lint configurations for Sky Core Dart and Flutter projects. It builds upon `package:very_good_analysis` to enforce high-quality, readable, and standard code conventions.

## Features

* **Strict Formatting & Quality:** Enforces formatting, structure, and linting guidelines to prevent code smell and logical errors.
* **Production Ready:** Optimized for Clean Architecture patterns, preventing redundant declarations and ensuring robust code.

## Getting Started & Usage

Add the package as a `dev_dependency` in your package's `pubspec.yaml`:

```yaml
dev_dependencies:
  sky_lints: ^1.0.0
```

Then, include the rules inside your package's local `analysis_options.yaml` file:

```yaml
include: package:sky_lints/analysis_options.yaml
```

You can customize rules by adding a local `linter` override block inside your specific package if needed:

```yaml
linter:
  rules:
    avoid_print: true
```
