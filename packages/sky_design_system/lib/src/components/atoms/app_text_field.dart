import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';

/// A text input field widget.
class AppTextField extends StatelessWidget {
  /// Creates an [AppTextField] instance.
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.onSaved,
    this.readOnly = false,
    this.onTap,
    this.enabled,
  });

  /// The controller of this widget.
  final TextEditingController? controller;
  /// The initialValue of this widget.
  final String? initialValue;
  /// The hintText of this widget.
  final String? hintText;
  /// The labelText of this widget.
  final String? labelText;
  /// The errorText of this widget.
  final String? errorText;
  /// The obscureText of this widget.
  final bool obscureText;
  /// The keyboardType of this widget.
  final TextInputType? keyboardType;
  /// The prefixIcon of this widget.
  final Widget? prefixIcon;
  /// The suffixIcon of this widget.
  final Widget? suffixIcon;
  /// The onChanged of this widget.
  final ValueChanged<String>? onChanged;
  /// The validator of this widget.
  final FormFieldValidator<String>? validator;
  /// The autovalidateMode of this widget.
  final AutovalidateMode? autovalidateMode;
  /// The onSaved of this widget.
  final FormFieldSetter<String>? onSaved;
  /// The readOnly of this widget.
  final bool readOnly;
  /// The onTap of this widget.
  final VoidCallback? onTap;
  /// The enabled of this widget.
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      onSaved: onSaved,
      readOnly: readOnly,
      onTap: onTap,
      enabled: enabled,
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
