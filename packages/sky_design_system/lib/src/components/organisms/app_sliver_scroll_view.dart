import 'package:flutter/material.dart';
import 'package:sky_design_system/src/foundations/app_spacing.dart';

/// A parent scrollable layout container designed for screens requiring
/// slivers (e.g. sliver app bars).
///
/// It encapsulates sliver-based vertical scrolling, responsive margins,
/// safe area handling, and automatic keyboard dismissal on tapping
/// background areas.
class AppSliverScrollView extends StatelessWidget {
  /// Creates an [AppSliverScrollView] that directly wraps multiple [slivers].
  const AppSliverScrollView({
    required this.slivers,
    super.key,
    this.sliverAppBar,
    this.footer,
    this.stickyFooter = false,
    this.controller,
    this.physics,
    this.padding,
    this.footerPadding,
    this.dismissKeyboardOnTap = true,
    this.useSafeArea = true,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
  });

  /// An optional sliver app bar widget to display at the top.
  ///
  /// This must be a sliver widget (e.g. `SliverAppBar`, `SliverAppBar.large`,
  /// or custom sliver bar).
  final SliverAppBar? sliverAppBar;

  /// A list of slivers to build inside the [CustomScrollView].
  final List<Widget> slivers;

  /// An optional widget to place at the bottom of the scroll view.
  final Widget? footer;

  /// Whether the footer should be sticky at the bottom of the screen.
  final bool stickyFooter;

  /// Controls the scroll position and listens to scroll events.
  final ScrollController? controller;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Custom padding around the body or slivers.
  final EdgeInsetsGeometry? padding;

  /// Custom padding around the footer.
  final EdgeInsetsGeometry? footerPadding;

  /// Whether tapping on background areas of the screen should dismiss the
  /// keyboard.
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

    final footerWidget = footer != null
        ? Padding(
            padding:
                footerPadding ??
                EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: AppSpacing.md,
                ),
            child: footer,
          )
        : null;

    Widget scrollContent = CustomScrollView(
      controller: controller,
      physics: physics,
      keyboardDismissBehavior: keyboardDismissBehavior,
      slivers: [
        ?sliverAppBar,
        SliverPadding(
          padding: resolvedBodyPadding,
          sliver: SliverMainAxisGroup(
            slivers: slivers,
          ),
        ),
        if (footerWidget != null && !stickyFooter)
          SliverToBoxAdapter(
            child: footerWidget,
          ),
      ],
    );

    if (footerWidget != null && stickyFooter) {
      scrollContent = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: scrollContent),
          footerWidget,
        ],
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
