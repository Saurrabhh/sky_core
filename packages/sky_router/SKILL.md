---
name: sky-router
description: Guidelines on app routing and page transitions using sky_router
---

# sky_router Guidelines

Deals with declarative routing and parameter passing.

## Guidelines & Checklists

### 1. Declaring Routes
* Set up routes within the central configuration using `GoRoute` or custom wrappers.
* Provide route arguments inside the `extra` field.

### 2. Navigation
* Always use `RouteHandler` to navigate:
  * `RouteHandler.go(context, RoutePaths.myRoute)`
  * `RouteHandler.push(context, RoutePaths.myRoute, extra: args)`
  * `RouteHandler.pop(context)`

### 3. Argument Parsing
* In target pages (extending `BasePage`), retrieve arguments via the optional map constructor field:
  ```dart
  class MyPage extends BasePage<MyBloc, MyState> {
    const MyPage({required this.args, super.key});
    final Map<String, dynamic>? args;
  }
  ```
