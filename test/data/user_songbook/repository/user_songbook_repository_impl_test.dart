import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/data/songbook/repository/user_songbook_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _UserSongbookDataSourceMock extends Mock implements UserSongbookDataSource {}

class _UserSongbookDtoMock extends Mock implements UserSongbookDto {}

void main() {
  setUpAll(() {
    registerFallbackValue(UserSongbookDto(
      id: 0,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
      name: "",
      type: ListTypeDto.user,
      isPublic: false,
      totalSongs: 0,
    ));
  });

  test("When getAllUserSongbooks is called, should return songbook domain entity", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();
    final userSongbookDto = _UserSongbookDtoMock();
    final userSongbookDtoList = [userSongbookDto];
    final songbook = getFakeSongbook();

    when(userSongbookDto.toDomain).thenReturn(songbook);
    when(userSongbookDataSource.getAll).thenAnswer((invocation) => Stream.value(userSongbookDtoList));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);

    final songbookList = await songbookRepository.getAllUserSongbooks().first;

    verify(userSongbookDto.toDomain).called(1);
    verify(userSongbookDataSource.getAll).called(1);

    expect(songbookList.length, userSongbookDtoList.length);
    expect(songbookList.first, songbook);
  });

  test("when insertUserSongbook is called, should return the id of inserted songbook", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();
    final songbook = getFakeSongbook();

    when(() => userSongbookDataSource.insert(any())).thenAnswer((_) => SynchronousFuture(songbook.id!));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final songbookId = await songbookRepository.insertUserSongbook(songbook);

    var userSongbookDto = verify(() => userSongbookDataSource.insert(captureAny())).captured.first as UserSongbookDto;

    expect(userSongbookDto.name, songbook.name);
    expect(songbookId, songbook.id);
  });

  test("when setUserSongbooks is called, should call data source with a mapped object", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();
    final songbook = getFakeSongbook();

    when(() => userSongbookDataSource.setAll(any())).thenAnswer((_) => SynchronousFuture([songbook.id!]));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final ids = await songbookRepository.setUserSongbooks([songbook]);

    var userSongbookDtos =
        verify(() => userSongbookDataSource.setAll(captureAny())).captured.first as List<UserSongbookDto>;

    expect(ids, [songbook.id]);
    expect(userSongbookDtos.first.name, songbook.name);
  });
}
