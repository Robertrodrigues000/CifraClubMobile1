import 'package:cifraclub/data/version/models/version/version_data_song_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When `toDomain` is called should convert correctly", () {
    final versionDataSongDto = VersionDataSongDto(
      songId: 1,
      lyricsId: 2,
      name: "name",
      url: "url",
      description: "description",
    );
    final version = versionDataSongDto.toDomain();

    expect(version.songId, 1);
    expect(version.lyricsId, 2);
    expect(version.name, "name");
    expect(version.url, "url");
    expect(version.description, "description");
  });
}
