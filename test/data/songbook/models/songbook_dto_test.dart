import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    final songbookDto = SongbookDto(
        id: 42,
        createdAt: "2022-10-27 15:18:04",
        lastUpdated: "2023-01-16 17:04:38",
        name: "songbook Name",
        type: "recents",
        isPublic: false,
        totalSongs: 0);

    final songbook = songbookDto.toDomain();

    expect(songbookDto.id, songbook.id);
    expect(songbook.createdAt, DateTime.parse(songbookDto.createdAt!));
    expect(songbook.lastUpdated, DateTime.parse(songbookDto.lastUpdated!));
    expect(songbookDto.name, songbook.name);
    expect(songbook.type, ListType.recents);
    expect(songbookDto.isPublic, songbook.isPublic);
    expect(songbookDto.totalSongs, songbook.totalSongs);
  });
}
