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

/// A dedicated text widget that enforces the design system's typography scale.
class AppText extends StatelessWidget {
  const AppText.displayLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.displayLarge;

  const AppText.displayMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.displayMedium;

  const AppText.displaySmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.displaySmall;

  const AppText.headlineLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.headlineLarge;

  const AppText.headlineMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.headlineMedium;

  const AppText.headlineSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.headlineSmall;

  const AppText.titleLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.titleLarge;

  const AppText.titleMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.titleMedium;

  const AppText.titleSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.titleSmall;

  const AppText.bodyLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.bodyLarge;

  const AppText.bodyMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.bodyMedium;

  const AppText.bodySmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.bodySmall;

  const AppText.labelLarge(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.labelLarge;

  const AppText.labelMedium(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.labelMedium;

  const AppText.labelSmall(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
  }) : _variant = _AppTextVariant.labelSmall;

  final String data;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextStyle? style;
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
      style: baseStyle?.merge(style).copyWith(color: color),
    );
  }
}
