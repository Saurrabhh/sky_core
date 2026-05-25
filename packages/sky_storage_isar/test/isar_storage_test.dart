import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_storage_isar/sky_storage_isar.dart';

class MockIsar extends Mock implements Isar {}
class MockIsarCollection<T> extends Mock implements IsarCollection<T> {}

class TestModel {
  TestModel({required this.id, required this.name});
  final int id;
  final String name;
}

class MockSchemaProvider implements IsarSchemaProvider {
  @override
  List<CollectionSchema<dynamic>> get schemas => [];
}

void main() {
  group('IsarDao Tests', () {
    late MockIsar mockIsar;
    late MockIsarCollection<TestModel> mockCollection;
    late IsarDao<TestModel> dao;

    setUp(() {
      mockIsar = MockIsar();
      mockCollection = MockIsarCollection<TestModel>();

      // Stub the 'isar' getter on mockCollection
      when(() => mockCollection.isar).thenReturn(mockIsar);

      // Stub writeTxn on mockIsar to immediately execute the callback
      when(() => mockIsar.writeTxn<int>(any()))
          .thenAnswer((invocation) async {
        final callback = invocation.positionalArguments[0]
            as Future<int> Function();
        return callback();
      });

      when(() => mockIsar.writeTxn<bool>(any()))
          .thenAnswer((invocation) async {
        final callback = invocation.positionalArguments[0]
            as Future<bool> Function();
        return callback();
      });

      when(() => mockIsar.writeTxn<void>(any()))
          .thenAnswer((invocation) async {
        final callback = invocation.positionalArguments[0]
            as Future<void> Function();
        return callback();
      });

      when(() => mockIsar.writeTxn<Null>(any()))
          .thenAnswer((invocation) async {
        final callback = invocation.positionalArguments[0]
            as Future<Null> Function();
        return callback();
      });



      dao = IsarDao<TestModel>(collection: mockCollection);
    });

    test('put executes write transaction and puts value', () async {
      final model = TestModel(id: 1, name: 'Test');
      expect(model.id, equals(1));
      expect(model.name, equals('Test'));
      when(() => mockCollection.put(model)).thenAnswer((_) async => 1);

      await dao.put(1, model);

      verify(() => mockIsar.writeTxn<Null>(any())).called(1);
      verify(() => mockCollection.put(model)).called(1);
    });


    test('get retrieves value by ID', () async {
      final model = TestModel(id: 1, name: 'Test');
      when(() => mockCollection.get(1)).thenAnswer((_) async => model);

      final result = await dao.get(1);

      expect(result, equals(model));
      verify(() => mockCollection.get(1)).called(1);
    });

    test('delete executes write transaction and deletes by ID', () async {
      when(() => mockCollection.delete(1)).thenAnswer((_) async => true);

      await dao.delete(1);

      verify(() => mockIsar.writeTxn<Null>(any())).called(1);
      verify(() => mockCollection.delete(1)).called(1);
    });

    test('clear executes write transaction and clears collection', () async {
      when(() => mockCollection.clear()).thenAnswer((_) async => 0);

      await dao.clear();

      verify(() => mockIsar.writeTxn<Null>(any())).called(1);
      verify(() => mockCollection.clear()).called(1);
    });
  });


  group('IsarDatabaseInitializer Tests', () {
    test('exposes properties correctly', () {
      final provider = MockSchemaProvider();
      final initializer = IsarDatabaseInitializer(
        providers: [provider],
        directory: '/dummy/dir',
        name: 'test_db',
        inspector: false,
      );

      expect(
        () => initializer.isar,
        throwsStateError,
      );
    });
  });
}
