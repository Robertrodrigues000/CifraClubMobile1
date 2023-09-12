import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class SearchRepository {
  CancelableOperation<Result<List<SearchItem>, RequestError>> getAll(
      {required String query, SearchFilter? searchFilter});
  CancelableOperation<Result<List<SongSearch>, RequestError>> getSongs({required String query});
}
