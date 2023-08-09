import 'package:cifraclub/domain/genre/models/genre_images.dart';
import 'package:isar/isar.dart';

part 'user_version_data_genre_images_dto.g.dart';

@embedded
class UserVersionDataGenreImagesDto {
  final String? light;
  final String? lightInactive;
  final String? dark;
  final String? darkInactive;

  UserVersionDataGenreImagesDto({this.dark, this.darkInactive, this.light, this.lightInactive});

  UserVersionDataGenreImagesDto.fromDomain(GenreImages images)
      : this(
          dark: images.dark,
          darkInactive: images.darkInactive,
          light: images.light,
          lightInactive: images.lightInactive,
        );
}
