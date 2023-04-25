import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/new_songbook_response_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
import 'package:cifraclub/data/songbook/repository/songbook_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _SongbookDataSourceMock extends Mock implements SongbookDataSource {}

class _SongbookDtoMock extends Mock implements SongbookDto {}

void main() {
  setUpAll(() {
    registerFallbackValue(SongbookInputDto(name: "name"));
  });

  test("When getAllSongbooks is called, should return songbook domain entity", () async {
    final songbookDataSource = _SongbookDataSourceMock();
    final songbookDto = _SongbookDtoMock();
    final songbookDtoList = [songbookDto];
    final songbook = getFakeSongbook();

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
}
