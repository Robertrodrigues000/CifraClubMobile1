import 'package:cifraclub/data/songbook/models/songbook_cifra_artist_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_cifra_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    const songbookCifraDto = SongbookCifraDto(
      type: 1,
      name: "name",
      songUrl: "songUrl",
      songId: 2,
      artist: SongbookCifraArtistDto(id: 3, name: "name", url: "url", image: "image", color: "color"),
      versionId: 3,
    );
    final songbookDto = SongbookDto(
        id: 42,
        createdAt: "2022-10-27 15:18:04",
        lastUpdated: "2023-01-16 17:04:38",
        name: "songbook Name",
        type: "recents",
        isPublic: false,
        totalSongs: 0,
        cifras: [songbookCifraDto]);

    final songbookCifras = songbookDto.toDomain();

    expect(songbookCifras.songbook.id, songbookDto.id);
    expect(songbookCifras.songbook.createdAt, DateTime.parse(songbookDto.createdAt!));
    expect(songbookCifras.songbook.lastUpdated, DateTime.parse(songbookDto.lastUpdated!));
    expect(songbookCifras.songbook.name, songbookDto.name);
    expect(songbookCifras.songbook.type, ListType.recents);
    expect(songbookCifras.songbook.isPublic, songbookDto.isPublic);
    expect(songbookCifras.songbook.totalSongs, songbookDto.totalSongs);
    expect(songbookCifras.cifras.first.type, 1);
    expect(songbookCifras.cifras.first.name, "name");
    expect(songbookCifras.cifras.first.songUrl, "songUrl");
    expect(songbookCifras.cifras.first.songId, 2);
    expect(songbookCifras.cifras.first.versionId, 3);
  });
}
