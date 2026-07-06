import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_devtools/src/dev_tools_options.dart';
import 'package:sky_devtools/src/structured_log.dart';
import 'package:sky_devtools/src/talker_app_logger.dart';
import 'package:sky_devtools/src/widgets/json_tree_view.dart';
import 'package:talker_flutter/talker_flutter.dart' as talker_ui;

/// Draggable Picture-in-Picture DevTools menu.
class DevToolsOverlay extends StatefulWidget {
  /// Creates a [DevToolsOverlay].
  const DevToolsOverlay({
    required this.child,
    required this.options,
    required this.talkerLogger,
    super.key,
  });

  /// The main application widget tree.
  final Widget child;

  /// Configuration options for environments and dev actions.
  final DevToolsOptions options;

  /// The logger instance to display logs from.
  final TalkerAppLogger talkerLogger;

  @override
  State<DevToolsOverlay> createState() => _DevToolsOverlayState();
}

enum _OverlayState {
  bubble,
  pip,
  expanded,
}

class _DevToolsOverlayState extends State<DevToolsOverlay> {
  Offset _position = const Offset(20, 100);
  _OverlayState _state = _OverlayState.pip;
  String _logFilter = '';
  final TextEditingController _filterController = TextEditingController();

  String _activeTab = 'ALL';
  talker_ui.TalkerData? _selectedLog;
  bool _isFullScreen = false;
  double? _customWidth;
  double? _customHeight;

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    final isExpandedFull = _state == _OverlayState.expanded && _isFullScreen;

    // Keep position within safe screen bounds (only when not in fullscreen)
    if (!isExpandedFull) {
      final minX = padding.left;
      final maxX = (size.width - padding.right - 60).clamp(minX, size.width);
      final minY = padding.top;
      final maxY = (size.height - padding.bottom - 60).clamp(minY, size.height);

      _position = Offset(
        _position.dx.clamp(minX, maxX),
        _position.dy.clamp(minY, maxY),
      );
    }

    return Stack(
      children: [
        // Underlying application remains interactive
        widget.child,

        // Developer tools floating overlay widget
        if (isExpandedFull)
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(
                child: _buildOverlayContent(size),
              ),
            ),
          )
        else
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Material(
              type: MaterialType.transparency,
              child: GestureDetector(
                onPanUpdate: (_state == _OverlayState.expanded)
                    ? null
                    : (details) {
                        setState(() {
                          _position += details.delta;
                        });
                      },
                child: _buildOverlayContent(size),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOverlayContent(Size size) {
    switch (_state) {
      case _OverlayState.bubble:
        return _buildBubble();
      case _OverlayState.pip:
        return _buildPiP();
      case _OverlayState.expanded:
        return _buildExpandedPanel(size);
    }
  }

  Widget _buildBubble() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.bug_report, color: Colors.white),
        onPressed: () => setState(() => _state = _OverlayState.expanded),
      ),
    );
  }

  Widget _buildPiP() {
    return Container(
      width: 260,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blueAccent.withValues(alpha: 0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.bug_report, color: Colors.blueAccent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: StreamBuilder<talker_ui.TalkerData>(
              stream: widget.talkerLogger.talker.stream,
              builder: (context, snapshot) {
                final latestLog =
                    snapshot.data?.message ?? 'Monitoring app logs...';
                return Text(
                  latestLog,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.open_in_full, color: Colors.white, size: 16),
            onPressed: () => setState(() => _state = _OverlayState.expanded),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedPanel(Size size) {
    final defaultWidth = (size.width * 0.9).clamp(280.0, 480.0);
    final defaultHeight = (size.height * 0.55).clamp(300.0, 600.0);

    final panelWidth = _isFullScreen
        ? size.width
        : (_customWidth ?? defaultWidth);
    final panelHeight = _isFullScreen
        ? size.height
        : (_customHeight ?? defaultHeight);

    final mainPanel = Container(
      width: panelWidth,
      height: panelHeight,
      decoration: BoxDecoration(
        borderRadius: _isFullScreen
            ? BorderRadius.zero
            : BorderRadius.circular(16),
        border: _isFullScreen ? null : Border.all(color: Colors.white10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: _isFullScreen
            ? BorderRadius.zero
            : BorderRadius.circular(16),
        child: Material(
          color: const Color(0xFF151515),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute<void>(
                  builder: (context) => DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        // Top Bar
                        GestureDetector(
                          onPanUpdate: _isFullScreen
                              ? null
                              : (details) {
                                  setState(() {
                                    _position += details.delta;
                                  });
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF202020),
                              borderRadius: _isFullScreen
                                  ? BorderRadius.zero
                                  : const BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sky DevTools',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      icon: Icon(
                                        _isFullScreen
                                            ? Icons.fullscreen_exit
                                            : Icons.fullscreen,
                                        color: Colors.white60,
                                        size: 16,
                                      ),
                                      onPressed: () => setState(
                                        () => _isFullScreen = !_isFullScreen,
                                      ),
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      icon: const Icon(
                                        Icons.picture_in_picture,
                                        color: Colors.white60,
                                        size: 16,
                                      ),
                                      onPressed: () => setState(
                                        () => _state = _OverlayState.pip,
                                      ),
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      icon: const Icon(
                                        Icons.minimize,
                                        color: Colors.white60,
                                        size: 16,
                                      ),
                                      onPressed: () => setState(
                                        () => _state = _OverlayState.bubble,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Tab Bar Header
                        const TabBar(
                          tabs: [
                            Tab(
                              child: Text(
                                'Logs',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Actions',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'System',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                          labelColor: Colors.blueAccent,
                          unselectedLabelColor: Colors.white54,
                          indicatorColor: Colors.blueAccent,
                          dividerColor: Colors.white10,
                        ),

                        // Tab View Body
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildLogsTab(),
                              _buildActionsTab(),
                              _buildSystemInfoTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    if (_isFullScreen) {
      return mainPanel;
    }

    const handleSize = 8.0;
    const cornerSize = 16.0;

    return SizedBox(
      width: panelWidth + 16.0,
      height: panelHeight + 16.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 8,
            top: 8,
            child: mainPanel,
          ),
          // Left handle
          _buildResizeHandle(
            left: 0,
            top: cornerSize,
            right: null,
            bottom: null,
            width: handleSize,
            height: panelHeight + 16.0 - (cornerSize * 2),
            cursor: SystemMouseCursors.resizeLeftRight,
            onDrag: (details) {
              setState(() {
                final newWidth = (panelWidth - details.delta.dx).clamp(
                  280.0,
                  size.width,
                );
                if (newWidth != panelWidth) {
                  _position = Offset(
                    _position.dx + details.delta.dx,
                    _position.dy,
                  );
                  _customWidth = newWidth;
                }
              });
            },
          ),
          // Right handle
          _buildResizeHandle(
            left: null,
            top: cornerSize,
            right: 0,
            bottom: null,
            width: handleSize,
            height: panelHeight + 16.0 - (cornerSize * 2),
            cursor: SystemMouseCursors.resizeLeftRight,
            onDrag: (details) {
              setState(() {
                _customWidth = (panelWidth + details.delta.dx).clamp(
                  280.0,
                  size.width,
                );
              });
            },
          ),
          // Top handle
          _buildResizeHandle(
            left: cornerSize,
            top: 0,
            right: null,
            bottom: null,
            width: panelWidth + 16.0 - (cornerSize * 2),
            height: handleSize,
            cursor: SystemMouseCursors.resizeUpDown,
            onDrag: (details) {
              setState(() {
                final newHeight = (panelHeight - details.delta.dy).clamp(
                  200.0,
                  size.height,
                );
                if (newHeight != panelHeight) {
                  _position = Offset(
                    _position.dx,
                    _position.dy + details.delta.dy,
                  );
                  _customHeight = newHeight;
                }
              });
            },
          ),
          // Bottom handle
          _buildResizeHandle(
            left: cornerSize,
            top: null,
            right: null,
            bottom: 0,
            width: panelWidth + 16.0 - (cornerSize * 2),
            height: handleSize,
            cursor: SystemMouseCursors.resizeUpDown,
            onDrag: (details) {
              setState(() {
                _customHeight = (panelHeight + details.delta.dy).clamp(
                  200.0,
                  size.height,
                );
              });
            },
          ),
          // Top-Left corner
          _buildResizeHandle(
            left: 0,
            top: 0,
            right: null,
            bottom: null,
            width: cornerSize,
            height: cornerSize,
            cursor: SystemMouseCursors.resizeUpLeftDownRight,
            onDrag: (details) {
              setState(() {
                final newWidth = (panelWidth - details.delta.dx).clamp(
                  280.0,
                  size.width,
                );
                if (newWidth != panelWidth) {
                  _position = Offset(
                    _position.dx + details.delta.dx,
                    _position.dy,
                  );
                  _customWidth = newWidth;
                }
                final newHeight = (panelHeight - details.delta.dy).clamp(
                  200.0,
                  size.height,
                );
                if (newHeight != panelHeight) {
                  _position = Offset(
                    _position.dx,
                    _position.dy + details.delta.dy,
                  );
                  _customHeight = newHeight;
                }
              });
            },
          ),
          // Top-Right corner
          _buildResizeHandle(
            left: null,
            top: 0,
            right: 0,
            bottom: null,
            width: cornerSize,
            height: cornerSize,
            cursor: SystemMouseCursors.resizeUpRightDownLeft,
            onDrag: (details) {
              setState(() {
                _customWidth = (panelWidth + details.delta.dx).clamp(
                  280.0,
                  size.width,
                );
                final newHeight = (panelHeight - details.delta.dy).clamp(
                  200.0,
                  size.height,
                );
                if (newHeight != panelHeight) {
                  _position = Offset(
                    _position.dx,
                    _position.dy + details.delta.dy,
                  );
                  _customHeight = newHeight;
                }
              });
            },
          ),
          // Bottom-Left corner
          _buildResizeHandle(
            left: 0,
            top: null,
            right: null,
            bottom: 0,
            width: cornerSize,
            height: cornerSize,
            cursor: SystemMouseCursors.resizeUpRightDownLeft,
            onDrag: (details) {
              setState(() {
                final newWidth = (panelWidth - details.delta.dx).clamp(
                  280.0,
                  size.width,
                );
                if (newWidth != panelWidth) {
                  _position = Offset(
                    _position.dx + details.delta.dx,
                    _position.dy,
                  );
                  _customWidth = newWidth;
                }
                _customHeight = (panelHeight + details.delta.dy).clamp(
                  200.0,
                  size.height,
                );
              });
            },
          ),
          // Bottom-Right corner
          _buildResizeHandle(
            left: null,
            top: null,
            right: 0,
            bottom: 0,
            width: cornerSize,
            height: cornerSize,
            cursor: SystemMouseCursors.resizeUpLeftDownRight,
            onDrag: (details) {
              setState(() {
                _customWidth = (panelWidth + details.delta.dx).clamp(
                  280.0,
                  size.width,
                );
                _customHeight = (panelHeight + details.delta.dy).clamp(
                  200.0,
                  size.height,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResizeHandle({
    required double? left,
    required double? top,
    required double? right,
    required double? bottom,
    required double width,
    required double height,
    required MouseCursor cursor,
    required GestureDragUpdateCallback onDrag,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: onDrag,
        child: MouseRegion(
          cursor: cursor,
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }

  Widget _buildLogsTab() {
    if (_selectedLog != null) {
      return _buildLogDetail(_selectedLog!);
    }

    return Column(
      children: [
        // Search Filter Bar
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: TextField(
                    controller: _filterController,
                    onChanged: (val) =>
                        setState(() => _logFilter = val.toLowerCase()),
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                    decoration: InputDecoration(
                      hintText: 'Search logs...',
                      hintStyle: const TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 14,
                        color: Colors.white38,
                      ),
                      suffixIcon: _logFilter.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                size: 14,
                                color: Colors.white38,
                              ),
                              onPressed: () {
                                setState(() {
                                  _filterController.clear();
                                  _logFilter = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.05),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.delete_sweep,
                  color: Colors.redAccent,
                  size: 18,
                ),
                onPressed: () => widget.talkerLogger.clearLogs(),
              ),
            ],
          ),
        ),

        // Category Tabs
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['ALL', 'NETWORK', 'BLOC', 'CONSOLE', 'ERRORS'].map((
              tab,
            ) {
              final isSelected = _activeTab == tab;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: Colors.blueAccent,
                  backgroundColor: Colors.white10,
                  onSelected: (_) {
                    setState(() {
                      _activeTab = tab;
                      _selectedLog = null;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 4),

        // Live Log List
        Expanded(
          child: StreamBuilder<Object>(
            stream: widget.talkerLogger.talker.stream,
            builder: (context, snapshot) {
              final logs = widget.talkerLogger.talker.history.where((log) {
                // Tab filter
                if (_activeTab == 'NETWORK') {
                  if (log is! StructuredNetworkLog) return false;
                } else if (_activeTab == 'BLOC') {
                  if (log is! StructuredBlocLog) return false;
                } else if (_activeTab == 'ERRORS') {
                  final isErr =
                      log.exception != null ||
                      log.error != null ||
                      log is talker_ui.TalkerError ||
                      log is talker_ui.TalkerException ||
                      log.title?.toLowerCase().contains('error') == true ||
                      log.title?.toLowerCase().contains('critical') == true ||
                      log.title?.toLowerCase().contains('exception') == true;
                  if (!isErr) return false;
                } else if (_activeTab == 'CONSOLE') {
                  if (log is StructuredNetworkLog || log is StructuredBlocLog) {
                    return false;
                  }
                  final isErr =
                      log.exception != null ||
                      log.error != null ||
                      log is talker_ui.TalkerError ||
                      log is talker_ui.TalkerException;
                  if (isErr) return false;
                }

                // Text filter
                if (_logFilter.isEmpty) return true;
                final text =
                    '''${log.title ?? ''} ${log.message ?? ''} ${log.exception?.toString() ?? ''} ${log.error?.toString() ?? ''} ${log.generateTextMessage()}'''
                        .toLowerCase();
                return text.contains(_logFilter);
              }).toList();

              if (logs.isEmpty) {
                return const Center(
                  child: Text(
                    'No logs match filters.',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log =
                      logs[logs.length - 1 - index]; // Show latest logs first
                  final color = _getLogLevelColor(log.title);
                  return InkWell(
                    onTap: () => setState(() => _selectedLog = log),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  log.title ?? 'LOG',
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _formatTime(log.time),
                                style: const TextStyle(
                                  color: Colors.white30,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            log.message ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 9,
                              fontFamily: 'monospace',
                            ),
                          ),
                          if (log.exception != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              log.exception.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 9,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLogDetail(talker_ui.TalkerData log) {
    final color = _getLogLevelColor(log.title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Detail Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            border: Border(bottom: BorderSide(color: Colors.white10)),
          ),
          child: Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () => setState(() => _selectedLog = null),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  log.title ?? 'LOG',
                  style: TextStyle(
                    color: color,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _formatTime(log.time),
                  style: const TextStyle(color: Colors.white30, fontSize: 10),
                ),
              ),
              if (log is StructuredNetworkLog)
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: const Icon(Icons.code, size: 12),
                  label: const Text(
                    'Copy cURL',
                    style: TextStyle(fontSize: 10),
                  ),
                  onPressed: () {
                    final curl = _generateCurl(log);
                    unawaited(Clipboard.setData(ClipboardData(text: curl)));
                  },
                ),
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.white60, size: 14),
                onPressed: () {
                  unawaited(
                    Clipboard.setData(
                      ClipboardData(text: log.generateTextMessage()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Detail Content
        Expanded(
          child: log is StructuredNetworkLog
              ? _buildNetworkLogDetail(log)
              : _buildStandardLogDetail(log),
        ),
      ],
    );
  }

  Widget _buildNetworkLogDetail(StructuredNetworkLog log) {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.blueAccent,
            labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'General'),
              Tab(text: 'Headers'),
              Tab(text: 'Request Body'),
              Tab(text: 'Response Body'),
            ],
          ),
          Expanded(
            child: ColoredBox(
              color: const Color(0xFF101010),
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                // Disable swipe gestures to avoid horizontal scroll conflicts
                children: [
                  _buildNetworkGeneralSection(log),
                  _buildNetworkHeadersSection(log),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        top: 4,
                      ),
                      child: JsonTreeView(
                        json: log.requestBody,
                        navigatorKey: widget.options.navigatorKey,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        top: 4,
                      ),
                      child: JsonTreeView(
                        json: log.responseBody,
                        navigatorKey: widget.options.navigatorKey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkGeneralSection(StructuredNetworkLog log) {
    final statusColor = log.statusCode == null
        ? Colors.redAccent
        : (log.statusCode! >= 200 && log.statusCode! < 300
              ? Colors.greenAccent
              : Colors.orangeAccent);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildDetailRow('URL', log.url, isSelectable: true),
        _buildDetailRow('Method', log.method),
        _buildDetailRow(
          'Status Code',
          log.statusCode?.toString() ?? 'Failed / Connection Error',
          valueColor: statusColor,
        ),
        _buildDetailRow('Duration', '${log.durationMs} ms'),
        _buildDetailRow('Logged Time', log.time.toString()),
      ],
    );
  }

  dynamic _flattenHeaders(dynamic headers) {
    if (headers is Map<String, dynamic>) {
      return headers.map((key, value) {
        if (value is List && value.length == 1) {
          return MapEntry(key, value.first);
        }
        return MapEntry(key, value);
      });
    }
    return headers;
  }

  Widget _buildNetworkHeadersSection(StructuredNetworkLog log) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12,
          top: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Request Headers',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            JsonTreeView(
              json: _flattenHeaders(log.requestHeaders),
              rootCopyLabel: 'Copy Request Headers',
              navigatorKey: widget.options.navigatorKey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Response Headers',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            JsonTreeView(
              json: _flattenHeaders(log.responseHeaders),
              rootCopyLabel: 'Copy Response Headers',
              navigatorKey: widget.options.navigatorKey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardLogDetail(talker_ui.TalkerData log) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        if (log.message != null) ...[
          const Text(
            'Message',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          SelectableText(
            log.message!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (log.exception != null) ...[
          const Text(
            'Exception',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          SelectableText(
            log.exception.toString(),
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (log.stackTrace != null) ...[
          const Text(
            'Stack Trace',
            style: TextStyle(
              color: Colors.white30,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          SelectableText(
            log.stackTrace.toString(),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    bool isSelectable = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white30, fontSize: 10),
          ),
          const SizedBox(height: 2),
          if (isSelectable)
            SelectableText(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white70,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white70,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          const Divider(color: Colors.white10),
        ],
      ),
    );
  }

  String _generateCurl(StructuredNetworkLog log) {
    final buffer = StringBuffer()
      ..write('curl "${log.url}"')
      ..write(' -X ${log.method}');
    log.requestHeaders.forEach((key, value) {
      buffer.write(' -H "$key: $value"');
    });
    if (log.requestBody != null) {
      final String bodyStr;
      if (log.requestBody is Map || log.requestBody is List) {
        bodyStr = jsonEncode(log.requestBody);
      } else {
        bodyStr = log.requestBody.toString();
      }
      final escapedBody = bodyStr.replaceAll("'", r"'\''");
      buffer.write(" -d '$escapedBody'");
    }
    return buffer.toString();
  }

  Widget _buildActionsTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        // Settings Buttons
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.delete_forever,
            color: Colors.redAccent,
            size: 20,
          ),
          title: const Text(
            'Reset Storage & Cache',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          subtitle: const Text(
            'Clear local Hive & Preferences databases',
            style: TextStyle(color: Colors.white54, fontSize: 10),
          ),
          onTap: () async {
            final targetContext =
                widget.options.navigatorKey?.currentContext ?? context;
            final confirm = await showDialog<bool>(
              context: targetContext,
              builder: (ctx) => AlertDialog(
                backgroundColor: const Color(0xFF2C2C2C),
                title: const Text(
                  'Reset App Cache?',
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                  '''This will erase all local databases, Hive boxes, and preferences. The app will need to reload.''',
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              await widget.options.onClearCache();
            }
          },
        ),

        const ListTile(
          dense: true,
          leading: Icon(Icons.share, color: Colors.blueAccent, size: 20),
          title: Text(
            'Export App Logs',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          subtitle: Text(
            'Share persistent text file containing dev logs',
            style: TextStyle(color: Colors.white54, fontSize: 10),
          ),
          onTap: TalkerAppLogger.shareLogs,
        ),
      ],
    );
  }

  Widget _buildSystemInfoTab() {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _buildInfoRow('Device Orientation', orientation.name.toUpperCase()),
        _buildInfoRow(
          'Screen Pixels',
          '''${size.width.toStringAsFixed(0)} x ${size.height.toStringAsFixed(0)}''',
        ),
        _buildInfoRow(
          'Device Pixel Ratio',
          MediaQuery.of(context).devicePixelRatio.toStringAsFixed(1),
        ),
        _buildInfoRow(
          'Locale Info',
          Localizations.localeOf(context).toString(),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Color _getLogLevelColor(String? title) {
    if (title == null) return Colors.blueAccent;
    final t = title.toLowerCase();
    if (t.contains('error') ||
        t.contains('exception') ||
        t.contains('critical')) {
      return Colors.redAccent;
    }
    if (t.contains('warning')) return Colors.orangeAccent;
    if (t.contains('info')) return Colors.greenAccent;
    if (t.contains('debug')) return Colors.grey;
    return Colors.blueAccent;
  }

  String _formatTime(DateTime time) {
    return '''${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}''';
  }
}
