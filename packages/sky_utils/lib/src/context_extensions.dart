import 'package:flutter/widgets.dart';

/// {@template sky_utils_context_extension}
/// High-performance [BuildContext] extensions for atomic [MediaQuery] lookups.
///
/// By using Flutter 3.10+'s fine-grained atomic selectors
/// (e.g. [MediaQuery.sizeOf]), we avoid rebuilding the entire widget tree
/// when unrelated properties of [MediaQueryData] change.
/// {@endtemplate}
extension SkyUtilsContextExtension on BuildContext {
  /// Returns the screen [Size] of the current device.
  ///
  /// Rebuilds only when the screen size changes.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Returns the screen width of the current device.
  ///
  /// Rebuilds only when the screen size changes.
  double get screenWidth => screenSize.width;

  /// Returns the screen height of the current device.
  ///
  /// Rebuilds only when the screen size changes.
  double get screenHeight => screenSize.height;

  /// Returns the screen [EdgeInsets] padding.
  ///
  /// Rebuilds only when the screen padding changes (e.g. notch visibility).
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  /// Returns the screen [EdgeInsets] view padding.
  ///
  /// Rebuilds only when the view padding changes.
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// Returns the screen [EdgeInsets] view insets (typically keyboard height).
  ///
  /// Rebuilds only when the keyboard or view insets change.
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Returns the current screen [Orientation].
  ///
  /// Rebuilds only when the orientation changes.
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Checks if the device is currently in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Checks if the device is currently in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;
}
