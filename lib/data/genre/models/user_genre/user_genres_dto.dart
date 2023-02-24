import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:isar/isar.dart';

part 'user_genres_dto.g.dart';

@collection
class UserGenresDto {
  static const userGenreId = 1;
  Id id = userGenreId;
  final List<UserGenreDto> genres;

  List<Genre> toDomain() => genres.map((userGenre) => userGenre.toDomain()).toList();

  UserGenresDto({
    required this.genres,
  });
}
