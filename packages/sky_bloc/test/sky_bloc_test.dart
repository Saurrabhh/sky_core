import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

// --- Test Mocks ---

class TestState extends BaseState {
  const TestState({
    required super.isLoading,
    this.data = '',
    super.failure,
  });

  final String data;

  @override
  TestState copyWith({
    bool? isLoading,
    String? data,
    Failure? failure,
  }) {
    return TestState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [...super.props, data];
}

class TestBloc extends BaseBloc<BaseEvent, TestState> {
  TestBloc() : super(const TestState(isLoading: false)) {
    on<BaseStartedEvent>((event, emit) {
      setLoading(isLoading: true);
    });
  }
}

class TestPaginatedCubit extends PaginatedCubit<String> {
  TestPaginatedCubit({
    required this.fetchMock,
    super.pageSize = 2,
  });

  final Future<Either<Failure, List<String>>> Function(PaginationParams)
      fetchMock;

  @override
  Future<Either<Failure, List<String>>> fetchItems(PaginationParams params) {
    return fetchMock(params);
  }
}

class MemoryLogger extends SkyLogger {
  final List<String> logs = [];

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    logs.add('${level.name}: $message');
  }
}

void main() {
  group('BaseState & BaseBloc', () {
    test('setLoading updates loading status correctly', () {
      final bloc = TestBloc();
      expect(bloc.state.isLoading, isFalse);

      bloc.setLoading(isLoading: true);
      expect(bloc.state.isLoading, isTrue);
    });

    test('handleFailure maps failure and turns off loading', () {
      final bloc = TestBloc();
      const failure = ServerFailure(message: 'API Failure');

      bloc.handleFailure(failure);
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.failure, equals(failure));
    });
  });

  group('DataState Exhaustive Union', () {
    test('performs native Dart 3 exhaustive compile-time switches', () {
      const DataState<int> successState = DataSuccess<int>(100);

      final message = switch (successState) {
        DataInitial() => 'initial',
        DataLoading() => 'loading',
        DataSuccess(data: final val) => 'success: $val',
        DataFailure(failure: final f) => 'failure: ${f.message}',
      };

      expect(message, equals('success: 100'));
    });
  });

  group('TelemetryBlocObserver Logs', () {
    late MemoryLogger logger;

    setUp(() {
      logger = MemoryLogger();
      SkyLogging.instance.clearLoggers();
      SkyLogging.instance.registerLogger(logger);
    });

    tearDown(SkyLogging.instance.clearLoggers);

    test('records lifecycle creations and transitions', () {
      const observer = TelemetryBlocObserver();
      final bloc = TestBloc();

      observer.onCreate(bloc);
      expect(logger.logs, hasLength(1));
      expect(logger.logs.first, contains('debug: BLoC Created: TestBloc'));

      observer.onChange(
        bloc,
        const Change(
          currentState: TestState(isLoading: false),
          nextState: TestState(isLoading: true),
        ),
      );
      expect(logger.logs, hasLength(2));
      expect(
        logger.logs.last,
        contains('debug: BLoC Change (TestBloc): TestState -> TestState'),
      );
    });
  });

  group('PaginatedCubit Infinite Scroll Logic', () {
    test('loadNextPage gets items, sets page, and completes hasReachedMax',
        () async {
      final cubit = TestPaginatedCubit(
        fetchMock: (params) async {
          if (params.page == 1) {
            return Either.right(['page1_1', 'page1_2']);
          } else {
            return Either.right(['page2_1']);
          }
        },
      );

      expect(cubit.state.items, isEmpty);
      expect(cubit.state.page, equals(1));
      expect(cubit.state.hasReachedMax, isFalse);

      await cubit.loadNextPage();
      expect(cubit.state.items, equals(['page1_1', 'page1_2']));
      expect(cubit.state.page, equals(2));
      expect(cubit.state.hasReachedMax, isFalse);

      // Emits 1 item, which is < limit of 2 -> reaches end
      await cubit.loadNextPage();
      expect(cubit.state.items, equals(['page1_1', 'page1_2', 'page2_1']));
      expect(cubit.state.page, equals(3));
      expect(cubit.state.hasReachedMax, isTrue);
    });

    test('refresh and search triggers clear states correctly', () async {
      var callCount = 0;
      final cubit = TestPaginatedCubit(
        pageSize: 3,
        fetchMock: (params) async {
          callCount++;
          return Either.right(['entry_$callCount']);
        },
      );

      await cubit.loadNextPage();
      expect(cubit.state.items, equals(['entry_1']));

      await cubit.refresh();
      expect(cubit.state.items, equals(['entry_2']));
      expect(cubit.state.page, equals(2));

      await cubit.search('search_query');
      expect(cubit.state.searchQuery, equals('search_query'));
      expect(cubit.state.items, equals(['entry_3']));
    });
  });
}
