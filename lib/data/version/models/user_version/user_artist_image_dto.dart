import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:isar/isar.dart';

part 'user_artist_image_dto.g.dart';

@embedded
class UserVersionDataArtistImageDto {
  final String? size50;
  final String? size162;
  final String? size250;
  final String? color;

  UserVersionDataArtistImageDto({this.size50, this.size162, this.size250, this.color});

  UserVersionDataArtistImageDto.fromDomain(ArtistImage artistImage)
      : this(
          size50: artistImage.size50,
          size162: artistImage.size162,
          size250: artistImage.size250,
          color: artistImage.color,
        );
}
