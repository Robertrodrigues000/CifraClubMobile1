import 'package:cifraclub/data/version/models/user_version/user_version_data_genre_images_dto.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:isar/isar.dart';

part 'user_version_data_genre_dto.g.dart';

@embedded
class UserVersionDataGenreDto {
  late final String name;
  late final String url;
  late final UserVersionDataGenreImagesDto? genreImages;

  UserVersionDataGenreDto(); // coverage:ignore-line

  UserVersionDataGenreDto.fromDomain(Genre genre) {
    name = genre.name;
    url = genre.url;
    genreImages = genre.genreImages != null ? UserVersionDataGenreImagesDto.fromDomain(genre.genreImages!) : null;
  }
}
