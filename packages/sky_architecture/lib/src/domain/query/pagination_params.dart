import 'package:equatable/equatable.dart';

/// {@template pagination_params}
/// Standardized model representing pagination, filtering, and sorting
/// parameters.
///
/// Used as input parameters for paginated list query use cases and
/// repositories.
/// {@endtemplate}
class PaginationParams extends Equatable {
  /// {@macro pagination_params}
  const PaginationParams({
    this.page = 1,
    this.limit = 20,
    this.searchQuery,
    this.sortBy,
    this.descending = false,
    this.filters,
  }) : assert(page > 0, 'Page number must be greater than 0'),
       assert(limit > 0, 'Page limit must be greater than 0');

  /// The page number to retrieve (1-based index).
  final int page;

  /// The maximum number of items to return in the page.
  final int limit;

  /// An optional text search filter query.
  final String? searchQuery;

  /// An optional field name to sort the result list by.
  final String? sortBy;

  /// Whether the sorting order is descending.
  final bool descending;

  /// Optional unstructured map criteria for custom category or attribute
  /// filtering.
  final Map<String, dynamic>? filters;

  /// Calculates the zero-based item offset for databases.
  int get offset => (page - 1) * limit;

  /// Creates a copy of this [PaginationParams] but with the given fields
  /// replaced.
  PaginationParams copyWith({
    int? page,
    int? limit,
    String? searchQuery,
    String? sortBy,
    bool? descending,
    Map<String, dynamic>? filters,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      descending: descending ?? this.descending,
      filters: filters ?? this.filters,
    );
  }

  @override
  List<Object?> get props => [
        page,
        limit,
        searchQuery,
        sortBy,
        descending,
        filters,
      ];
}
