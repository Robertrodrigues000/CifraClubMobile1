// coverage:ignore-file
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/repository/search_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class Search {
  final SearchRepository searchRepository;

  Search({
    required this.searchRepository,
  });

  CancelableOperation<Result<List<SearchItem>, RequestError>> call(
      {required String query, SearchFilter? searchFilter}) {
    return searchRepository.getAll(query: query, searchFilter: searchFilter);
  }
}
