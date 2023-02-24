import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:isar/isar.dart';

part 'user_genre_dto.g.dart';

@embedded
class UserGenreDto {
  final String name;
  final String url;

  Genre toDomain() {
    return Genre(name: name, url: url);
  }

  UserGenreDto.fromDomain(Genre genre) : this(name: genre.name, url: genre.url);

  UserGenreDto({
    this.name = "",
    this.url = "",
  });
}
