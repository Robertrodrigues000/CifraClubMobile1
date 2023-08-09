import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:isar/isar.dart';

part 'user_version_data_song_dto.g.dart';

@embedded
class UserVersionDataSongDto {
  late final int id;
  late final int lyricsId;
  late final String name;
  late final String url;
  late final String description;

  UserVersionDataSongDto();

  UserVersionDataSongDto.fromDomain(VersionDataSong music) {
    id = music.songId;
    lyricsId = music.lyricsId;
    name = music.name;
    url = music.url;
    description = music.description;
  }
}
