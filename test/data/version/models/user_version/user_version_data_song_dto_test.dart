import 'package:cifraclub/data/version/models/user_version/user_version_data_song_dto.dart';
import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    final music = VersionDataSong(
      songId: 1,
      lyricsId: 2,
      name: "Bohemian Rhapsody",
      url: "https://www.youtube.com/watch?v=fJ9rUt9UM0k",
      description: "The greatest rock song of all time.",
    );

    final userMusicDto = UserVersionDataSongDto.fromDomain(music);

    expect(userMusicDto.id, 1);
    expect(userMusicDto.lyricsId, 2);
    expect(userMusicDto.name, "Bohemian Rhapsody");
    expect(userMusicDto.url, "https://www.youtube.com/watch?v=fJ9rUt9UM0k");
    expect(userMusicDto.description, "The greatest rock song of all time.");
  });
}
