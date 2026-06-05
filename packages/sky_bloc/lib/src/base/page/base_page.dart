import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A base page widget that registers and manages a [BlocBase] instance.
///
/// Coordinates page building, state change listeners, and optional fullscreen
/// loading overlays.
///
/// Example:
/// ```dart
/// class MyPage extends BasePage<MyBloc, MyState> {
///   const MyPage({super.key});
///
///   @override
///   MyBloc createBloc() => MyBloc();
///
///   @override
///   Widget buildPage(BuildContext context) {
///     return const Scaffold(
///       body: Center(child: Text('Page Content')),
///     );
///   }
/// }
/// ```
abstract class BasePage<B extends BlocBase<S>, S> extends StatelessWidget {
  /// Creates a [BasePage] instance.
  const BasePage({super.key});

  /// Creates the BLoC or Cubit of type [B] associated with this page.
  B createBloc();

  /// Builds the UI widget tree for this page.
  Widget buildPage(BuildContext context);

  /// Callback invoked whenever the BLoC state changes.
  void handleStateChange(BuildContext context, S state) {}

  /// Returns whether a fullscreen loading overlay should be shown
  /// for the given [state].
  bool showLoading(S state) => false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createBloc(),
      child: _Page<B, S>(
        builder: buildPage,
        listener: handleStateChange,
        showLoading: showLoading,
      ),
    );
  }
}

class _Page<B extends BlocBase<S>, S> extends StatefulWidget {
  const _Page({
    required this.builder,
    required this.listener,
    required this.showLoading,
  });

  final WidgetBuilder builder;
  final BlocWidgetListener<S> listener;
  final bool Function(S) showLoading;

  @override
  State<_Page> createState() => _PageState<B, S>();
}

class _PageState<B extends BlocBase<S>, S> extends State<_Page> {
  late final OverlayPortalController _overlayPortalController;

  @override
  void initState() {
    super.initState();
    _overlayPortalController = OverlayPortalController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) {
        if (widget.showLoading(state)) {
          _overlayPortalController.show();
        } else {
          _overlayPortalController.hide();
        }
        widget.listener.call(context, state);
      },
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) {
          final theme = Theme.of(context);
          final scrimColor = theme.colorScheme.scrim.withValues(alpha: 0.4);

          return Material(
            type: MaterialType.transparency,
            // 1. BlockSemantics stops screen readers (TalkBack/VoiceOver)
            // from reading the hidden page behind the loader.
            child: BlockSemantics(
              // 2. AbsorbPointer consumes all physical taps, acting as the barrier.
              child: AbsorbPointer(
                // 3. ColoredBox is the most lightweight way to paint a background.
                // It is significantly cheaper than a Container.
                child: ColoredBox(
                  color: scrimColor,
                  // 4. Center the indicator
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
        child: widget.builder(context),
      ),
    );
  }
}
