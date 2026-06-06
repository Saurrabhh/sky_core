import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_text.dart';
import 'package:sky_design_system/src/extensions.dart';

/// Base class for all spans used in [AppRichText].
abstract class AppSpan {
  const AppSpan();

  /// Converts this span into a standard Flutter [InlineSpan].
  InlineSpan toInlineSpan(BuildContext context);
}

/// A text span component for [AppRichText] that integrates with the design system's typography.
class AppTextSpan extends AppSpan {
  /// Creates an [AppTextSpan] with optional style and variant overrides.
  const AppTextSpan(
    this.text, {
    this.variant,
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  });

  /// Creates a text span in the displayLarge style.
  const AppTextSpan.displayLarge(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.displayLarge;

  /// Creates a text span in the displayMedium style.
  const AppTextSpan.displayMedium(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.displayMedium;

  /// Creates a text span in the displaySmall style.
  const AppTextSpan.displaySmall(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.displaySmall;

  /// Creates a text span in the headlineLarge style.
  const AppTextSpan.headlineLarge(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.headlineLarge;

  /// Creates a text span in the headlineMedium style.
  const AppTextSpan.headlineMedium(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.headlineMedium;

  /// Creates a text span in the headlineSmall style.
  const AppTextSpan.headlineSmall(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.headlineSmall;

  /// Creates a text span in the titleLarge style.
  const AppTextSpan.titleLarge(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.titleLarge;

  /// Creates a text span in the titleMedium style.
  const AppTextSpan.titleMedium(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.titleMedium;

  /// Creates a text span in the titleSmall style.
  const AppTextSpan.titleSmall(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.titleSmall;

  /// Creates a text span in the bodyLarge style.
  const AppTextSpan.bodyLarge(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.bodyLarge;

  /// Creates a text span in the bodyMedium style.
  const AppTextSpan.bodyMedium(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.bodyMedium;

  /// Creates a text span in the bodySmall style.
  const AppTextSpan.bodySmall(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.bodySmall;

  /// Creates a text span in the labelLarge style.
  const AppTextSpan.labelLarge(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.labelLarge;

  /// Creates a text span in the labelMedium style.
  const AppTextSpan.labelMedium(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.labelMedium;

  /// Creates a text span in the labelSmall style.
  const AppTextSpan.labelSmall(
    String this.text, {
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.recognizer,
    this.children,
  }) : variant = AppTextVariant.labelSmall;

  /// The text content of the span.
  final String? text;

  /// The typography variant to use for the span.
  final AppTextVariant? variant;

  /// Optional color override.
  final Color? color;

  /// Optional font weight override.
  final FontWeight? fontWeight;

  /// Optional font style override.
  final FontStyle? fontStyle;

  /// Optional text decoration override.
  final TextDecoration? decoration;

  /// Gesture recognizer for links or taps on this span.
  final GestureRecognizer? recognizer;

  /// Nested spans that inherit/override styles from this span.
  final List<AppSpan>? children;

  @override
  InlineSpan toInlineSpan(BuildContext context) {
    TextStyle? style;
    if (variant != null) {
      final textTheme = context.textTheme;
      style = switch (variant!) {
        AppTextVariant.displayLarge => textTheme.displayLarge,
        AppTextVariant.displayMedium => textTheme.displayMedium,
        AppTextVariant.displaySmall => textTheme.displaySmall,
        AppTextVariant.headlineLarge => textTheme.headlineLarge,
        AppTextVariant.headlineMedium => textTheme.headlineMedium,
        AppTextVariant.headlineSmall => textTheme.headlineSmall,
        AppTextVariant.titleLarge => textTheme.titleLarge,
        AppTextVariant.titleMedium => textTheme.titleMedium,
        AppTextVariant.titleSmall => textTheme.titleSmall,
        AppTextVariant.bodyLarge => textTheme.bodyLarge,
        AppTextVariant.bodyMedium => textTheme.bodyMedium,
        AppTextVariant.bodySmall => textTheme.bodySmall,
        AppTextVariant.labelLarge => textTheme.labelLarge,
        AppTextVariant.labelMedium => textTheme.labelMedium,
        AppTextVariant.labelSmall => textTheme.labelSmall,
      };
    }

    if (style != null ||
        color != null ||
        fontWeight != null ||
        fontStyle != null ||
        decoration != null) {
      style = (style ?? const TextStyle()).copyWith(
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
      );
    }

    return TextSpan(
      text: text,
      style: style,
      recognizer: recognizer,
      children: children?.map((child) => child.toInlineSpan(context)).toList(),
    );
  }
}

/// A widget span component for [AppRichText] to insert arbitrary widgets (like icons or images) inline.
class AppWidgetSpan extends AppSpan {
  /// Creates an [AppWidgetSpan] wrapping the provided child [Widget].
  const AppWidgetSpan({
    required this.child,
    this.alignment = PlaceholderAlignment.bottom,
    this.baseline,
  });

  /// The widget inline.
  final Widget child;

  /// Alignment of the widget relative to the text.
  final PlaceholderAlignment alignment;

  /// Text baseline to align with when [alignment] is baseline.
  final TextBaseline? baseline;

  @override
  InlineSpan toInlineSpan(BuildContext context) {
    return WidgetSpan(
      child: child,
      alignment: alignment,
      baseline: baseline,
    );
  }
}

/// A rich text component that displays styled text in sections.
class AppRichText extends StatelessWidget {
  /// Creates an [AppRichText] with a default typography style.
  const AppRichText({
    required this.spans,
    super.key,
    this.variant,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  /// Creates an [AppRichText] in the displayLarge style.
  const AppRichText.displayLarge({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.displayLarge;

  /// Creates an [AppRichText] in the displayMedium style.
  const AppRichText.displayMedium({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.displayMedium;

  /// Creates an [AppRichText] in the displaySmall style.
  const AppRichText.displaySmall({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.displaySmall;

  /// Creates an [AppRichText] in the headlineLarge style.
  const AppRichText.headlineLarge({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.headlineLarge;

  /// Creates an [AppRichText] in the headlineMedium style.
  const AppRichText.headlineMedium({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.headlineMedium;

  /// Creates an [AppRichText] in the headlineSmall style.
  const AppRichText.headlineSmall({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.headlineSmall;

  /// Creates an [AppRichText] in the titleLarge style.
  const AppRichText.titleLarge({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.titleLarge;

  /// Creates an [AppRichText] in the titleMedium style.
  const AppRichText.titleMedium({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.titleMedium;

  /// Creates an [AppRichText] in the titleSmall style.
  const AppRichText.titleSmall({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.titleSmall;

  /// Creates an [AppRichText] in the bodyLarge style.
  const AppRichText.bodyLarge({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.bodyLarge;

  /// Creates an [AppRichText] in the bodyMedium style.
  const AppRichText.bodyMedium({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.bodyMedium;

  /// Creates an [AppRichText] in the bodySmall style.
  const AppRichText.bodySmall({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.bodySmall;

  /// Creates an [AppRichText] in the labelLarge style.
  const AppRichText.labelLarge({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.labelLarge;

  /// Creates an [AppRichText] in the labelMedium style.
  const AppRichText.labelMedium({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.labelMedium;

  /// Creates an [AppRichText] in the labelSmall style.
  const AppRichText.labelSmall({
    required this.spans,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : variant = AppTextVariant.labelSmall;

  /// The list of [AppSpan] children to render.
  final List<AppSpan> spans;

  /// The default variant styling of this text block.
  final AppTextVariant? variant;

  /// Optional base color override for the entire text block.
  final Color? color;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// Maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final baseStyle = variant != null
        ? switch (variant!) {
            AppTextVariant.displayLarge => textTheme.displayLarge,
            AppTextVariant.displayMedium => textTheme.displayMedium,
            AppTextVariant.displaySmall => textTheme.displaySmall,
            AppTextVariant.headlineLarge => textTheme.headlineLarge,
            AppTextVariant.headlineMedium => textTheme.headlineMedium,
            AppTextVariant.headlineSmall => textTheme.headlineSmall,
            AppTextVariant.titleLarge => textTheme.titleLarge,
            AppTextVariant.titleMedium => textTheme.titleMedium,
            AppTextVariant.titleSmall => textTheme.titleSmall,
            AppTextVariant.bodyLarge => textTheme.bodyLarge,
            AppTextVariant.bodyMedium => textTheme.bodyMedium,
            AppTextVariant.bodySmall => textTheme.bodySmall,
            AppTextVariant.labelLarge => textTheme.labelLarge,
            AppTextVariant.labelMedium => textTheme.labelMedium,
            AppTextVariant.labelSmall => textTheme.labelSmall,
          }
        : null;

    final defaultStyle =
        baseStyle?.copyWith(color: color) ?? TextStyle(color: color);

    return Text.rich(
      TextSpan(
        children: spans.map((span) => span.toInlineSpan(context)).toList(),
      ),
      style: defaultStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
