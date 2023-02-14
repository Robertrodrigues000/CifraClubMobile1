import 'package:cifraclub/domain/search/models/search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class SearchRepository {
  Future<Result<List<Search>, RequestError>> getAll({required String query});
}
