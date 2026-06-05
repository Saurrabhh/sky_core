import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_icon.dart';
import 'package:sky_design_system/src/components/atoms/app_icon_button.dart';

/// A search input field.
class AppSearchBar extends StatefulWidget {
  /// Creates an [AppSearchBar] instance.
  const AppSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
  });

  /// The controller of this widget.
  final TextEditingController? controller;
  /// The hintText of this widget.
  final String hintText;
  /// The onChanged of this widget.
  final ValueChanged<String>? onChanged;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

/// The [_AppSearchBarState] widget.
class _AppSearchBarState extends State<AppSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void didUpdateWidget(AppSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? TextEditingController();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      hintText: widget.hintText,
      onChanged: widget.onChanged,
      leading: const AppIcon.md(Icons.search),
      trailing: [
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, child) {
            if (value.text.isEmpty) {
              return const SizedBox.shrink();
            }
            return AppIconButton(
              icon: Icons.close,
              onPressed: () {
                _controller.clear();
                widget.onChanged?.call('');
              },
            );
          },
        ),
      ],
    );
  }
}
