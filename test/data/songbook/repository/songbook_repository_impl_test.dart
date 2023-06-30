import 'dart:math';

import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/delete_versions_input_dto.dart';
import 'package:cifraclub/data/songbook/models/new_songbook_response_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_songs_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_dto.dart';
import 'package:cifraclub/data/songbook/repository/songbook_repository_impl.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/domain/songbook/models/songbook_versions_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _SongbookDataSourceMock extends Mock implements SongbookDataSource {}

class _SongbookDtoMock extends Mock implements SongbookDto {}

class _SongbookCifraDtoMock extends Mock implements SongbookVersionDto {}

class _SongbookSongsInputFake extends Fake implements SongbookSongsInputDto {}

void main() {
  setUpAll(() {
    registerFallbackValue(SongbookInputDto(name: "name", isPublic: true));
    registerFallbackValue(const DeleteVersionsInputDto([0]));
    registerFallbackValue(_SongbookSongsInputFake());
  });

  test("When getAllSongbooks is called, should return songbook domain entity", () async {
    final songbookDataSource = _SongbookDataSourceMock();
    final songbookDto = _SongbookDtoMock();
    final songbookDtoList = [songbookDto];
    final songbook = getFakeSongbookVersions();

    when(songbookDto.toDomain).thenReturn(songbook);
    when(songbookDataSource.getAll).thenAnswer((invocation) => SynchronousFuture(Ok(songbookDtoList)));

    final songbookRepository = SongbookRepositoryImpl(songbookDataSource);
    final result = await songbookRepository.getAllSongbooks();

    verify(songbookDto.toDomain).called(1);
    verify(songbookDataSource.getAll).called(1);

    expect(result.get()!.length, songbookDtoList.length);
    expect(result.get()!.first, songbook);
  });

  test("when insertUserSongbook is called, should return the id of inserted songbook", () async {
    final songbookDataSource = _SongbookDataSourceMock();
    final songbook = getFakeSongbook();
    final response = NewSongbookResponseDto(
      id: songbook.id!,
      name: songbook.name,
      isPublic: songbook.isPublic ? 1 : 0,
    );
    when(() => songbookDataSource.insertSongbook(any())).thenAnswer((_) => SynchronousFuture(Ok(response)));

    final songbookRepository = SongbookRepositoryImpl(songbookDataSource);
    final result = await songbookRepository.insertSongbook(
        name: songbook.name, isPublic: songbook.isPublic, createdAt: songbook.createdAt);

    expect(result.getOrThrow().id, songbook.id);
  });

  test("When deleteSongbook is called should delete a songbook", () async {
    final songbookDataSource = _SongbookDataSourceMock();
    when(() => songbookDataSource.deleteSongbook(captureAny())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    final songbookRepository = SongbookRepositoryImpl(songbookDataSource);
    final songbookId = Random().nextInt(1000);
    final result = await songbookRepository.deleteSongbook(songbookId);

    final requestParam = verify(() => songbookDataSource.deleteSongbook(captureAny())).captured.first;

    expect(result.isSuccess, isTrue);

    expect(requestParam, songbookId);
  });

  group("When updateSongbookData is called", () {
    test("and request is successful should update songbook on API", () async {
      final songbookDataSource = _SongbookDataSourceMock();
      when(() => songbookDataSource.updateSongbookData(any(), any()))
          .thenAnswer((_) => SynchronousFuture(const Ok(null)));

      final songbookRepository = SongbookRepositoryImpl(songbookDataSource);
      final result = await songbookRepository.updateSongbookData(
        lastUpdated: DateTime.now(),
        songbookId: 0,
        name: "New Songbook",
        isPublic: true,
      );

      expect(result.isSuccess, isTrue);
    });

    test("and request fails should return request error", () async {
      final songbookDataSource = _SongbookDataSourceMock();
      when(() => songbookDataSource.updateSongbookData(any(), any()))
          .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

      final songbookRepository = SongbookRepositoryImpl(songbookDataSource);
      final result = await songbookRepository.updateSongbookData(
        lastUpdated: DateTime.now(),
        songbookId: 0,
        name: "New Songbook",
        isPublic: true,
      );

      expect(result.isFailure, isTrue);
      expect(result.getError(), isA<ServerError>());
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When deleteCifras is called", () {
    const songbookId = 0;

    test("and request is sucessful should return sucess", () async {
      final songbookDataSource = _SongbookDataSourceMock();

      when(() => songbookDataSource.deleteVersions(any(), any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

      final songbookRepositoryImpl = SongbookRepositoryImpl(songbookDataSource);

      final result = await songbookRepositoryImpl.deleteVersions(songbookId: songbookId, versionsId: [0]);

      expect(result.isSuccess, isTrue);
    });

    test("and request fails should return request error", () async {
      final songbookDataSource = _SongbookDataSourceMock();

      when(() => songbookDataSource.deleteVersions(any(), any()))
          .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

      final songbookRepositoryImpl = SongbookRepositoryImpl(songbookDataSource);

      final result = await songbookRepositoryImpl.deleteVersions(songbookId: songbookId, versionsId: [0]);

      expect(result.isFailure, isTrue);
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
    });
  });

  group("When 'addCifrasToSongbook' is called", () {
    test("and request is sucessful should return song list", () async {
      final songbookDataSource = _SongbookDataSourceMock();
      final songDto = _SongbookCifraDtoMock();
      final songsDto = [songDto];
      final song = getFakeVersion();

      when(() => songbookDataSource.addSongsToSongbook(any(), any()))
          .thenAnswer((_) => SynchronousFuture(Ok(songsDto)));
      when(songDto.toDomain).thenReturn(song);

      final songbookRepositoryImpl = SongbookRepositoryImpl(songbookDataSource);
      final result = await songbookRepositoryImpl.addSongsToSongbook(songbookId: 1, songs: [song]);

      verify(songDto.toDomain).called(1);

      expect(result.isSuccess, isTrue);
      expect(result.get(), [song]);
    });

    test("and request fails should return request error", () async {
      final songbookDataSource = _SongbookDataSourceMock();
      final song = getFakeVersion();

      when(() => songbookDataSource.addSongsToSongbook(any(), any()))
          .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

      final songbookRepositoryImpl = SongbookRepositoryImpl(songbookDataSource);

      final result = await songbookRepositoryImpl.addSongsToSongbook(songbookId: 10, songs: [song]);

      expect(result.isFailure, isTrue);
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
    });
  });
}
