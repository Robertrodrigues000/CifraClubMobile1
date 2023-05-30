import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/search/models/search.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class SearchRepository {
  Future<Result<List<Search>, RequestError>> getAll({required String query});
  CancelableOperation<Result<List<SongSearch>, RequestError>> getSongs({required String query});
}
