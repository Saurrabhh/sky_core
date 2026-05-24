import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTopBar', () {
    testWidgets('renders AppBar with parameters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            appBar: AppTopBar(
              title: 'Dashboard',
              centerTitle: true,
              leading: const Icon(Icons.menu),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
    });

    test('preferredSize calculated correctly with and without bottom widget', () {
      const topBarWithoutBottom = AppTopBar(title: 'Title');
      expect(topBarWithoutBottom.preferredSize.height, equals(kToolbarHeight));

      const bottomWidget = PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: SizedBox.shrink(),
      );
      const topBarWithBottom = AppTopBar(
        title: 'Title',
        bottom: bottomWidget,
      );
      expect(topBarWithBottom.preferredSize.height, equals(kToolbarHeight + 48.0));
    });
  });
}
