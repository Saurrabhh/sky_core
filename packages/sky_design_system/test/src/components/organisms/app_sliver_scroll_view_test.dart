import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSliverScrollView', () {
    testWidgets('renders slivers inside layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppSliverScrollView(
              sliverAppBar: SliverAppBar(title: Text('Sliver Bar')),
              slivers: [
                SliverToBoxAdapter(child: Text('Sliver Body')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Sliver Bar'), findsOneWidget);
      expect(find.text('Sliver Body'), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('renders footer at the bottom of sliver layout (sticky)', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppSliverScrollView(
              footer: Text('Sliver Footer'),
              stickyFooter: true,
              slivers: [
                SliverToBoxAdapter(child: Text('Sliver Body')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Sliver Body'), findsOneWidget);
      expect(find.text('Sliver Footer'), findsOneWidget);
    });

    testWidgets('renders footer at the bottom of sliver layout (non-sticky)', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppSliverScrollView(
              footer: Text('Sliver Footer'),
              slivers: [
                SliverToBoxAdapter(child: Text('Sliver Body')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Sliver Body'), findsOneWidget);
      expect(find.text('Sliver Footer'), findsOneWidget);
    });
  });
}
