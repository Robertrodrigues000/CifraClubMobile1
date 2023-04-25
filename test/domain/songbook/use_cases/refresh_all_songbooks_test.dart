import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

void main() {
  registerFallbackValue([getFakeSongbook()]);

  group("When request is successful", () {
    test("should replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final songbooks = [getFakeSongbook(), getFakeSongbook(), getFakeSongbook()];

      when(songbookRepository.getAllSongbooks).thenAnswer((_) => SynchronousFuture(Ok(songbooks)));
      when(() => userSongbookRepository.setUserSongbooks(songbooks))
          .thenAnswer((_) => SynchronousFuture(songbooks.map((e) => e.id!).toList(growable: false)));

      final result = await RefreshAllSongbooks(songbookRepository, userSongbookRepository)();

      expect(result.isSuccess, isTrue);

      expect(result.getOrThrow(), songbooks);
      verify(() => userSongbookRepository.setUserSongbooks(songbooks)).called(1);
    });
  });

  group("When request fails", () {
    test("should not replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();

      when(songbookRepository.getAllSongbooks).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

      final result = await RefreshAllSongbooks(songbookRepository, userSongbookRepository)();

      expect(result.isFailure, isTrue);
      verifyNever(() => userSongbookRepository.setUserSongbooks(any()));
    });
  });
}
