import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:isar/isar.dart';

part 'user_version_artist_dto.g.dart';

@embedded
class UserVersionArtistDto {
  final int? id;
  final String? name;
  final String? url;
  final String? color;

  UserVersionArtistDto({
    this.id,
    this.name,
    this.url,
    this.color,
  });

  UserVersionArtistDto.fromDomain(Artist artist)
      : this(
          color: artist.image?.color,
          id: artist.id,
          name: artist.name,
          url: artist.url,
        );

  Artist toDomain(String? image) => Artist(
        url: url!,
        image: ArtistImage(size50: image, size162: image, size250: image, color: color),
        name: name!,
        id: id!,
      );
}
