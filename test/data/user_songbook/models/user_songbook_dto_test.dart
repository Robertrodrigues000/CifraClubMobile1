import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    final userSongbookDto = UserSongbookDto(
        id: 42,
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
        name: "songbook Name",
        type: ListTypeDto.user,
        isPublic: false,
        totalSongs: 0);

    final songbook = userSongbookDto.toDomain();

    expect(songbook.id, userSongbookDto.id);
    expect(songbook.createdAt, userSongbookDto.createdAt);
    expect(songbook.lastUpdated, userSongbookDto.lastUpdated);
    expect(songbook.name, userSongbookDto.name);
    expect(songbook.type, ListType.user);
    expect(songbook.isPublic, userSongbookDto.isPublic);
    expect(songbook.totalSongs, userSongbookDto.totalSongs);
  });

  test("When fromDomain is called, should return correct dto entity", () {
    final songbook = Songbook(
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
        name: "Marilia Mendonça",
        id: 1,
        type: ListType.user,
        isPublic: false,
        totalSongs: 0);

    final userSongbookDto = UserSongbookDto.fromDomain(songbook);

    expect(userSongbookDto.id, songbook.id);
    expect(userSongbookDto.createdAt, songbook.createdAt);
    expect(userSongbookDto.lastUpdated, songbook.lastUpdated);
    expect(userSongbookDto.name, songbook.name);
    expect(userSongbookDto.type, ListTypeDto.user);
    expect(userSongbookDto.isPublic, songbook.isPublic);
    expect(userSongbookDto.totalSongs, songbook.totalSongs);
  });
}
