import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/base_cubit.dart';
import 'package:sky_bloc/src/pagination/paginated_state.dart';

/// {@template paginated_cubit}
/// A highly generic, production-ready [BaseCubit] for handling paginated lists.
///
/// Manages scroll updates, fetch guards (ignoring actions when already loading
/// or completed), pull-to-refresh actions, and filtered searches.
///
/// Subclasses simply implement [fetchItems] to map data from UseCases.
/// {@endtemplate}
abstract class PaginatedCubit<T> extends BaseCubit<PaginatedState<T>> {
  /// {@macro paginated_cubit}
  PaginatedCubit({
    this.pageSize = 20,
  }) : super(PaginatedState<T>.initial());

  /// The standard number of items fetched per paginated request.
  final int pageSize;

  /// Fetches a list page from UseCases or Repositories.
  ///
  /// Subclasses override this method to feed data into the pagination runner.
  Future<Either<Failure, List<T>>> fetchItems(PaginationParams params);

  /// Triggers loading the next page of items.
  ///
  /// Safe to call repeatedly: will return early if a fetch operation is active
  /// or if the list has already reached the maximum end
  /// ([PaginatedState.hasReachedMax]).
  Future<void> loadNextPage() async {
    if (state.isLoading || state.hasReachedMax) return;

    setLoading(isLoading: true);

    final params = PaginationParams(
      page: state.page,
      limit: pageSize,
      searchQuery: state.searchQuery,
    );

    final result = await fetchItems(params);

    result.fold(
      handleFailure,
      (newItems) {
        final isLastPage = newItems.length < pageSize;
        emit(
          state.copyWith(
            isLoading: false,
            items: List<T>.from(state.items)..addAll(newItems),
            page: state.page + 1,
            hasReachedMax: isLastPage,
            clearFailure: true,
          ),
        );
      },
    );
  }

  /// Resets and refreshes the paginated list, fetching page 1 again.
  Future<void> refresh() async {
    emit(
      state.copyWith(
        isLoading: false,
        items: const [],
        page: 1,
        hasReachedMax: false,
        clearFailure: true,
      ),
    );
    await loadNextPage();
  }

  /// Triggers a text search filter, resetting the list to page 1.
  Future<void> search(String? query) async {
    emit(
      state.copyWith(
        isLoading: false,
        items: const [],
        page: 1,
        hasReachedMax: false,
        searchQuery: query,
        clearFailure: true,
      ),
    );
    await loadNextPage();
  }
}
