import 'package:cifraclub/domain/genre/entities/all_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class GenresRepository {
  Future<Result<AllGenres, RequestError>> getGenres();
}
