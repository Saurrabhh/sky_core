import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/src/base/base_state.dart';

/// {@template paginated_state}
/// Standardized generic state representing paginated infinite scrolling lists.
///
/// Extends [BaseState] to inherit loaders and failures, while carrying
/// the accumulated items list, active page, and pagination markers.
/// {@endtemplate}
class PaginatedState<T> extends BaseState {
  /// {@macro paginated_state}
  const PaginatedState({
    required super.isLoading,
    required this.items,
    required this.page,
    required this.hasReachedMax,
    this.searchQuery,
    super.failure,
  });

  /// Creates a default initial [PaginatedState].
  factory PaginatedState.initial() => PaginatedState<T>(
        isLoading: false,
        items: const [],
        page: 1,
        hasReachedMax: false,
      );

  /// The accumulated list of elements fetched across pages so far.
  final List<T> items;

  /// The current page index (1-based index).
  final int page;

  /// Indicates whether the remote data source has been completely exhausted.
  final bool hasReachedMax;

  /// Optional active text query used to filter paginated results.
  final String? searchQuery;

  @override
  PaginatedState<T> copyWith({
    bool? isLoading,
    List<T>? items,
    int? page,
    bool? hasReachedMax,
    String? searchQuery,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return PaginatedState<T>(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        items,
        page,
        hasReachedMax,
        searchQuery,
        failure,
      ];
}
