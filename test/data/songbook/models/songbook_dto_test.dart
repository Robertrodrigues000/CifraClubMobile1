import 'package:cifraclub/data/songbook/models/songbook_version_artist_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    const songbookVersionDto = SongbookVersionDto(
      type: 1,
      name: "name",
      songUrl: "songUrl",
      songId: 2,
      artist: SongbookVersionArtistDto(id: 3, name: "name", url: "url", image: "image", color: "color"),
      versionId: 3,
      lastUpdate: "2023-05-09 10:26:58",
    );
    final songbookDto = SongbookDto(
        id: 42,
        createdAt: "2022-10-27 15:18:04",
        lastUpdated: "2023-01-16 17:04:38",
        name: "songbook Name",
        type: "recents",
        isPublic: false,
        totalSongs: 0,
        versions: [songbookVersionDto]);

    final songbookVersions = songbookDto.toDomain();

    expect(songbookVersions.songbook.id, songbookDto.id);
    expect(songbookVersions.songbook.createdAt, DateTime.parse(songbookDto.createdAt!));
    expect(songbookVersions.songbook.lastUpdated, DateTime.parse(songbookDto.lastUpdated!));
    expect(songbookVersions.songbook.name, songbookDto.name);
    expect(songbookVersions.songbook.type, ListType.recents);
    expect(songbookVersions.songbook.isPublic, songbookDto.isPublic);
    expect(songbookVersions.songbook.totalSongs, songbookDto.totalSongs);
    expect(songbookVersions.versions.first.instrument, Instrument.guitar);
    expect(songbookVersions.versions.first.name, "name");
    expect(songbookVersions.versions.first.songUrl, "songUrl");
    expect(songbookVersions.versions.first.songId, 2);
    expect(songbookVersions.versions.first.versionId, 3);
    expect(songbookVersions.versions.first.lastUpdate, DateTime(2023, 5, 9, 10, 26, 58));
  });
}
