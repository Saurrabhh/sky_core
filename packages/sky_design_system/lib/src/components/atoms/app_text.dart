import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';

enum _AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// A stylized typography component.
class AppText extends StatelessWidget {
  /// Creates an [AppText] in the displayLarge style.
  const AppText.displayLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.displayLarge;

  /// Creates an [AppText] in the displayMedium style.
  const AppText.displayMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.displayMedium;

  /// Creates an [AppText] in the displaySmall style.
  const AppText.displaySmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.displaySmall;

  /// Creates an [AppText] in the headlineLarge style.
  const AppText.headlineLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.headlineLarge;

  /// Creates an [AppText] in the headlineMedium style.
  const AppText.headlineMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.headlineMedium;

  /// Creates an [AppText] in the headlineSmall style.
  const AppText.headlineSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.headlineSmall;

  /// Creates an [AppText] in the titleLarge style.
  const AppText.titleLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.titleLarge;

  /// Creates an [AppText] in the titleMedium style.
  const AppText.titleMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.titleMedium;

  /// Creates an [AppText] in the titleSmall style.
  const AppText.titleSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.titleSmall;

  /// Creates an [AppText] in the bodyLarge style.
  const AppText.bodyLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.bodyLarge;

  /// Creates an [AppText] in the bodyMedium style.
  const AppText.bodyMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.bodyMedium;

  /// Creates an [AppText] in the bodySmall style.
  const AppText.bodySmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.bodySmall;

  /// Creates an [AppText] in the labelLarge style.
  const AppText.labelLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.labelLarge;

  /// Creates an [AppText] in the labelMedium style.
  const AppText.labelMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.labelMedium;

  /// Creates an [AppText] in the labelSmall style.
  const AppText.labelSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = _AppTextVariant.labelSmall;

  /// The data of this widget.
  final String data;
  /// The color of this widget.
  final Color? color;
  /// The textAlign of this widget.
  final TextAlign? textAlign;
  /// The maxLines of this widget.
  final int? maxLines;
  /// The overflow of this widget.
  final TextOverflow? overflow;
  /// The softWrap of this widget.
  final bool? softWrap;
  final _AppTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final baseStyle = switch (_variant) {
      _AppTextVariant.displayLarge => textTheme.displayLarge,
      _AppTextVariant.displayMedium => textTheme.displayMedium,
      _AppTextVariant.displaySmall => textTheme.displaySmall,
      _AppTextVariant.headlineLarge => textTheme.headlineLarge,
      _AppTextVariant.headlineMedium => textTheme.headlineMedium,
      _AppTextVariant.headlineSmall => textTheme.headlineSmall,
      _AppTextVariant.titleLarge => textTheme.titleLarge,
      _AppTextVariant.titleMedium => textTheme.titleMedium,
      _AppTextVariant.titleSmall => textTheme.titleSmall,
      _AppTextVariant.bodyLarge => textTheme.bodyLarge,
      _AppTextVariant.bodyMedium => textTheme.bodyMedium,
      _AppTextVariant.bodySmall => textTheme.bodySmall,
      _AppTextVariant.labelLarge => textTheme.labelLarge,
      _AppTextVariant.labelMedium => textTheme.labelMedium,
      _AppTextVariant.labelSmall => textTheme.labelSmall,
    };

    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: baseStyle?.copyWith(color: color),
    );
  }
}
