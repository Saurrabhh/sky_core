import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/atoms.dart';

class AppDatePickerField extends StatefulWidget {
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
    this.autovalidateMode,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final String Function(DateTime)? formatDate;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldSetter<String>? onSaved;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

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
      suffixIcon: widget.suffixIcon ??
          AppIconButton(
            icon: Icons.calendar_today_outlined,
            onPressed: widget.enabled ? _showPicker : null,
          ),
    );
  }
}
