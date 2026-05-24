import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/atoms.dart';

class AppTimePickerField extends StatefulWidget {
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
    this.autovalidateMode,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final String Function(TimeOfDay)? formatTime;
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
  State<AppTimePickerField> createState() => _AppTimePickerFieldState();
}

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
