class PaginatedList<T> {
  final List<T> items;
  final bool hasMoreResults;

  const PaginatedList({
    required this.items,
    required this.hasMoreResults,
  });
}
