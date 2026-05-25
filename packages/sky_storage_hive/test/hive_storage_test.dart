import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';

import 'package:sky_storage_hive/sky_storage_hive.dart';

class MockAdapterRegisterer implements HiveAdapterRegisterer {
  bool called = false;

  @override
  void registerAdapters() {
    called = true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HiveDao Tests', () {
    late Directory tempDir;
    late Box<String> box;
    late HiveDao<String> dao;

    setUp(() async {
      tempDir = Directory.systemTemp.createTempSync('hive_test');
      Hive.init(tempDir.path);
      box = await Hive.openBox<String>('test_box');
      dao = HiveDao<String>(box: box);
    });

    tearDown(() async {
      await Hive.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('put and get value', () async {
      await dao.put('key1', 'value1');
      expect(await dao.get('key1'), equals('value1'));
    });

    test('getAll returns all values', () async {
      await dao.put('key1', 'value1');
      await dao.put('key2', 'value2');
      final all = await dao.getAll();
      expect(all, containsAll(['value1', 'value2']));
    });

    test('delete removes value', () async {
      await dao.put('key1', 'value1');
      await dao.delete('key1');
      expect(await dao.get('key1'), isNull);
    });

    test('clear removes all values', () async {
      await dao.put('key1', 'value1');
      await dao.put('key2', 'value2');
      await dao.clear();
      expect(await dao.getAll(), isEmpty);
    });

    test('watchAll emits updated values', () async {
      final stream = dao.watchAll();

      final expectation = expectLater(
        stream,
        emitsInOrder([
          isEmpty,
          contains('value1'),
          containsAll(['value1', 'value2']),
        ]),
      );

      await Future<void>.delayed(Duration.zero);
      await dao.put('key1', 'value1');
      await dao.put('key2', 'value2');

      await expectation;
    });
  });

  group('HiveDatabaseInitializer Tests', () {
    const channel = MethodChannel('plugins.flutter.io/path_provider');

    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (methodCall) async {
            return '.';
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('initializes and registers adapters', () async {
      final registerer = MockAdapterRegisterer();
      final initializer = HiveDatabaseInitializer(
        registerers: [registerer],
        subDir: 'test_db',
      );

      await initializer.initialize();
      expect(registerer.called, isTrue);

      await initializer.close();
    });
  });
}
