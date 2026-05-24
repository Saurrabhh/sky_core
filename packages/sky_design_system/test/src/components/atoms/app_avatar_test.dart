import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final transparentPng = Uint8List.fromList([
    137,
    80,
    78,
    71,
    13,
    10,
    26,
    10,
    0,
    0,
    0,
    13,
    73,
    72,
    68,
    82,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    1,
    8,
    6,
    0,
    0,
    0,
    31,
    21,
    196,
    137,
    0,
    0,
    0,
    10,
    73,
    68,
    65,
    84,
    120,
    156,
    99,
    0,
    1,
    0,
    0,
    5,
    0,
    1,
    13,
    10,
    45,
    180,
    0,
    0,
    0,
    0,
    73,
    69,
    78,
    68,
    174,
    66,
    96,
    130,
  ]);

  group('AppAvatar', () {
    testWidgets('renders initials when no background image is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppAvatar(initials: 'AB'),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('AB'), findsOneWidget);

      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.radius, AppRadius.lgIncreased);
      expect(avatar.backgroundImage, isNull);
    });

    testWidgets(
      'renders background image and does not show initials when both are '
      'provided',
      (tester) async {
        final mockImage = MemoryImage(transparentPng);
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppAvatar(
                initials: 'XY',
                backgroundImage: mockImage,
                radius: 40,
              ),
            ),
          ),
        );

        expect(find.byType(CircleAvatar), findsOneWidget);
        expect(
          find.text('XY'),
          findsNothing,
        ); // Should not show initials if image is present

        final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
        expect(avatar.radius, 40.0);
        expect(avatar.backgroundImage, mockImage);
      },
    );

    testWidgets('renders empty avatar when both image and initials are null', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppAvatar(),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.child, isNull);
    });
  });
}
