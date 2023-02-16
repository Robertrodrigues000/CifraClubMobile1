// coverage:ignore-file
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/repository/genres_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetUserGenres {
  final GenresRepository genresRepository;

  SetUserGenres({
    required this.genresRepository,
  });

  Future<void> call(List<Genre> genres) => genresRepository.setUserGenres(genres);
}
