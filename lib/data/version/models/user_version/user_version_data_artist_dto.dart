import 'package:cifraclub/data/version/models/user_version/user_artist_image_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_genre_dto.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:isar/isar.dart';

part 'user_version_data_artist_dto.g.dart';

@embedded
class UserVersionDataArtistDto {
  late final int id;
  late final String name;
  late final String url;
  late final UserVersionDataGenreDto? genre;
  late final UserVersionDataArtistImageDto? image;

  UserVersionDataArtistDto(); // coverage:ignore-line

  UserVersionDataArtistDto.fromDomain(Artist artist) {
    id = artist.id;
    name = artist.name;
    url = artist.url;
    image = artist.image != null ? UserVersionDataArtistImageDto.fromDomain(artist.image!) : null;
    genre = artist.genre != null ? UserVersionDataGenreDto.fromDomain(artist.genre!) : null;
  }
}
