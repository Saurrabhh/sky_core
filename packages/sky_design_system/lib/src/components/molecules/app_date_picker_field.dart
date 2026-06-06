import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/atoms.dart';

/// A field that opens a date picker dialog when tapped.
class AppDatePickerField extends StatefulWidget {
  /// Creates an [AppDatePickerField] instance.
  const AppDatePickerField({
    super.key,
    this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.formatDate,
    this.labelText,
    this.hintText,
    this.errorText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.always,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  });

  /// The controller of this widget.
  final TextEditingController? controller;

  /// The initialDate of this widget.
  final DateTime? initialDate;

  /// The firstDate of this widget.
  final DateTime? firstDate;

  /// The lastDate of this widget.
  final DateTime? lastDate;

  /// The onDateSelected of this widget.
  final ValueChanged<DateTime>? onDateSelected;
  final String Function(DateTime)? formatDate;

  /// The labelText of this widget.
  final String? labelText;

  /// The hintText of this widget.
  final String? hintText;

  /// The errorText of this widget.
  final String? errorText;

  /// The validator of this widget.
  final FormFieldValidator<String>? validator;

  /// The autovalidateMode of this widget.
  final AutovalidateMode autovalidateMode;

  /// The onSaved of this widget.
  final FormFieldSetter<String>? onSaved;

  /// The prefixIcon of this widget.
  final Widget? prefixIcon;

  /// The suffixIcon of this widget.
  final Widget? suffixIcon;

  /// The enabled of this widget.
  final bool enabled;

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

/// The [_AppDatePickerFieldState] widget.
class _AppDatePickerFieldState extends State<AppDatePickerField> {
  late final TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedDate = widget.initialDate;
    if (_selectedDate != null) {
      _controller.text = _formatDate(_selectedDate!);
    }
  }

  @override
  void didUpdateWidget(covariant AppDatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate &&
        widget.initialDate != null) {
      setState(() {
        _selectedDate = widget.initialDate;
        _controller.text = _formatDate(_selectedDate!);
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  String _formatDate(DateTime date) {
    if (widget.formatDate != null) {
      return widget.formatDate!(date);
    }
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<void> _showPicker() async {
    if (!widget.enabled) return;

    final initial = _selectedDate ?? DateTime.now();
    final first = widget.firstDate ?? DateTime(1900);
    final last = widget.lastDate ?? DateTime(2100);

    final selected = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(first)
          ? first
          : (initial.isAfter(last) ? last : initial),
      firstDate: first,
      lastDate: last,
    );

    if (selected != null) {
      setState(() {
        _selectedDate = selected;
        _controller.text = _formatDate(selected);
      });
      widget.onDateSelected?.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      readOnly: true,
      enabled: widget.enabled,
      onTap: _showPicker,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      onSaved: widget.onSaved,
      hintText: widget.hintText,
      labelText: widget.labelText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon,
      suffixIcon:
          widget.suffixIcon ??
          AppIconButton(
            icon: Icons.calendar_today_outlined,
            onPressed: widget.enabled ? _showPicker : null,
          ),
    );
  }
}
