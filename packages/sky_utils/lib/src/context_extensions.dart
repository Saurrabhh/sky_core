import 'package:flutter/widgets.dart';

/// Extensions on [BuildContext] for easy media query value retrieval.
extension SkyUtilsContextExtension on BuildContext {
  /// Returns the current screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Returns the current screen width.
  double get screenWidth => screenSize.width;

  /// Returns the current screen height.
  double get screenHeight => screenSize.height;

  /// Returns the current screen padding.
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  /// Returns the current view padding.
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// Returns the current view insets.
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Returns the current screen orientation.
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Indicates if the screen is in landscape mode.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Indicates if the screen is in portrait mode.
  bool get isPortrait => orientation == Orientation.portrait;
}
