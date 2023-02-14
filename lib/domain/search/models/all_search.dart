import 'package:cifraclub/domain/search/models/search.dart';
import 'package:equatable/equatable.dart';

class AllSearch extends Equatable {
  final List<Search> search;

  const AllSearch({
    required this.search,
  });

  @override
  List<Object> get props => [search];
}
