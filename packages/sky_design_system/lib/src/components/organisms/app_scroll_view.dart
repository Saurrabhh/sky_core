import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/app_spacing.dart';

/// A parent scrollable layout container designed for forms and screens.
///
/// It encapsulates vertical scrolling, responsive margins, safe area
/// handling, and automatic keyboard dismissal on tapping background areas.
/// It also supports a scrolling footer that stays at the bottom of the
/// viewport when content is short and scrolls naturally when content
/// exceeds the viewport.
class AppScrollView extends StatelessWidget {
  /// Creates an [AppScrollView] with a list of children.
  ///
  /// The [spacing] parameter determines the vertical space between each child.
  const AppScrollView({
    required List<Widget> this.children,
    super.key,
    this.footer,
    this.stickyFooter = false,
    this.controller,
    this.physics,
    this.padding,
    this.footerPadding,
    this.spacing = AppSpacing.md,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.dismissKeyboardOnTap = true,
    this.useSafeArea = true,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
  });

  /// The list of children scroll content.
  final List<Widget> children;

  /// An optional widget to place at the bottom of the scroll view.
  final Widget? footer;

  /// Whether the footer should be sticky at the bottom of the screen.
  final bool stickyFooter;

  /// Controls the scroll position and listens to scroll events.
  final ScrollController? controller;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Custom padding around the content.
  final EdgeInsetsGeometry? padding;

  /// Custom padding around the footer.
  final EdgeInsetsGeometry? footerPadding;

  /// The vertical spacing between elements.
  final double spacing;

  /// How the children in the column should be aligned horizontally.
  final CrossAxisAlignment crossAxisAlignment;

  /// How the children in the column should be aligned vertically.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space the column should take up along the main axis.
  final MainAxisSize mainAxisSize;

  /// Whether tapping on background areas of the screen should dismiss the keyboard.
  final bool dismissKeyboardOnTap;

  /// Whether to wrap the scroll view content in a [SafeArea].
  final bool useSafeArea;

  /// Whether to apply safe area inset at the top.
  final bool safeAreaTop;

  /// Whether to apply safe area inset at the bottom.
  final bool safeAreaBottom;

  /// Whether to apply safe area inset on the left.
  final bool safeAreaLeft;

  /// Whether to apply safe area inset on the right.
  final bool safeAreaRight;

  /// Configures how the scroll view dismisses the keyboard when scrolled.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = switch (screenWidth) {
      >= 1024 => AppSpacing.marginDesktop,
      >= 600 => AppSpacing.marginTablet,
      _ => AppSpacing.marginMobile,
    };

    final resolvedBodyPadding =
        padding ??
        EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: AppSpacing.md,
        );

    final contentBody = Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: children,
    );

    final footerWidget = footer != null
        ? Padding(
            padding: footerPadding ??
                EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: AppSpacing.md,
                ),
            child: footer,
          )
        : null;

    Widget scrollContent;

    if (stickyFooter && footerWidget != null) {
      scrollContent = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              physics: physics,
              keyboardDismissBehavior: keyboardDismissBehavior,
              child: Padding(
                padding: resolvedBodyPadding,
                child: contentBody,
              ),
            ),
          ),
          footerWidget,
        ],
      );
    } else {
      scrollContent = SingleChildScrollView(
        controller: controller,
        physics: physics,
        keyboardDismissBehavior: keyboardDismissBehavior,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: resolvedBodyPadding,
              child: contentBody,
            ),
            if (footerWidget != null) footerWidget,
          ],
        ),
      );
    }

    if (useSafeArea) {
      scrollContent = SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        left: safeAreaLeft,
        right: safeAreaRight,
        child: scrollContent,
      );
    }

    if (dismissKeyboardOnTap) {
      scrollContent = GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: scrollContent,
      );
    }

    return scrollContent;
  }
}
