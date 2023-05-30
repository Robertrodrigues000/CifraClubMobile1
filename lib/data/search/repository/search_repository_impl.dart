import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/search/data_source/search_data_source.dart';
import 'package:cifraclub/domain/search/models/search.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:cifraclub/domain/search/repository/search_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchDataSource searchDataSource;

  SearchRepositoryImpl({required this.searchDataSource});

  @override
  Future<Result<List<Search>, RequestError>> getAll({required String query}) async {
    return (await searchDataSource.getAll(query: query)).map((data) => data.response.toDomain().search);
  }

  @override
  CancelableOperation<Result<List<SongSearch>, RequestError>> getSongs({required String query}) {
    return searchDataSource
        .getSongs(query: query)
        .then((result) => result.map((data) => data.response.toDomain().search.whereType<SongSearch>().toList()));
  }
}
