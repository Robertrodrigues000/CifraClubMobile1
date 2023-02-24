import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';

abstract class GenresRepository {
  Future<Result<AllGenres, RequestError>> getGenres();
  Future<void> setUserGenres(List<Genre> genres);
  Stream<List<Genre>?> getUserGenresAsStream();
}
