# sky_router_lints

Custom static analysis lint rules for the `sky_router` package.

## Features

* **avoid_navigator**: Warns developers when using Flutter's native `Navigator` directly, suggesting `RouteHandler` instead.

## Installation

Add `sky_router_lints` to your package or application `dev_dependencies`:

```yaml
dev_dependencies:
  sky_router_lints: ^1.0.0
```

## Configuration

Enable the plugin and diagnostic code in your `analysis_options.yaml`:

```yaml
plugins:
  sky_router_lints:
    diagnostics:
      avoid_navigator: true
```
