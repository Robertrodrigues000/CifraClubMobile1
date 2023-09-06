import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

void main() {
  registerFallbackValue(getFakeSongbook());

  group("When request is successful", () {
    test("should replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final songbook = getFakeSongbook();

      when(() => songbookRepository.addSongbook(
            name: songbook.name,
            isPublic: songbook.isPublic,
            createdAt: songbook.createdAt,
          )).thenAnswer((_) => SynchronousFuture(Ok(songbook)));
      when(() => userSongbookRepository.putUserSongbook(songbook)).thenAnswer((_) => SynchronousFuture(songbook.id!));

      final result = await InsertUserSongbook(songbookRepository, userSongbookRepository)(
        name: songbook.name,
        isPublic: songbook.isPublic,
        createdAt: songbook.createdAt,
      );

      expect(result.isSuccess, isTrue);
      expect(result.getOrThrow().id, songbook.id);
      verify(() => userSongbookRepository.putUserSongbook(songbook)).called(1);
    });
  });

  group("When request fails", () {
    test("should not replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();

      when(() => songbookRepository.addSongbook(
            name: "new",
            isPublic: true,
            createdAt: any(named: "createdAt"),
          )).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

      final result = await InsertUserSongbook(songbookRepository, userSongbookRepository)(name: "new");

      expect(result.isFailure, isTrue);
      verifyNever(() => userSongbookRepository.putUserSongbook(any()));
    });
  });
}
