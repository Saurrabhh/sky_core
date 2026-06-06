import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';

enum AppTextVariant {
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
  }) : _variant = AppTextVariant.displayLarge;

  /// Creates an [AppText] in the displayMedium style.
  const AppText.displayMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.displayMedium;

  /// Creates an [AppText] in the displaySmall style.
  const AppText.displaySmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.displaySmall;

  /// Creates an [AppText] in the headlineLarge style.
  const AppText.headlineLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.headlineLarge;

  /// Creates an [AppText] in the headlineMedium style.
  const AppText.headlineMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.headlineMedium;

  /// Creates an [AppText] in the headlineSmall style.
  const AppText.headlineSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.headlineSmall;

  /// Creates an [AppText] in the titleLarge style.
  const AppText.titleLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.titleLarge;

  /// Creates an [AppText] in the titleMedium style.
  const AppText.titleMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.titleMedium;

  /// Creates an [AppText] in the titleSmall style.
  const AppText.titleSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.titleSmall;

  /// Creates an [AppText] in the bodyLarge style.
  const AppText.bodyLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.bodyLarge;

  /// Creates an [AppText] in the bodyMedium style.
  const AppText.bodyMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.bodyMedium;

  /// Creates an [AppText] in the bodySmall style.
  const AppText.bodySmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.bodySmall;

  /// Creates an [AppText] in the labelLarge style.
  const AppText.labelLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.labelLarge;

  /// Creates an [AppText] in the labelMedium style.
  const AppText.labelMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.labelMedium;

  /// Creates an [AppText] in the labelSmall style.
  const AppText.labelSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = AppTextVariant.labelSmall;

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
  final AppTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final baseStyle = switch (_variant) {
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
