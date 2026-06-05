import 'package:flutter/material.dart';

/// A general page layout container.
class AppScaffold extends StatelessWidget {
  /// Creates an [AppScaffold] instance.
  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  /// The appBar of this widget.
  final PreferredSizeWidget? appBar;
  /// The body of this widget.
  final Widget? body;
  /// The drawer of this widget.
  final Widget? drawer;
  /// The floatingActionButton of this widget.
  final Widget? floatingActionButton;
  /// The bottomNavigationBar of this widget.
  final Widget? bottomNavigationBar;
  /// The backgroundColor of this widget.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
    );
  }
}
