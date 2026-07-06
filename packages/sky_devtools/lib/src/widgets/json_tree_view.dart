import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// An interactive file-editor style inspector for JSON payloads.
/// Features code folding, line numbering, custom highlighting,
/// and long-press copying utilities.
class JsonTreeView extends StatefulWidget {
  /// Creates a [JsonTreeView].
  const JsonTreeView({
    required this.json,
    this.showRootCopy = true,
    this.rootCopyLabel = 'Copy Full Body',
    this.navigatorKey,
    super.key,
  });

  /// The JSON data to inspect.
  final dynamic json;

  /// Whether to display a copy button for the entire JSON payload at the root
  /// level.
  final bool showRootCopy;

  /// The label for the root copy button.
  final String rootCopyLabel;

  /// Global key to target the root app navigator.
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  State<JsonTreeView> createState() => _JsonTreeViewState();
}

class _JsonTreeViewState extends State<JsonTreeView> {
  late List<_JsonLine> _allLines;
  late List<_FoldBlock> _foldBlocks;

  @override
  void initState() {
    super.initState();
    _parseJsonContent();
  }

  @override
  void didUpdateWidget(JsonTreeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.json != widget.json) {
      _parseJsonContent();
    }
  }

  void _parseJsonContent() {
    final parsed = _parseJson(widget.json);
    _allLines = [];
    _buildJsonLines(parsed, _allLines, 0, '', '', true);
    _foldBlocks = _buildFoldBlocks(_allLines);
  }

  @override
  Widget build(BuildContext context) {
    if (_allLines.isEmpty) {
      return const AppText.bodySmall('null', color: Colors.redAccent);
    }

    // Filter visible indices based on code folding states
    final visibleIndices = <int>[];
    var i = 0;
    while (i < _allLines.length) {
      visibleIndices.add(i);
      final collapsedBlock = _foldBlocks.firstWhere(
        (b) => b.startIdx == i && b.isCollapsed,
        orElse: () => _FoldBlock(startIdx: -1, endIdx: -1),
      );
      if (collapsedBlock.startIdx != -1 && collapsedBlock.endIdx != -1) {
        i =
            collapsedBlock.endIdx +
            1; // Skip folding block children and the closing bracket
      } else {
        i++;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showRootCopy && _allLines.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 30),
                visualDensity: VisualDensity.compact,
              ),
              icon: const Icon(Icons.copy_all, size: 14),
              label: Text(
                widget.rootCopyLabel,
                style: const TextStyle(fontSize: 11),
              ),
              onPressed: () => _copyText(
                context,
                jsonEncode(_parseJson(widget.json)),
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF101010),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(visibleIndices.length, (idx) {
              final lineIdx = visibleIndices[idx];
              final line = _allLines[lineIdx];

              // Check if line represents a foldable start block
              final block = _foldBlocks.firstWhere(
                (b) => b.startIdx == lineIdx,
                orElse: () => _FoldBlock(startIdx: -1, endIdx: -1),
              );

              final isCollapsed = block.startIdx != -1 && block.isCollapsed;
              final isFoldable = block.startIdx != -1;

              // Format text if collapsed
              var displayText = line.text;
              if (isCollapsed) {
                final hasComma = _allLines[block.endIdx].text.endsWith(',');
                final suffix = hasComma ? ',' : '';
                if (line.text.endsWith('{')) {
                  displayText =
                      '''${line.text.substring(0, line.text.length - 1)}{...}$suffix''';
                } else if (line.text.endsWith('[')) {
                  displayText =
                      '''${line.text.substring(0, line.text.length - 1)}[...]$suffix''';
                }
              }

              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onLongPressStart: (details) =>
                    _showContextMenu(context, line, block, details),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    right: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Line Number
                      Container(
                        width: 32,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8),
                        child: AppText.bodySmall(
                          '${lineIdx + 1}',
                          color: Colors.white30,
                        ),
                      ),
                      // Collapse / Expand toggle button (chevron next to lines)
                      SizedBox(
                        width: 20,
                        child: isFoldable
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    block.isCollapsed = !block.isCollapsed;
                                  });
                                },
                                child: Center(
                                  child: AppIcon.sm(
                                    isCollapsed
                                        ? Icons.chevron_right
                                        : Icons.expand_more,
                                    color: Colors.white54,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      // Code text with syntax highlight (no Expanded to support
                      // natural horizontal width)
                      RichText(
                        text: TextSpan(
                          children: _highlightLine(displayText),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _showContextMenu(
    BuildContext context,
    _JsonLine line,
    _FoldBlock block,
    LongPressStartDetails details,
  ) {
    final hasKey = line.key.isNotEmpty;
    final hasVal = line.value != null;

    final overlayState = Overlay.of(context);
    final overlay = overlayState.context.findRenderObject()! as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromLTWH(
        details.globalPosition.dx,
        details.globalPosition.dy,
        0,
        0,
      ),
      Offset.zero & overlay.size,
    );

    unawaited(
      showMenu<String>(
        context: context,
        position: position,
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.white10),
        ),
        items: [
          if (hasKey)
            const PopupMenuItem<String>(
              value: 'copy_key',
              child: AppText.bodyMedium('Copy Key', color: Colors.white70),
            ),
          if (hasVal)
            const PopupMenuItem<String>(
              value: 'copy_value',
              child: AppText.bodyMedium('Copy Value', color: Colors.white70),
            ),
          if (hasKey && hasVal)
            const PopupMenuItem<String>(
              value: 'copy_pair',
              child: AppText.bodyMedium(
                'Copy Key-Value Pair',
                color: Colors.white70,
              ),
            ),
          const PopupMenuItem<String>(
            value: 'copy_line',
            child: AppText.bodyMedium(
              'Copy Full Line Text',
              color: Colors.white70,
            ),
          ),
          if (line.path.isNotEmpty)
            const PopupMenuItem<String>(
              value: 'copy_path',
              child: AppText.bodyMedium(
                'Copy JSON Path',
                color: Colors.white70,
              ),
            ),
          if (block.startIdx != -1)
            PopupMenuItem<String>(
              value: 'toggle_block',
              child: AppText.bodyMedium(
                block.isCollapsed ? 'Expand Block' : 'Collapse Block',
                color: Colors.white70,
              ),
            ),
        ],
      ).then((selected) {
        if (selected == null) return;
        if (!context.mounted) return;
        switch (selected) {
          case 'copy_key':
            _copyText(context, line.key);
          case 'copy_value':
            final strVal = line.value is Map || line.value is List
                ? jsonEncode(line.value)
                : line.value.toString();
            _copyText(context, strVal);
          case 'copy_pair':
            final strVal = line.value is Map || line.value is List
                ? jsonEncode(line.value)
                : line.value.toString();
            _copyText(context, '"${line.key}": $strVal');
          case 'copy_line':
            _copyText(context, line.text.trim());
          case 'copy_path':
            _copyText(context, line.path);
          case 'toggle_block':
            setState(() {
              block.isCollapsed = !block.isCollapsed;
            });
        }
      }),
    );
  }
}

class _JsonLine {
  _JsonLine({
    required this.key,
    required this.value,
    required this.text,
    required this.indent,
    required this.path,
    this.isBlockStart = false,
    this.isBlockEnd = false,
  });

  final String key;
  final dynamic value;
  final String text;
  final int indent;
  final String path;
  final bool isBlockStart;
  final bool isBlockEnd;
}

class _FoldBlock {
  _FoldBlock({
    required this.startIdx,
    required this.endIdx,
  });

  final int startIdx;
  final int endIdx;
  bool isCollapsed = false;
}

dynamic _parseJson(dynamic raw) {
  if (raw is String) {
    try {
      return jsonDecode(raw);
    } on Object {
      return raw;
    }
  }
  return raw;
}

void _buildJsonLines(
  dynamic item,
  List<_JsonLine> lines,
  int indent,
  String path,
  String key,
  bool isLast,
) {
  final indentStr = '  ' * indent;
  final keyPrefix = key.isNotEmpty ? '"$key": ' : '';
  final comma = isLast ? '' : ',';

  if (item is Map<String, dynamic>) {
    lines.add(
      _JsonLine(
        key: key,
        value: item,
        text: '$indentStr$keyPrefix{',
        indent: indent,
        path: path,
        isBlockStart: true,
      ),
    );

    final entries = item.entries.toList();
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final newPath = path.isEmpty ? entry.key : '$path/${entry.key}';
      _buildJsonLines(
        entry.value,
        lines,
        indent + 1,
        newPath,
        entry.key,
        i == entries.length - 1,
      );
    }

    lines.add(
      _JsonLine(
        key: '',
        value: null,
        text: '$indentStr}$comma',
        indent: indent,
        path: path,
        isBlockEnd: true,
      ),
    );
  } else if (item is List<dynamic>) {
    lines.add(
      _JsonLine(
        key: key,
        value: item,
        text: '$indentStr$keyPrefix[',
        indent: indent,
        path: path,
        isBlockStart: true,
      ),
    );

    for (var i = 0; i < item.length; i++) {
      final newPath = path.isEmpty ? '[$i]' : '$path[$i]';
      _buildJsonLines(
        item[i],
        lines,
        indent + 1,
        newPath,
        '',
        i == item.length - 1,
      );
    }

    lines.add(
      _JsonLine(
        key: '',
        value: null,
        text: '$indentStr]$comma',
        indent: indent,
        path: path,
        isBlockEnd: true,
      ),
    );
  } else {
    final String valStr;
    if (item == null) {
      valStr = 'null';
    } else if (item is String) {
      valStr = '"$item"';
    } else {
      valStr = item.toString();
    }

    lines.add(
      _JsonLine(
        key: key,
        value: item,
        text: '$indentStr$keyPrefix$valStr$comma',
        indent: indent,
        path: path,
      ),
    );
  }
}

List<_FoldBlock> _buildFoldBlocks(List<_JsonLine> lines) {
  final blocks = <_FoldBlock>[];
  final stack = <int>[];

  for (var i = 0; i < lines.length; i++) {
    if (lines[i].isBlockStart) {
      stack.add(i);
    } else if (lines[i].isBlockEnd) {
      if (stack.isNotEmpty) {
        final startIdx = stack.removeLast();
        blocks.add(_FoldBlock(startIdx: startIdx, endIdx: i));
      }
    }
  }
  return blocks;
}

void _copyText(BuildContext context, String text) {
  unawaited(Clipboard.setData(ClipboardData(text: text)));
}

List<TextSpan> _highlightLine(String text) {
  final spans = <TextSpan>[];

  // Find indentation prefix
  final indentMatch = RegExp(r'^(\s*)').firstMatch(text);
  final indent = indentMatch?.group(1) ?? '';
  spans.add(TextSpan(text: indent));

  final content = text.substring(indent.length);

  // Split key and value parts
  final keyRegex = RegExp(r'^("([^"]+)")(\s*:\s*)(.*)$');
  final match = keyRegex.firstMatch(content);
  if (match != null) {
    final keyWithQuotes = match.group(1) ?? '';
    final colon = match.group(3) ?? '';
    final rest = match.group(4) ?? '';

    spans
      ..add(
        TextSpan(
          text: keyWithQuotes,
          style: const TextStyle(color: Colors.orangeAccent),
        ),
      )
      ..add(
        TextSpan(
          text: colon,
          style: const TextStyle(color: Colors.white70),
        ),
      )
      ..addAll(_highlightValue(rest));
  } else {
    spans.addAll(_highlightValue(content));
  }
  return spans;
}

List<TextSpan> _highlightValue(String text) {
  final spans = <TextSpan>[];
  var trimmed = text.trim();
  if (trimmed.isEmpty) return spans;

  final leadingSpaces = text.substring(0, text.indexOf(trimmed));
  spans.add(TextSpan(text: leadingSpaces));

  var trailing = '';
  if (trimmed.endsWith(',')) {
    trailing = ',';
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }

  if (trimmed.startsWith('"') && trimmed.endsWith('"')) {
    spans.add(
      TextSpan(
        text: trimmed,
        style: const TextStyle(color: Colors.greenAccent),
      ),
    );
  } else if (trimmed == 'true' || trimmed == 'false') {
    spans.add(
      TextSpan(
        text: trimmed,
        style: const TextStyle(color: Colors.purpleAccent),
      ),
    );
  } else if (RegExp(r'^-?\d+(\.\d+)?$').hasMatch(trimmed)) {
    spans.add(
      TextSpan(
        text: trimmed,
        style: const TextStyle(color: Colors.lightBlueAccent),
      ),
    );
  } else if (trimmed == 'null') {
    spans.add(
      TextSpan(
        text: trimmed,
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  } else {
    spans.add(
      TextSpan(
        text: trimmed,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }

  if (trailing.isNotEmpty) {
    spans.add(
      TextSpan(
        text: trailing,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
  return spans;
}
