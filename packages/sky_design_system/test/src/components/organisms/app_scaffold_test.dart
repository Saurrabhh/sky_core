import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppScaffold', () {
    testWidgets('renders all scaffold widgets and custom background color', (tester) async {
      const bgColor = Colors.yellow;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: AppScaffold(
            backgroundColor: bgColor,
            appBar: AppBar(title: const Text('Top Bar')),
            body: const Text('Main Body'),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: const SizedBox(height: 50, child: Text('Bottom Nav')),
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Top Bar'), findsOneWidget);
      expect(find.text('Main Body'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Bottom Nav'), findsOneWidget);

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, equals(bgColor));
    });
  });
}
