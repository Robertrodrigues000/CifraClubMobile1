import 'package:cifraclub/data/songbook/models/songbook_song_input_dto.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When 'fromDomain' is called should return correct dto entity", () async {
    const song = Version(
      songId: 1,
      type: 2,
      name: "name",
      songUrl: "songUrl",
      capo: 3,
      stdTone: "A",
      tone: "B",
      tuning: "AB",
      artist: Artist(url: "url", image: null, name: "name", id: 4),
      remoteDatabaseID: 5,
      versionId: 12,
    );

    final songbookSongInputDto = SongbookSongInputDto.fromDomain(song);

    expect(song.remoteDatabaseID, songbookSongInputDto.id);
    expect(song.artist.url, songbookSongInputDto.artistUrl);
    expect(song.capo, songbookSongInputDto.capo);
    expect(song.versionId, songbookSongInputDto.versionId);
    expect(song.songUrl, songbookSongInputDto.songUrl);
    expect(song.tone, songbookSongInputDto.tone);
    expect(song.tuning, songbookSongInputDto.tuning);
    expect(song.type, songbookSongInputDto.type);
  });
}
