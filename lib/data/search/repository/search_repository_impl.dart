import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/search/data_source/search_data_source.dart';
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/repository/search_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchDataSource searchDataSource;

  SearchRepositoryImpl({required this.searchDataSource});

  @override
  CancelableOperation<Result<List<SearchItem>, RequestError>> getAll(
      {required String query, SearchFilter? searchFilter}) {
    return searchDataSource
        .getAll(query: query, search: searchFilter?.searchType)
        .then((result) => result.map((data) => data.response.toDomain().search));
  }

  @override
  CancelableOperation<Result<List<SongSearch>, RequestError>> getSongs({required String query}) {
    return searchDataSource
        .getSongs(query: query)
        .then((result) => result.map((data) => data.response.toDomain().search.whereType<SongSearch>().toList()));
  }
}
