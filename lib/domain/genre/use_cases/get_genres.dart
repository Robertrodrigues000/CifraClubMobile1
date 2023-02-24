// coverage:ignore-file

import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/repository/genres_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetGenres {
  final GenresRepository genresRepository;

  GetGenres({
    required this.genresRepository,
  });

  Future<Result<AllGenres, RequestError>> call() {
    return genresRepository.getGenres();
  }
}
