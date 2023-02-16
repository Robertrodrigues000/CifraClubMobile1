// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:isar/isar.dart';

part 'user_genres_dto.g.dart';

@collection
class UserGenresDto {
  static const userGenreId = 1;
  Id id = userGenreId;
  List<UserGenreDto> genres;

  List<Genre> toDomain() => genres.map((userGenre) => userGenre.toDomain()).toList();

  UserGenresDto({
    this.genres = const [],
  });
}
