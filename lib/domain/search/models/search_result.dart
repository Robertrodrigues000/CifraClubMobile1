import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final List<SearchItem> search;

  const SearchResult({
    required this.search,
  });

  // coverage:ignore-start
  @override
  List<Object> get props => [search];
  // coverage:ignore-end
}
