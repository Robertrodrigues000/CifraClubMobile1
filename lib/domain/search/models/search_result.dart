import 'package:cifraclub/domain/search/models/search_models/search.dart';
import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final List<Search> search;

  const SearchResult({
    required this.search,
  });

  // coverage:ignore-start
  @override
  List<Object> get props => [search];
  // coverage:ignore-end
}
