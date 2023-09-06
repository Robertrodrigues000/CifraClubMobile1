import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/data/songbook/repository/user_songbook_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

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
      preview: const [],
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

    when(() => userSongbookDataSource.put(any())).thenAnswer((_) => SynchronousFuture(songbook.id!));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final songbookId = await songbookRepository.putUserSongbook(songbook);

    var userSongbookDto = verify(() => userSongbookDataSource.put(captureAny())).captured.first as UserSongbookDto;

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

  group("when deleteSongbook is called", () {
    test("and is sucess should return true", () async {
      final userSongbookDataSource = _UserSongbookDataSourceMock();

      when(() => userSongbookDataSource.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(true));

      final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
      final response = await songbookRepository.deleteUserSongbook(1000);

      var id = verify(() => userSongbookDataSource.deleteSongbook(captureAny())).captured.first as int;

      expect(response, isTrue);
      expect(id, 1000);
    });

    test("and is fails should return false", () async {
      final userSongbookDataSource = _UserSongbookDataSourceMock();

      when(() => userSongbookDataSource.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(false));

      final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
      final response = await songbookRepository.deleteUserSongbook(1000);

      var id = verify(() => userSongbookDataSource.deleteSongbook(captureAny())).captured.first as int;

      expect(response, isFalse);
      expect(id, 1000);
    });
  });

  test("when getTotalSongbooks is called, should return the total of user songbooks", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();

    when(userSongbookDataSource.getTotalSongbooks).thenAnswer((invocation) => Stream.value(10));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final totalSongbooks = await songbookRepository.getTotalSongbooks().first;

    expect(totalSongbooks, 10);
  });

  test("when getSongbookById is called, should return the songbook with correct id", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();
    final songbookDto = _UserSongbookDtoMock();
    final songbook = getFakeSongbook();

    when(songbookDto.toDomain).thenReturn(songbook);
    when(() => userSongbookDataSource.getSongbookById(songbook.id!)).thenAnswer((_) => SynchronousFuture(songbookDto));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final result = await songbookRepository.getSongbookById(songbook.id!);

    verify(songbookDto.toDomain).called(1);
    expect(result!.id, songbook.id);
    expect(result.name, songbook.name);
  });

  test("when getSongbookStreamById is called, should return the songbook with correct id", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();
    final songbookDto = _UserSongbookDtoMock();
    final songbook = getFakeSongbook();

    when(songbookDto.toDomain).thenReturn(songbook);
    when(() => userSongbookDataSource.getSongbookStreamById(songbook.id!))
        .thenAnswer((_) => BehaviorSubject.seeded(songbookDto));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final result = songbookRepository.getSongbookStreamById(songbook.id!);

    expect(result, emits(songbook));
  });

  test("when updateSongbookPreview is called, should return id of songbook updated", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();
    final songbook = getFakeSongbook();

    when(() => userSongbookDataSource.updatePreview(songbook.id!, ["image1"]))
        .thenAnswer((_) => SynchronousFuture(songbook.id!));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final result = await songbookRepository.updateSongbookPreview(songbook.id!, ["image1"]);

    expect(result, songbook.id);
  });

  test("when deleteAll is called should call data source", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();

    when(userSongbookDataSource.deleteAll).thenAnswer((_) => SynchronousFuture(null));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    await songbookRepository.deleteAll();

    verify(userSongbookDataSource.deleteAll).called(1);
  });

  test("when updateTotalSongs is called, should return id of songbook updated", () async {
    final userSongbookDataSource = _UserSongbookDataSourceMock();
    final songbook = getFakeSongbook();

    when(() => userSongbookDataSource.updateTotalSongs(songbook.id!))
        .thenAnswer((_) => SynchronousFuture(songbook.id!));

    final songbookRepository = UserSongbookRepositoryImpl(userSongbookDataSource);
    final result = await songbookRepository.updateTotalSongs(songbookId: songbook.id!);

    expect(result, songbook.id);
  });
}
