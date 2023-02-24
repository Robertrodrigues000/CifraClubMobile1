import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    final userSongbookDto =
        UserSongbookDto(id: 42, createdAt: DateTime.now(), lastUpdated: DateTime.now(), name: "songbook Name");

    final songbook = userSongbookDto.toDomain();

    expect(userSongbookDto.id, songbook.id);
    expect(userSongbookDto.createdAt, songbook.createdAt);
    expect(userSongbookDto.lastUpdated, songbook.lastUpdated);
    expect(userSongbookDto.name, songbook.name);
  });

  test("When fromDomain is called, should return correct dto entity", () {
    final songbook = Songbook(createdAt: DateTime.now(), lastUpdated: DateTime.now(), name: "Marilia Mendonça", id: 1);

    final userSongbookDto = UserSongbookDto.fromDomain(songbook);

    expect(songbook.id, userSongbookDto.id);
    expect(songbook.createdAt, userSongbookDto.createdAt);
    expect(songbook.lastUpdated, userSongbookDto.lastUpdated);
    expect(songbook.name, userSongbookDto.name);
  });
}
