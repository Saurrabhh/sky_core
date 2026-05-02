import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_icon.dart';
import 'package:sky_design_system/src/components/atoms/app_icon_button.dart';
import 'package:sky_design_system/src/components/atoms/app_text_field.dart';

/// A composite input atom specifically for search fields.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // Rebuild to show/hide clear icon
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      hintText: widget.hintText,
      onChanged: widget.onChanged,
      prefixIcon: const AppIcon(Icons.search),
      suffixIcon: _controller.text.isNotEmpty
          ? AppIconButton(
              icon: Icons.close,
              onPressed: () {
                _controller.clear();
                widget.onChanged?.call('');
              },
            )
          : null,
    );
  }
}