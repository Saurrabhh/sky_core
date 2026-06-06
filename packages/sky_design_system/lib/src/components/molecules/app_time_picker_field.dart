import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/atoms.dart';

/// A field that opens a time picker dialog when tapped.
class AppTimePickerField extends StatefulWidget {
  /// Creates an [AppTimePickerField] instance.
  const AppTimePickerField({
    super.key,
    this.controller,
    this.initialTime,
    this.onTimeSelected,
    this.formatTime,
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

  /// The initialTime of this widget.
  final TimeOfDay? initialTime;

  /// The onTimeSelected of this widget.
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final String Function(TimeOfDay)? formatTime;

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
  State<AppTimePickerField> createState() => _AppTimePickerFieldState();
}

/// The [_AppTimePickerFieldState] widget.
class _AppTimePickerFieldState extends State<AppTimePickerField> {
  late final TextEditingController _controller;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedTime = widget.initialTime;
    if (_selectedTime != null) {
      _controller.text = _formatTime(_selectedTime!);
    }
  }

  @override
  void didUpdateWidget(covariant AppTimePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTime != oldWidget.initialTime &&
        widget.initialTime != null) {
      setState(() {
        _selectedTime = widget.initialTime;
        _controller.text = _formatTime(_selectedTime!);
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

  String _formatTime(TimeOfDay time) {
    if (widget.formatTime != null) {
      return widget.formatTime!(time);
    }
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  Future<void> _showPicker() async {
    if (!widget.enabled) return;

    final initial = _selectedTime ?? TimeOfDay.now();

    final selected = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (selected != null) {
      setState(() {
        _selectedTime = selected;
        _controller.text = _formatTime(selected);
      });
      widget.onTimeSelected?.call(selected);
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
            icon: Icons.access_time_outlined,
            onPressed: widget.enabled ? _showPicker : null,
          ),
    );
  }
}
